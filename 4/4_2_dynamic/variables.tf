variable "allowed_ports" {
  description = "List of allow port"
  type        = list(number)
  default     = [22, 80, 443]
}
variable "security_rule" {
  description = "Complex Security Rule"
  type = list(object({
    port     = number
    protocol = string
    name     = string
  }))
  default = [
    { name = "ssh", protocol = "tcp", port = 22 },
    { name = "http", protocol = "tcp", port = 80 },
    { name = "https", protocol = "tcp", port = 443 },
    { name = "mysql", protocol = "tcp", port = 3306 }

  ]
}
