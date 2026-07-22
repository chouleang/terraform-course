module "vpc" {
  source      = "./modules/vpc"
  vpc_name    = "trf-vpc"
  vpc_cidr    = "10.0.0.0/16"
  environment = "dev"
  # tags = {
  #     Environment = "dev"
  #     Project     = "Terraform-Course"
  # }
}
module "security_group" {
  source = "./modules/security_group"

  name        = "${var.environment}-app-sg"
  description = "Security group for application servers"
  vpc_id      = module.vpc.vpc_id
  allow_ssh   = true
  allow_http  = true
  allow_https = true
  environment = var.environment
  tags        = var.tags
}

# EC2 Module

module "ec2" {
  source             = "./modules/ec2"
  instance_name      = "${var.environment}-app-server"
  instance_type      = var.instance_type
  subnet_id          = module.vpc.public_subnet_ids[0]
  security_group_ids = [module.security_group.id]
  environment        = var.environment
  tags               = var.tags
}

module "prod-vpc" {
  source      = "./modules/vpc"
  vpc_name    = "prod-vpc"
  vpc_cidr    = "10.0.0.0/16"
  environment = "prod"
}