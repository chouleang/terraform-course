terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.92"
    }
  }

  required_version = ">= 1.3.0"
  backend "s3" {
    bucket  = "trfbec"
    key     = "day3/dev/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}
provider "aws" {
  region = var.aws_region
}
