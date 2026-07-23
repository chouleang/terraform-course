variable "aws_region" {
  description = "Region For Resource"
  default = "us-east-1"
}
variable "instance_count" {
  description = "Number of Instances"
  default = 3
}

variable "instances" {
    type = map(string)
    default = {
        web = "t2.micro"
        app = "t2.small"
        db  = "t2.medium"
        redis = "t3.small"
    }
}