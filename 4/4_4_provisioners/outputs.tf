output "instance_id" {
  value = aws_instance.demo.id
}
output "public_ip" {
  value = aws_instance.demo.public_ip
}
output "provisioner_log_location" {
  value = "${path.module}/instance.log"
}