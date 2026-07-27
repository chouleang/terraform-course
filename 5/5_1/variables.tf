variable "instance_type" {
  type = string
  description = "Ec2 instance type"
  default = "t3.micro"
  validation {
   condition = contains(["t3.micro","t3.small","t3.medium"], var.instance_type)
   error_message = "instance type mush be in t3.micro , t3.small , t3.medium"
  }
}

variable "environment" {
  type = string
  description = "Deploy Environment"
  validation {
    condition = can(regex("^(dev|staging|prod)$", var.environment))
    error_message = "environment must be exactly one of: dev, staging, prod"
  }
}

