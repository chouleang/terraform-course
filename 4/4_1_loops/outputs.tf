output "count_instance_ids" {
  description = "Instance IDS created with count"
  value = aws_instance.count_demo[*].id
}
output "count_instance_ips" {
  description = "Private IPs create with count"
  value = aws_instance.count_demo[*].private_ip
}
output "foreach_instance_ids" {
  description = "Instance IDs created with for_each"
  value = { for k, v in aws_instance.foreach_demo : k=> v.id }
}

output "foreach_instance_details" {
  description = "All instance details"
  value = {
    for k, v in aws_instance.foreach_demo :
    k => {
      id            = v.id
      instance_type = v.instance_type
      private_ip    = v.private_ip
    }
  }
}