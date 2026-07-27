locals {
  # Pull a single attribute out of an object
  app_display_name = "${var.app_config.name}:${var.app_config.port}"

  # Access a tuple by index (order-dependent, like a list)
  server_record_name = var.server_record[0]
  server_record_port = var.server_record[1]

  # Iterate a map of objects
  server_summaries = {
    for keys, srv in var.servers :
    keys => "${srv.instance_type} (monitoring=${srv.monitoring})"
  }
  # Iterate a list of objects
  allowed_ports = [for rule in var.network_rules : rule.port]
}