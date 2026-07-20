variable "instance_type" {
  description = "EC2 instance Type"
  type        = string
  default     = "t2.micro"
}

variable "instance_name" {
  description = "EC2 instance Name"
  type        = string
  default     = "trf-cource"
}

variable "environment" {
  description = "Environment"
  type        = string
  default     = "dev"
}
variable "owner" {
  description = "Owner"
  type        = string
  default     = "SQ"
}