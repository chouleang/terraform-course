# DAY 7: REGISTRY MODULES, HCP TERRAFORM & FINAL EXAM REVIEW

**Duration:** 3-4 hours
**Difficulty:** Advanced
**Focus:** Registry modules, HCP Terraform, full-spectrum review
**Prerequisite:** Day 3 (local modules) — not repeated here. HCP Terraform is entirely new content, not covered anywhere in Days 1–6.

---

## 🎯 TODAY'S OBJECTIVE

Close out the two remaining exam domains: sourcing/versioning **registry modules** (Day 3 only used local modules), and **HCP Terraform** — an entire exam domain with zero prior coverage. Finish with a full practice exam across all 8 domains.

Maps to official exam objectives: **5a, 5d** (module sourcing & versioning), **8a–8d** (HCP Terraform, in full).

---

## 📚 WHAT YOU'LL LEARN

### Topic 1: Registry Modules
**Beyond `./modules/...` — using published modules**
- ✅ `source = "namespace/name/provider"` syntax for Terraform Registry modules
- ✅ Version constraints: `version = "~> 5.0"`, `>= 4.0, < 5.0`
- ✅ Reading a registry module's inputs/outputs before using it (same idea as your Day 3 module READMEs, but for someone else's module)
- ✅ Local vs registry vs Git-sourced modules — when to use each

### Topic 2: HCP Terraform Fundamentals
**The hosted platform — conceptual only, no live account required for the exam**
- ✅ **Workspaces** in HCP Terraform vs **CLI workspaces** (you already know this distinction cold from Day 4 — same name, very different concept: HCP workspaces are closer to separate working directories with their own config, variables, and run history)
- ✅ **Projects** — grouping workspaces for organization and access control
- ✅ **Remote operations** — plan/apply running on HCP's infrastructure instead of your laptop
- ✅ The `cloud {}` block for connecting CLI to HCP Terraform

### Topic 3: HCP Terraform Collaboration & Governance
- ✅ **Variable sets** — shared variables across multiple workspaces
- ✅ **Run triggers** — chaining workspace runs together
- ✅ **Policy enforcement** — Sentinel and OPA, conceptually (what they do, not how to write policies)
- ✅ **Drift detection** — HCP's automated version of what you did manually with `-refresh-only` on Day 6
- ✅ Teams and access control, at a high level

### Topic 4: Full Review
- ✅ Practice exam spanning all 8 official domains
- ✅ Targeted re-review of weakest areas

---

## 🎯 EXAM FOCUS

**⭐⭐⭐⭐⭐ CRITICAL:**
- Registry module `source` + `version` syntax
- CLI workspaces vs HCP Terraform workspaces (the distinction, not just the definition)
- What variable sets and run triggers do

**⭐⭐⭐⭐ IMPORTANT:**
- Projects as a workspace-organization concept
- Policy enforcement purpose (Sentinel/OPA — what problem they solve)
- Remote operations vs local operations

**⭐⭐⭐ MODERATE:**
- Drift detection at the HCP level
- `cloud {}` block basics

---

## 💡 KEY CONCEPTS

### Registry Module Usage
```hcl
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = "my-vpc"
  cidr = "10.0.0.0/16"
}
```

### Connecting CLI to HCP Terraform
```hcl
terraform {
  cloud {
    organization = "my-org"
    workspaces {
      name = "my-workspace"
    }
  }
}
```

### CLI Workspace vs HCP Workspace — the key distinction
| | CLI Workspace | HCP Terraform Workspace |
|---|---|---|
| What it is | A named state file within one config | A near-separate working directory |
| Config | Shared — same `.tf` files | Can differ per workspace |
| Variables | Shared | Own variable sets per workspace |
| Use case | Quick parallel test copies | Real environment separation (dev/staging/prod) |

---

## 📋 TODAY'S LAB EXERCISES

### Exercise 1: Registry Module
- Add a registry module (e.g. `terraform-aws-modules/vpc/aws`) to a scratch config
- Pin a version constraint, run `terraform init`, inspect the downloaded module in `.terraform/modules/`

### Exercise 2: HCP Terraform Walkthrough (read-only is fine)
- Create a free HCP Terraform account if you don't have one
- Create one workspace, connect it via the `cloud {}` block
- Explore where variable sets, run triggers, and policies live in the UI — no need to configure real policies

### Exercise 3: Full Practice Exam
- 40–60 mixed questions across all 8 domains (IaC concepts, fundamentals, workflow, configuration, modules, state, maintenance, HCP Terraform)
- Score and flag every miss by domain number

### Exercise 4: Weak-Area Review
- Revisit only the domains where you missed questions
- Re-read the relevant Day 1–7 README sections for those domains
