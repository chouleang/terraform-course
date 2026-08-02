# 7_2 HCP Terraform (Terraform Cloud)
** Cover exam objective : 8a-8d (HCP Terraform - full coverage)
**Type ** Conceptual (read & understand - no apply required)

---
## Topic A - CLI Workspace vs HCP Terraform Workspace
 This is the #1 Exam question on this topic. Know this table could: 

 | | CLI Workspace | HCP Terraform Workspace |
|---|---|---|
| What it is | A named state file within one config | A near-separate working directory |
| Config | Shared — same `.tf` files | Can differ per workspace |
| Variables | Shared across all workspaces | Own variable sets per workspace |
| State | Separate state per workspace | Separate state per workspace |
| Use case | Quick parallel test copies | Real environment separation (dev/stagging/prod) |
| Created by | `terraform workspace new` | HCP UI / API / `cloud {}` block |

** The exam trap: ** "Workspace" means two completely different things. HCP workspaces are closer to what you'd get from seperate directories 

## Topic B - The `cloud{}` Block 