# DAY 4: ADVANCED TERRAFORM TOPICS

**Duration:** 2-3 hours  
**Difficulty:** Advanced  
**Focus:** Loops, conditionals, provisioners, workspaces, importing resources

---

## 🎯 WHAT YOU'LL LEARN TODAY

This is the **most powerful day** - you'll learn to:
- ✅ Create multiple resources efficiently (loops)
- ✅ Generate configuration blocks dynamically
- ✅ Use conditional logic
- ✅ Run scripts on resources
- ✅ Manage multiple environments
- ✅ Import existing AWS resources

---

## 📋 TOPICS OVERVIEW

1. **For Loops & for_each**
2. **Dynamic Blocks**
3. **Conditionals**
4. **Provisioners**
5. **Workspaces**
6. **Importing Resources**
7. **Troubleshooting**

---

## 🔄 TOPIC 1: FOR LOOPS & for_each

### Purpose
Create **multiple similar resources** without repetition.

### Two Types

#### **count** (Simpler - use for numbered iterations)

```hcl
# Create 3 EC2 instances
resource "aws_instance" "app" {
  count           = 3
  instance_type   = "t2.micro"
  
  tags = {
    Name = "app-server-${count.index}"  # 0, 1, 2
  }
}

# Access them:
# aws_instance.app[0].id
# aws_instance.app[1].id
# aws_instance.app[2].id
```

**Key concepts:**
- `count.index` → 0, 1, 2...
- `count.value` → current iteration value
- Access via `[index]`

#### **for_each** (Flexible - use for named iterations)

```hcl
variable "instances" {
  type = map(string)
  default = {
    web    = "t2.micro"
    app    = "t2.small"
    db     = "t2.medium"
  }
}

resource "aws_instance" "servers" {
  for_each      = var.instances
  instance_type = each.value
  
  tags = {
    Name = each.key  # "web", "app", "db"
  }
}

# Access them:
# aws_instance.servers["web"].id
# aws_instance.servers["app"].id
# aws_instance.servers["db"].id
```

**Key concepts:**
- `each.key` → Map key
- `each.value` → Map value
- Access via `["key"]`
- Better for named resources

### When to Use

| Scenario | Use |
|----------|-----|
| Create N identical resources | count |
| Create resources with different configs | for_each |
| Simple numbered list | count |
| Named/map-based resources | for_each |

---

## 🧩 TOPIC 2: DYNAMIC BLOCKS

### Purpose
**Generate nested blocks conditionally** (for_each inside resource).

### Problem It Solves

```hcl
# Without dynamic - repetitive!
resource "aws_security_group" "main" {
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
```

### Solution with Dynamic

```hcl
variable "allowed_ports" {
  type = list(number)
  default = [22, 80, 443]
}

resource "aws_security_group" "main" {
  dynamic "ingress" {
    for_each = var.allowed_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}
```

### Syntax

```hcl
dynamic "block_name" {
  for_each = var.items
  content {
    # Use dynamic.value to access each item
    key = dynamic.value
  }
}
```

**Key concepts:**
- `dynamic` generates nested blocks
- `for_each` iterates over items
- `content` defines block structure
- Access iteration with `dynamic.value` or `dynamic.key`

### Real-World Example

```hcl
variable "security_rules" {
  type = list(object({
    port     = number
    protocol = string
  }))
  default = [
    { port = 22, protocol = "tcp" },
    { port = 80, protocol = "tcp" },
    { port = 443, protocol = "tcp" }
  ]
}

resource "aws_security_group" "app" {
  dynamic "ingress" {
    for_each = var.security_rules
    content {
      from_port   = ingress.value.port
      to_port     = ingress.value.port
      protocol    = ingress.value.protocol
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}
```

---

## ❓ TOPIC 3: CONDITIONALS

### Purpose
**Create or configure resources based on conditions**.

### The Ternary Operator

```hcl
variable "enable_database" {
  type = bool
  default = false
}

resource "aws_db_instance" "main" {
  count             = var.enable_database ? 1 : 0
  allocated_storage = 20
  # ... more config
}

# Only created if enable_database = true!
```

### Syntax

```hcl
condition ? value_if_true : value_if_false
```

### Use Cases

**1. Conditional resource creation**
```hcl
resource "aws_instance" "web" {
  count = var.create_instance ? 1 : 0
  # ...
}
```

**2. Conditional configuration**
```hcl
resource "aws_instance" "web" {
  instance_type = var.environment == "prod" ? "t2.large" : "t2.micro"
  monitoring    = var.environment == "prod" ? true : false
}
```

**3. Conditional output**
```hcl
output "instance_id" {
  value = var.create_instance ? aws_instance.web[0].id : null
}
```

### Important: Try() Function

When using conditionals with count, protect outputs:

```hcl
resource "aws_instance" "web" {
  count = var.create_instance ? 1 : 0
  # ...
}

# ❌ ERROR if count = 0
output "public_ip" {
  value = aws_instance.web[0].public_ip
}

# ✅ SAFE with try()
output "public_ip" {
