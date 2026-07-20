output "instance_id" {
  description = "The ID of Ec2 instance"
  value       = aws_instance.app_server.id
}

output "instance_public_ip" {
  description = "The public IP address of the EC2 instance"
  value       = aws_instance.app_server.public_ip
}
output "instance_private_ip" {
  description = "The private IP address of the EC2 instance"
  value       = aws_instance.app_server.private_ip
}

output "security_group_id" {
  description = "The ID of the security group"
  value       = aws_security_group.app_server.id
}
output "instance_details" {
  description = "Details of the EC2 instance"
  value = {
#    name              = aws_instance.app_server.name
    id                = aws_instance.app_server.id
    public_ip         = aws_instance.app_server.public_ip
    private_ip        = aws_instance.app_server.private_ip
    instance_type     = aws_instance.app_server.instance_type
    security_group    = aws_security_group.app_server.name
    availability_zone = aws_instance.app_server.availability_zone
  }
}


output "configuration_summary" {
  description = "Summary of the EC2 instance configuration"
  value = {
    environment        = var.environment
    instance_name      = local.full_instance_name
    region             = var.aws_region
    monitoring_enabled = local.detailed_monitoring_enabled
  }
}
