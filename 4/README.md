# DAY 4: ADVANCED TERRAFORM TOPICS

**Duration:** 2-3 hours  
**Difficulty:** Advanced  
**Focus:** Loops, conditionals, provisioners, workspaces, importing

---

## 🎯 TODAY'S OBJECTIVE

Master **advanced Terraform features** to build flexible, reusable infrastructure code.

---

## 📚 MATERIALS

1. **Day_4_Advanced_Topics_Complete_Guide.md** - Theory & concepts
2. **Day_4_Hands_On_Lab.md** - 6 practical exercises
3. **This README** - Quick reference

---

## 🚀 WHAT YOU'LL LEARN

### Topic 1: For Loops & for_each
**Create multiple resources efficiently**
- ✅ `count` for numbered lists
- ✅ `for_each` for named/map resources
- ✅ When to use each
- ✅ Accessing resources by index/key

### Topic 2: Dynamic Blocks
**Generate nested blocks programmatically**
- ✅ `dynamic` keyword
- ✅ Iterating with `for_each` inside blocks
- ✅ Reducing configuration repetition
- ✅ Real-world examples (security group rules)

### Topic 3: Conditionals
**Create or configure based on conditions**
- ✅ Ternary operator `? :`
- ✅ Conditional resource creation with `count`
- ✅ Conditional configuration
- ✅ Protecting outputs with `try()`

### Topic 4: Provisioners
**Run scripts on resources**
- ✅ `local-exec` (run on Terraform machine)
- ✅ `remote-exec` (run on resource)
- ✅ When to use (rarely!)
- ✅ Best practices

### Topic 5: Workspaces
**Manage multiple environments**
- ✅ Create/select workspaces
- ✅ `terraform.workspace` variable
- ✅ Separate state per workspace
- ✅ Dev/staging/prod workflow

### Topic 6: Importing Resources
**Adopt existing AWS resources**
- ✅ `terraform import` command
- ✅ Adopting manual resources
- ✅ State vs configuration
- ✅ Import limitations

---

## 📊 COMPARISON: WHEN TO USE WHAT

| Feature | Purpose | Example |
|---------|---------|---------|
| **count** | N identical resources | 3 EC2 instances |
| **for_each** | Different configs per resource | web (t2.micro), db (t2.large) |
| **dynamic** | Generate nested blocks | 10 ingress rules |
| **conditional** | Create if true | Enable RDS only in prod |
| **provisioner** | Run script on resource | Install nginx (use user_data instead!) |
| **workspace** | Separate environments | dev, staging, prod |
| **import** | Adopt existing resource | Existing EC2 → Terraform |

---

## 💡 KEY CONCEPTS

### count vs for_each

**Use count:**
```hcl
# Create 3 identical instances
resource "aws_instance" "web" {
  count = 3
  # ...
}
# Access: aws_instance.web[0].id
```

**Use for_each:**
```hcl
# Create instances with different configs
resource "aws_instance" "servers" {
  for_each = {
    web = "t2.micro"
    db  = "t2.large"
  }
  instance_type = each.value
}
# Access: aws_instance.servers["web"].id
```

### Dynamic Blocks

```hcl
# Instead of repeating ingress blocks:
dynamic "ingress" {
  for_each = var.allowed_ports
  content {
    from_port = ingress.value
    # ...
  }
}
```

### Conditionals

```hcl
# Conditional resource creation
resource "aws_db_instance" "main" {
  count = var.create_db ? 1 : 0
  # ...
}

# Conditional configuration
instance_type = var.environment == "prod" ? "large" : "micro"

# Safe output access
output "db_id" {
  value = try(aws_db_instance.main[0].id, null)
}
```

### Workspaces

```hcl
# Use workspace to determine configuration
locals {
  workspace = terraform.workspace
  instance_type = var.types[local.workspace]
}

resource "aws_instance" "app" {
  instance_type = local.instance_type
  tags = { Workspace = local.workspace }
}
```

---

## 🎯 EXAM FOCUS - HEAVILY TESTED

**⭐⭐⭐⭐⭐ CRITICAL:**
- count vs for_each (when to use each)
- for_each syntax and access patterns
- Dynamic block syntax
- Ternary operator for conditionals
- terraform.workspace variable

**⭐⭐⭐⭐ IMPORTANT:**
- Conditional resource creation
- try() function
- Local-exec vs remote-exec
- Workspace state management

**⭐⭐⭐ MODERATE:**
- Provisioner limitations
- Import process
- Dynamic block iteration
- Output protection with try()

---

## 📋 TODAY'S LAB EXERCISES

### Exercise 1: For Loops & for_each
- Create instances with `count`
- Create instances with `for_each`
- Access resources by index/key
- Output results

### Exercise 2: Dynamic Blocks
- Create security group with dynamic ingress
- Simple list iteration
- Complex object iteration
- Modify and replan

### Exercise 3: Conditionals
- Environment-based configuration
- Conditional resource creation (RDS)
- Different instance types per environment
- Safe output access

### Exercise 4: Provisioners
- local-exec provisioner
- Create and destroy hooks
- Logging output to file

### Exercise 5: Workspaces
- Create multiple workspaces
- Deploy to each workspace
- Different configurations per workspace
- View state files

### Exercise 6: Importing
- Understanding import process
- Import command syntax
- Adoption workflow

---

## ⏱️ TIMELINE FOR TODAY
