output "vpc_id" {
  value = module.vpc.vpc_id
}
output "alb_dns_name" {
  value = module.alb.dns_name
}
output "nginx_1_id" {
  value = module.nginx_1.id
}
output "nginx_2_id" {
  value = module.nginx2.id
}
output "ec2_sg_id" {
  value = module.ec2_sg.security_group_id
}
