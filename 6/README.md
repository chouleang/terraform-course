# DAY 6: STATE DRIFT, REFACTORING & MAINTENANCE

**Duration:** 2-3 hours
**Difficulty:** Advanced
**Focus:** Drift detection, moved/removed blocks, logging, declarative import
**Prerequisite:** Day 2 (2_2 — remote backends, state locking, state mv/rm/replace-provider) and Day 4 (import CLI) — not repeated here

---

## 🎯 TODAY'S OBJECTIVE

Learn how Terraform detects and handles infrastructure that has changed outside of Terraform (**drift**), the modern declarative way to refactor state (**moved**/**removed** blocks, replacing the imperative `state mv`/`state rm` you already know), and how to debug when something goes wrong.

Maps to official exam objectives: **6d** (manage resource drift and state), **7a** (import, declarative variant), **7c** (verbose logging).

---

## 📚 WHAT YOU'LL LEARN

### Topic 1: Resource Drift
**When real infrastructure no longer matches your state**
- ✅ What causes drift (manual console changes, another tool, expired resources)
- ✅ How `terraform plan` surfaces drift automatically
- ✅ `terraform apply -refresh-only` — sync state to reality **without** changing infrastructure
- ✅ Deciding whether to accept drift (update config to match) or correct it (apply to force back to config)

### Topic 2: `moved` Blocks
**Declarative resource renaming/refactoring — replaces `terraform state mv`**
- ✅ `moved { from = ...; to = ... }` syntax
- ✅ Why this is safer for teams than `state mv` (it's reviewable in a PR, applies automatically on `plan`/`apply`, no separate imperative command to forget)
- ✅ Use cases: renaming a resource, moving a resource into a module, changing `count` to `for_each`

### Topic 3: `removed` Blocks
**Declarative resource removal — replaces `terraform state rm`**
- ✅ `removed { from = ... }` syntax
- ✅ Optional `lifecycle { destroy = false }` inside `removed` to stop managing without destroying the real object
- ✅ Removing multiple resources in one reviewable change

### Topic 4: The `import` Block (declarative import)
**You've done imperative `terraform import`; this is the config-driven alternative**
- ✅ `import { to = ...; id = ... }` syntax
- ✅ `terraform plan -generate-config-out=generated.tf` — let Terraform write the resource block for you
- ✅ `for_each` on `import` blocks for bulk imports (CLI import can only do one at a time — this can't)

### Topic 5: Verbose Logging & Debugging
- ✅ `TF_LOG` levels: `TRACE`, `DEBUG`, `INFO`, `WARN`, `ERROR`
- ✅ `TF_LOG_PATH` to write logs to a file instead of stdout
- ✅ When to reach for logging (provider errors, unexpected plan behavior, crash reports)

---

## 🎯 EXAM FOCUS

**⭐⭐⭐⭐⭐ CRITICAL:**
- `moved` block syntax and purpose
- `removed` block syntax and purpose
- Difference between drift and a configuration change

**⭐⭐⭐⭐ IMPORTANT:**
- `-refresh-only` mode behavior
- `import` block + `-generate-config-out`
- `TF_LOG` levels

**⭐⭐⭐ MODERATE:**
- `for_each` on `import` blocks
- `removed` with `lifecycle { destroy = false }`

---

## 💡 KEY CONCEPTS

### Moved Block
```hcl
moved {
  from = random_id.server
  to   = random_id.server_id
}
```
*(This replaces the `terraform state mv random_id.server random_id.server_id` you ran on Day 5's state exercise — same result, but reviewable as code.)*

### Removed Block
```hcl
removed {
  from = random_id.old_server

  lifecycle {
    destroy = false   # forget it, don't destroy the real object
  }
}
```

### Import Block
```hcl
import {
  to = random_id.server
  id = "prKSDTa6O7c"
}

resource "random_id" "server" {
  byte_length = 8
}
```
Then: `terraform plan -generate-config-out=generated.tf`

### Refresh-Only
```bash
terraform apply -refresh-only
```

---

## 📋 TODAY'S LAB EXERCISES

### Exercise 1: Simulate & Detect Drift
- Manually change an attribute of a resource outside Terraform (or simulate by editing state directly for a local-only resource)
- Run `terraform plan` and observe how drift is reported
- Run `terraform apply -refresh-only` and compare

### Exercise 2: Moved Block
- Rename a resource in config
- Add a `moved` block instead of running `state mv`
- Confirm `terraform plan` shows no destroy/recreate

### Exercise 3: Removed Block
- Add a `removed` block with `destroy = false` for a resource you no longer want managed
- Confirm the resource leaves state but isn't destroyed

### Exercise 4: Declarative Import
- Use an `import` block + `-generate-config-out` on a resource type that supports import
- Compare the generated config against what you'd have hand-written
