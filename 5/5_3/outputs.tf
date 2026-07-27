output "app_display_name" { value = local.app_display_name }
output "app_max_retries" { value = var.app_config.max_retries } # should show default: 3

output "server_record_name" { value = local.server_record_name }
output "server_record_port" { value = local.server_record_port }

output "server_summaries" { value = local.server_summaries }
output "db1_tags" { value = var.servers["db-1"].tags } # should show default: {}

output "allowed_ports" { value = local.allowed_ports }