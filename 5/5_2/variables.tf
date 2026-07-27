variable "default_tags" {
  type = map(string)
  default = {
    Project = "terraform-course"
    Owner   = "sq"
  }
}
variable "extra_tags" {
  type = map(string)
  default = {
    Environment = "dev"
  }
}
variable "servers" {
  type    = list(string)
  default = ["web-1", "web-2", "db-1"]
}
variable "regions" {
  type    = list(list(string))
  default = [["us-east-1", "us-east-2"], ["ap-southeast-5", "ap-southeast-1"]]
}