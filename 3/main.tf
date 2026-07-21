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
output "vpc_id" {
  value = module.vpc.vpc_id
}
output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}
output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids
}       