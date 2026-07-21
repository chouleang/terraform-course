variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
  validation {
    condition     = can(regex("^t[2-3]\\.", var.instance_type))
    error_message = "Instance type must be t2 or t3 only"
  }
}

variable "instance_name" {
  description = "Name of the EC2 instance"
  type        = string
  default     = "2_2_instance"
}
variable "environment" {
  description = "Environment"
  type        = string
  default     = "dev"
  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Don't Stupid create other environment, you don't fucking spend the resource"
  }
}
variable "enable_monitoring" {
  description = "Enable detailed monitoring for the EC2 instance"
  type        = bool
  default     = false
}