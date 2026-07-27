# DAY 5: CONFIGURATION LANGUAGE — VALIDATION, FUNCTIONS & COMPLEX TYPES

**Duration:** 2-3 hours
**Difficulty:** Intermediate/Advanced
**Focus:** Custom validation, built-in functions, deeper complex types
**Prerequisite:** Day 4 (count/for_each, dynamic blocks, conditionals already covered — not repeated here)

---

## 🎯 TODAY'S OBJECTIVE

Close the remaining gaps in Terraform's configuration language that Days 1–4 didn't cover: enforcing correctness with **custom validation**, manipulating data with **built-in functions**, and modeling real-world data with **nested complex types**.

Maps to official exam objectives: **4d** (complex types), **4e** (expressions/functions), **4g** (custom conditions).

---

## 📚 WHAT YOU'LL LEARN

### Topic 1: Custom Validation
**Catch bad input before `apply` ever runs**
- ✅ `validation {}` blocks inside `variable` declarations
- ✅ `condition` + `error_message` syntax
- ✅ Multiple validation rules on one variable
- ✅ The newer standalone `validate {}` configuration block (module/resource-level checks, not just variables)
- ✅ Difference between validation (input-time) and `precondition`/`postcondition` (plan/apply-time, inside `lifecycle`)

### Topic 2: Built-in Functions
**Terraform has no loops in the traditional sense — functions do the heavy lifting**
- ✅ String functions: `format`, `join`, `split`, `lower`/`upper`, `trimspace`
- ✅ Collection functions: `merge`, `concat`, `contains`, `lookup`, `keys`/`values`, `flatten`
- ✅ Numeric functions: `min`, `max`, `ceil`/`floor`
- ✅ Type conversion: `tostring`, `tonumber`, `tolist`, `tomap`
- ✅ `terraform console` as a scratchpad to test functions live before using them in config

### Topic 3: Complex Types, Deeper
**Beyond flat lists and maps**
- ✅ `object({})` with typed, named attributes
- ✅ `tuple([])` — fixed-length, mixed-type sequences
- ✅ Nested objects (list of objects, map of objects)
- ✅ `optional()` attributes inside object type constraints, with defaults
- ✅ Practical use: modeling a variable like `var.servers` as a map of objects instead of several parallel lists

---

## 🎯 EXAM FOCUS

**⭐⭐⭐⭐⭐ CRITICAL:**
- `validation {}` block syntax (`condition` / `error_message`)
- Object and tuple type constraints
- Common functions: `merge`, `lookup`, `join`, `format`

**⭐⭐⭐⭐ IMPORTANT:**
- `optional()` in object type constraints
- `precondition`/`postcondition` vs variable validation
- `terraform console` usage

**⭐⭐⭐ MODERATE:**
- Numeric and type-conversion functions
- Nested object modeling patterns

---

## 💡 KEY CONCEPTS

### Variable Validation
```hcl
variable "instance_type" {
  type = string
  validation {
    condition     = contains(["t3.micro", "t3.small", "t3.medium"], var.instance_type)
    error_message = "instance_type must be one of: t3.micro, t3.small, t3.medium."
  }
}
```

### Object Type with Optional Attributes
```hcl
variable "servers" {
  type = map(object({
    instance_type = string
    monitoring    = optional(bool, false)
  }))
}
```

### Common Function Patterns
```hcl
locals {
  full_name = format("%s-%s-%s", var.project, var.environment, var.region)
  all_tags  = merge(var.default_tags, var.extra_tags)
}
```

---

## 📋 TODAY'S LAB EXERCISES

### Exercise 1: Validation
- Add `validation {}` to at least 2 variables in an existing module (e.g. `instance_type` in the `ec2` module from Day 3)
- Trigger a validation failure on purpose, read the error, fix it

### Exercise 2: Functions in `terraform console`
- Open `terraform console` and experiment with `merge`, `lookup`, `join`, `flatten` on sample data
- Bring one working expression back into `main.tf`

### Exercise 3: Complex Types
- Refactor a variable (e.g. server list) from separate `list(string)` variables into a single `map(object({...}))`
- Update references and confirm `terraform plan` still works
