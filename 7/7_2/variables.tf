variable "aws_region" {
  description = "For Resource Location"
  default     = "us-east-1"
}
variable "vpc_cidr" {
  description = "VPC CIDR"
  default     = "10.0.0.0/16"
}
variable "keypair_name" {
  description = "Key Pair Name"
  default     = "trf-course"
}