variable "instance_type" {
  description = "Ec2 instance type"
  type = string
  default = "t2.micro"
  validation {
    condition = can(regex("^t[2-3]\\.",var.instance_type))
    error_message = "Instance type must be t2 or t3"
  }
}
variable "security_group_ids" {
  description = "List of security group IDs"
  type        = list(string)
}
variable "instance_name" {
  description = "Ec2 instance name"
  type = string
#  default = "my-ec2-instance"
}
variable "subnet_id" {
  description = "Subnet ID for the EC2 instance"
  type = string
}
variable "environment" {
  description = "Environment for the EC2 instance"
  type = string
  default = "dev"
  validation {
    condition = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be one of: dev, staging, prod"
  }
}
variable "tags" {
  description = "Tags for the EC2 instance"
  type = map(string)
  default = {}
}