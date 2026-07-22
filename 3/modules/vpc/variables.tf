variable "vpc_name" {
  description = "Name of VPC"
  type = string
  default = "main-vpc"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type = string
  default = "10.0.0.0/16"
}

variable "enable_dns_hostnames" {
description = "Enable DNS hostnames in the VPC"
  type = bool
  default = true
}

variable "environment" {
  description = "Environment name (e.g., dev, staging, prod)"
  type = string
  default = "dev"
  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be one of: dev, staging, prod."
  }
}

variable "tags" {
  description = "A map of tags to assign to the VPC"
  type        = map(string)
  default     = { }
}
