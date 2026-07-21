output "instance_id" {
  description = "The ID of the EC2 instance"
  value       = aws_instance.app_server.id
}
output "instance_public_ip" {
  description = "The public IP address of the EC2 instance"
  value       = aws_instance.app_server.public_ip
}
output "private_ip" {
  description = "The private IP address of the EC2 instance"
  value       = aws_instance.app_server.private_ip
}
output "instance_details" {
  description = "Details of the EC2 instance"
  value = {
    id            = aws_instance.app_server.id
    public_ip     = aws_instance.app_server.public_ip
    private_ip    = aws_instance.app_server.private_ip
    instance_type = aws_instance.app_server.instance_type
  }
}
