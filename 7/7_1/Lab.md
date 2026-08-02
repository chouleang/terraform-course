# 7_1 Registry Module 
** cover exam objectives: 5a, 5d (module sourcing & versioning)
## The different: local vs registry modules
|| | Local (Day 3) | Registry (Day 7) |
|---|---|---|
| Source | `source = "./modules/vpc"` | `source = "terraform-aws-modules/vpc/aws"` |
| Version | Not pinned (always latest on disk) | `version = "~> 5.0"` |
| Where it lives | Your repo | Public registry (or private) |
| Who maintains it | You | The community / HashiCorp partners |
---

