variable "app_config" {
  type = object({
    name        = string
    port        = number
    is_public   = bool
    max_retries = optional(number, 3)
  })
  default = {
    name      = "my-app"
    port      = 8080
    is_public = true

  }
}

# A tuple - fixed length, mixed type allowed, order matters
variable "server_record" {
  type    = tuple([string, number, bool])
  default = ["web-1", 8080, true]
}

# The realistic upgrade: map of objects, instead of parallel lists
variable "servers" {
  type = map(object({
    instance_type = string
    monitoring    = optional(bool, false)
    tags          = optional(map(string), {})
  }))
  default = {
    "web-1" = {
      instance_type = "t3.micro"
      monitoring    = true
      tags          = { role = "frontend" }
    }
    "db-1" = {
      instance_type = "t3.medium"
    }
  }
}
variable "network_rules" {
  type = list(object({
    port     = number
    protocol = string
  }))
  default = [
    { port = 22, protocol = "tcp" },
    { port = 443, protocol = "tcp" },
  ]
}