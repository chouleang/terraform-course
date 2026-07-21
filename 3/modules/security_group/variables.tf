variable "name" {
  description = "Security Group Name"
  type = string
}

variable "description" {
  description = "Security Group Description"
  type = string
  default = "Security Group"
}
variable "vpc_id" {
  description = "VPC ID"
  type = string
}
variable "allow_ssh" {
  description = "Allow SSH access"
  type = bool
  default = true
}
variable "allow_http" {
  description = "Allow HTTP access"
  type = bool
  default = true
}
variable "allow_https" {
  description = "Allow HTTPS access"
  type = bool
  default = true
}
variable "environment" {
  description = "Environment"
  type = string
  default = "dev"
  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be one of: dev, staging, prod"
  }
}
variable "tags" {
  description = "Tags for the security group"
  type        = map(string)
  default     = {}
}