output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "vpc_cidr" {
  description = "VPC CIDR block"
  value       = module.vpc.vpc_cidr
}

output "public_subnet_ids" {
  description = "Public subnet IDs"
  value       = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  description = "Private subnet IDs"
  value       = module.vpc.private_subnet_ids
}

# Security Group Outputs
output "security_group_id" {
  description = "Security group ID"
  value       = module.security_group.id
}

output "security_group_name" {
  description = "Security group name"
  value       = module.security_group.name
}

# EC2 Outputs
output "instance_id" {
  description = "EC2 instance ID"
  value       = module.ec2.id
}

output "instance_public_ip" {
  description = "EC2 instance public IP"
  value       = module.ec2.public_ip
}

output "instance_private_ip" {
  description = "EC2 instance private IP"
  value       = module.ec2.private_ip
}

# Complete Infrastructure Summary
output "infrastructure_summary" {
  description = "Summary of created infrastructure"
  value = {
    vpc_id              = module.vpc.vpc_id
    security_group_id   = module.security_group.id
    instance_id         = module.ec2.id
    instance_public_ip  = module.ec2.public_ip
    instance_private_ip = module.ec2.private_ip
    environment         = var.environment
    
  }
}

output "get_local" {
  description = "Get local variable from VPC module"
  value       = module.vpc.sent_local
} 