variable "environment" {
  type    = string
  default = "dev"
  validation {
    condition     = contains(["dev", "stagging", "prod"], var.environment)
    error_message = "Environment only 3"
  }
}
