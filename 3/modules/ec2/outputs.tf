output "id" {
  description = "Ec2 instance id"
  value = aws_instance.main.id
}

output "public_ip" {
  description = "Ec2 instance public ip"
  value = aws_instance.main.public_ip
}

output "private_ip" {
  description = "Ec2 instance private ip"
  value = aws_instance.main.private_ip
}
output "ami_id" {
  description = "AMI ID used for the EC2 instance"
  value = data.aws_ami.ubuntu.id
}
