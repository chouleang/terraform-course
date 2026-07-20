output "instance_id" {
  description = "The ID of the EC2 instance"
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
    instance_id       = aws_instance.app_server.id
    public_ip         = aws_instance.app_server.public_ip
    private_ip        = aws_instance.app_server.private_ip
    security_group_id = aws_security_group.app_server.id
  }
}