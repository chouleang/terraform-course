locals {
  common_tags = merge(var.tags, {
    Environment = var.environment
    Instance    = var.instance_name
  })
  full_instance_name          = "${var.environment}-${var.instance_name}"
  detailed_monitoring_enabled = var.enable_monitoring ? true : false
}