variable "aws_region" {
  description = "This is region for our course"
  type = string
  default = "us-east-1"
  validation {
    condition     = contains(["us-east-1", "us-east-2", "us-west-1", "us-west-2"], var.aws_region)
    error_message = "The AWS region must be one of: us-east-1, us-east-2, us-west-1, us-west-2."
  }
}
variable "instance_type" {
  description = "The type of instance to use for the EC2 instance."
  type        = string
  default     = "t2.micro"
  validation {
    condition     = contains(["t2.micro", "t2.small", "t2.medium"], var.instance_type)
    error_message = "The instance type must be one of: t2.micro, t2.small, t2.medium."
  }
}
variable "instance_name"{
    description = "The name of the EC2 instance."
    type        = string
    default     = "day2-instance"
    validation {
        condition     = length(var.instance_name) > 0 && length(var.instance_name) <= 16
        error_message = "The instance name must be between 1 and 16 characters long."
    }
}

variable "environment" {
  description = "The environment for the resources (e.g., dev, staging, prod)."
  type        = string
  default     = "dev"
  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "The environment must be one of: dev, staging, prod."
  }
}
variable "enable_monitoring" {
  description = "Enable detailed monitoring for the EC2 instance."
  type        = bool
  default     = false
}
variable "tags" {
    description = "Tags for the resources"
    type       = map(string)
    default    = {
        Environment = "dev"
        Project     = "terraform-course"
        ManagedBy    = "terraform"
        Owner       = "SQ"
    }
}

variable "allowed_ssh_ips"{
    description = "The IP address allowed to SSH into the EC2 instance."
    type        = list(string)
    default     = ["0.0.0.0/0","::/0"]
    validation {
        condition = length(var.allowed_ssh_ips) > 0
        error_message = "At least one SSH IP address must be allowed."
    }
}
