# Terraform Course — Continuation Plan (Day 4 gap-fill → Day 7)

Based on a review of your repo (`chouleang/terraform-course`). Days 1-3 are solid.
Day 4 is 60% done (loops ✅, dynamic ✅, provisioners ✅ — conditionals ❌, workspaces ❌, import ❌).
This plan finishes Day 4, then adds the exam-critical topics you haven't touched yet,
and ends with an actual **website deployment** project, since none of your labs so far
serve a website (they're all bare EC2 + security groups).

Match your existing repo style: one folder per topic, `main.tf` / `variables.tf` / `outputs.tf` / `terraform.tf`.

---

## DAY 4 (finish) — Conditionals, Workspaces, Import

You already have `4_1_loops`, `4_2_dynamic`, `4_4_provisioners`. Fill in the rest.

### `4_3_conditionals/` (currently empty — build this)
- Ternary operator: `instance_type = var.environment == "prod" ? "t3.large" : "t2.micro"`
- Conditional resource creation with `count = var.create_db ? 1 : 0`
- Safe output access with `try()`

```hcl
variable "environment" {
  type    = string
  default = "dev"
}

resource "aws_instance" "conditional_demo" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.environment == "prod" ? "t3.large" : "t2.micro"
  tags = { Name = "conditional-${var.environment}" }
}

resource "aws_db_instance" "main" {
  count = var.environment == "prod" ? 1 : 0
  # ... only created when environment == prod
}

output "db_endpoint" {
  value = try(aws_db_instance.main[0].endpoint, "no-db-created")
}
```

### `4_5_workspaces/` (new folder — wasn't scaffolded at all)
- `terraform workspace new dev`, `terraform workspace new prod`
- Reference `terraform.workspace` to change behavior per environment
- Understand: each workspace gets its **own state file**, same config

```hcl
locals {
  instance_types = {
    default = "t2.micro"
    dev     = "t2.micro"
    prod    = "t3.large"
  }
}

resource "aws_instance" "app" {
  instance_type = local.instance_types[terraform.workspace]
  tags = { Workspace = terraform.workspace }
}
```
Run: `terraform workspace new dev && terraform apply`, then `terraform workspace new prod && terraform apply` — compare state files with `terraform workspace list`.

### `4_6_import/` (currently empty — build this)
- Manually create a small resource (e.g. an S3 bucket) in the AWS Console
- Write matching `.tf` config for it (empty resource block is fine to start)
- `terraform import aws_s3_bucket.existing <bucket-name>`
- Run `terraform plan` and reconcile any differences until plan shows no changes

**Exam note:** import only writes to *state*, never generates `.tf` code for you (in 1.12 there's `terraform plan -generate-config-out=` which helps — try it here too).

---

## DAY 5 — Lifecycle, Dependencies, Custom Conditions (exam-critical, currently missing)

### `5_1_lifecycle_depends_on/`
- `lifecycle { create_before_destroy = true }` — avoid downtime on replacement
- `lifecycle { prevent_destroy = true }` — protect critical resources
- `lifecycle { ignore_changes = [tags] }` — ignore out-of-band changes
- Explicit `depends_on` — only when Terraform can't infer the order from references (e.g. IAM propagation delays, `null_resource` triggers)

```hcl
resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_s3_bucket_policy" "example" {
  bucket = aws_s3_bucket.site.id
  policy = data.aws_iam_policy_document.site.json
  depends_on = [aws_s3_bucket_public_access_block.site]
}
```

### `5_2_custom_conditions/`
- `precondition` — validate assumptions *before* a resource is created
- `postcondition` — validate the actual result *after* creation

```hcl
resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type

  lifecycle {
    postcondition {
      condition     = self.instance_state == "running"
      error_message = "Instance did not reach a running state."
    }
  }
}

variable "instance_type" {
  type = string
  validation {
    condition     = can(regex("^t[23]\\.", var.instance_type))
    error_message = "Only t2/t3 instance types are allowed."
  }
}
```

---

## DAY 6 — State Refactoring, Drift, Sensitive Data, HCP Terraform

### `6_1_state_refactor/`
- Introduce drift: change a tag manually in the AWS Console, then `terraform plan` to detect it
- `moved` block — rename a resource without destroying/recreating it
- `removed` block — drop a resource from management without destroying the real infra
- State commands: `terraform state list`, `state show`, `state mv`, `state rm`

```hcl
moved {
  from = aws_instance.app_server
  to   = aws_instance.web_server
}

removed {
  from = aws_instance.legacy
  lifecycle {
    destroy = false   # keep the real resource, just stop managing it
  }
}
```

### `6_2_sensitive_ephemeral/`
- `sensitive = true` on variables/outputs (you've done this already in Day 2 — extend it)
- **Ephemeral values** — computed but never written to state or plan output
- **Write-only arguments** — accept a secret as input but never expose it back

```hcl
variable "db_password" {
  type      = string
  sensitive = true
}

# Terraform 1.11+/1.12 ephemeral resource example
ephemeral "random_password" "db" {
  length = 16
}

resource "aws_db_instance" "main" {
  # write-only argument: accepted, never stored in state
  password_wo         = ephemeral.random_password.db.result
  password_wo_version = 1
}
```

### `6_3_hcp_terraform/`
- Free HCP Terraform account: create an Organization → Project → Workspace
- Connect your GitHub repo (VCS-driven workspace) vs. CLI-driven workspace
- Add a variable set, trigger a run from a git push
- (Optional, if time) attach a simple OPA/Sentinel policy to the project

No local `.tf` needed for this one — it's mostly console/workflow practice, but document your steps in a `6_3_hcp_terraform/README.md` for your own reference.

---

## DAY 7 — Website Deployment Project + Full Review

This is the piece your repo is missing entirely — everything so far provisions compute (EC2), not a served website. Build this as `7_website_project/`.

### Structure
```
7_website_project/
├── modules/
│   └── static_site/
│       ├── main.tf       # S3 bucket + policy + CloudFront distribution
│       ├── variables.tf
│       └── outputs.tf
├── main.tf                # calls the module
├── variables.tf
├── outputs.tf
├── backend.tf              # reuse your existing S3 remote backend pattern
└── index.html               # simple test page to upload
```

### Key resources to include
- `aws_s3_bucket` (private) + `aws_s3_bucket_website_configuration` or, better for production, private bucket + `aws_cloudfront_distribution` with Origin Access Control
- `aws_s3_bucket_policy` restricting access to CloudFront only
- `aws_s3_object` to upload `index.html`
- CloudFront distribution with `lifecycle { create_before_destroy = true }` (ties back to Day 5)
- Output the CloudFront domain name as the live URL

This project should reuse everything you've already learned: modules (Day 3), variables/locals (Day 2), `count`/`for_each` if you add multiple pages, `lifecycle` and `depends_on` (Day 5), and a remote backend (Day 2).

### Full review
- Re-run every folder from `1/` through `7/` end to end without notes: `init → plan → apply → destroy`
- Fix `4_3_conditionals` and `4_6_import` if still incomplete
- Do a timed run-through of exam sample questions
- Update each folder's README so it actually reflects what's implemented (a few currently overclaim, e.g. Day 4's workspaces section)

---

## Quick Gap Checklist (tick off as you go)

- [ ] 4_3_conditionals — implement (currently empty)
- [ ] 4_5_workspaces — create (didn't exist)
- [ ] 4_6_import — implement (currently empty)
- [ ] 5_1_lifecycle_depends_on
- [ ] 5_2_custom_conditions
- [ ] 6_1_state_refactor (moved/removed + drift)
- [ ] 6_2_sensitive_ephemeral
- [ ] 6_3_hcp_terraform
- [ ] 7_website_project (S3 + CloudFront)
- [ ] Full re-run of all folders end-to-end
- [ ] Exam sample questions
