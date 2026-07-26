# 7-Day Terraform Crash Course — Exam Prep + Website Deployment

**Target:** HashiCorp Certified: Terraform Associate (004) — current exam version, testing Terraform 1.12
**Format:** 60-min online proctored exam, closed-book, multiple choice/multi-select
**Hands-on project:** Deploy a static website on AWS using S3 + CloudFront (running through all 7 days)
**Time needed:** ~4-6 hours/day

> Official references to keep open all week:
> - Learning path: developer.hashicorp.com/terraform/tutorials/certification-004
> - Sample questions: developer.hashicorp.com/terraform/tutorials/certification-004/associate-questions-004

---

## Day 1 — IaC Fundamentals + Core Workflow
**Exam objectives covered:** IaC concepts; Terraform basics; CLI workflow

- What is Infrastructure as Code: declarative vs. imperative, idempotency, drift
- Install Terraform, set up AWS provider + credentials
- Core workflow: `terraform init` → `fmt` → `validate` → `plan` → `apply` → `destroy`
- Providers, `required_providers`, provider versions, the dependency lock file (`.terraform.lock.hcl`)

**Hands-on:** Write your first config — an S3 bucket for website hosting. Run the full CLI cycle end-to-end and get comfortable reading `plan` output.

---

## Day 2 — HCL, Variables, Outputs, Data Types
**Exam objectives covered:** Configuration language and data handling

- Resources vs. data sources; arguments vs. attributes; computed values
- Variables: types (string, number, bool, list, set, map, object, tuple), defaults, validation blocks
- Outputs, `sensitive = true`, local values, built-in functions, dynamic blocks

**Hands-on:** Parameterize your S3 site — bucket name, region, index/error documents as variables. Add a `validation` block (e.g. enforce lowercase bucket names). Output the website endpoint URL.

---

## Day 3 — Modules
**Exam objectives covered:** Modules — using, authoring, versioning

- Module structure: `variables.tf`, `outputs.tf`, `main.tf`, README
- Sourcing modules: local path, Registry, Git/VCS; version constraints
- Passing variables in, outputs between modules; module composition

**Hands-on:** Refactor your website config into a reusable `s3-static-site` module. Call it from a root module with your own variables passed in.

---

## Day 4 — State, Backends, Drift, Import
**Exam objectives covered:** State management, backends, drift, moved/removed blocks, import

- Local vs. remote state, why remote state + locking matters
- Migrate to a remote backend (S3 backend + DynamoDB lock table, or Terraform Cloud)
- Detect and reconcile drift; `moved` and `removed` blocks for safe refactors
- `terraform import`, and key state commands: `state list`, `state show`, `state mv`, `state rm`

**Hands-on:** Move your site's state to an S3 remote backend with locking. Manually change something in the AWS console (drift), then run `plan` to detect it and reconcile.

---

## Day 5 — Lifecycle, Dependencies, Custom Conditions
**Exam objectives covered:** depends_on / lifecycle, custom conditions (004-specific focus)

- `depends_on`: when Terraform infers order vs. when you must be explicit
- `lifecycle` meta-argument: `create_before_destroy`, `prevent_destroy`, `ignore_changes`
- Precondition / postcondition blocks for validating inputs and resource state

**Hands-on:** Add CloudFront in front of your S3 site. Use `create_before_destroy` on the distribution so updates don't cause downtime. Add a postcondition asserting the distribution status is deployed.

---

## Day 6 — Sensitive Data + HCP Terraform (Collaboration & Governance)
**Exam objectives covered:** ephemeral values/write-only arguments; HCP Terraform workspaces, projects, governance (004-specific focus)

- Ephemeral values and write-only arguments — keeping secrets out of state/plan
- HCP Terraform: organizations → projects → workspaces; VCS-driven vs CLI-driven vs API-driven runs
- Variable sets, run tasks, policy sets (Sentinel/OPA basics), workspace health & drift signals

**Hands-on:** Push your website module to a Git repo, connect a HCP Terraform workspace to it (free tier), and trigger a VCS-driven run. If you use any API key/secret in your config (e.g. a CDN token), pass it as a write-only argument.

---

## Day 7 — Full Review + Mock Exam
- Re-run your entire website project from scratch (`init` → `apply` → `destroy`) without notes — build muscle memory
- Speed-review weak areas from the week using a lab journal (keep short notes as you go — reduces exam-day memory load)
- Do the official 004 sample questions
- Focus drills on commonly-missed areas: `for_each` vs `count`, state commands, `-target` and `-refresh-only` flags, provider version pinning

**Exam-day checklist:**
- System/network check with the proctoring tool (Certiverse) the day before, on the same device/network
- Certification portal name must exactly match your government ID
- Clear desk, single monitor, ID ready, no notes
- Arrive/login ~15 min early

---

## Your Website Project Structure (by end of week)

```
terraform-website/
├── modules/
│   └── s3-static-site/
│       ├── main.tf        # S3 bucket, bucket policy, CloudFront distribution
│       ├── variables.tf
│       └── outputs.tf
├── main.tf                 # calls the module
├── variables.tf
├── outputs.tf
├── backend.tf               # remote S3 backend + locking
└── README.md
```

**Note on exam version:** If you're testing before Jan 8, 2026 you'd take the older 003 exam instead — but since we're past that date, 004 (covering Terraform 1.12) is the current version and what this syllabus is built around.
