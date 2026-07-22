variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}
variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be one of: dev, staging, prod."
  }
}
variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}
variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default = {
    Project   = "Terraform-Course"
    ManagedBy = "Terraform"
  }
}