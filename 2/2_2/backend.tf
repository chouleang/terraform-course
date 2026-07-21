terraform {
  backend "s3" {
    bucket         = "trfbec"
    key            = "infra/dev/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
  }
}