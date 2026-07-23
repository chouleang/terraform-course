output "simple_sg_id" {
  value = aws_security_group.simple.id
}
output "complex_sg_id" {
  value = aws_security_group.complex.id
}
output "simple_sg_ingress_rules" {
  value = length(aws_security_group.simple.ingress)
}
output "complex_sg_ingress_rules" {
  value = length(aws_security_group.complex.ingress)
}