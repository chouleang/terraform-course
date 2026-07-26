terraform {
  required_version = ">=1.0"
  backend "s3" {
    bucket = "trfbec"
    key = "workspace"
    region = "us-east-1"
  }
}
locals {
  env_settings = {
    default = { instance_count = 1, size = "small" }
    dev     = { instance_count = 1, size = "small" }
    staging = { instance_count = 1, size = "medium" }
    prod    = { instance_count = 1, size = "large" }
  }
  current = lookup(local.env_settings, terraform.workspace, { instance_count = 1, size = "unknown" })
}

resource "terraform_data" "example" {
  input = "hello from workspace ${terraform.workspace}"

}
output "workspace_name" {
  value = terraform.workspace
}
output "resolved_settings" {
  value = local.current
}