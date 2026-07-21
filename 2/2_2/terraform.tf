terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.92"
    }
  }
  required_version = ">= 1.2"
  # This version of remote backend
}
provider "aws" {
  region = "us-east-1"
}
