locals {
  #merge: combine two maps, later map wins on key conflicts
  all_tags = merge(var.default_tags, var.extra_tags)

  #format: printf-style string building
  full_name = format("%s-%s-%s", var.default_tags["Project"], var.extra_tags["Environment"], "01")

  #join / split: string <-> list conversation
  server_csv    = join("_", var.servers)
  servers_again = split(",", local.server_csv)

  # lookup : safe map access with a default failback 
  # Syntax : lookup(map, key, default)
  
  owner_or_default = lookup(var.default_tags, "Owner", "no-owner-yet")
  missing_key      = lookup(var.default_tags, "DoesNotExist", "fallback-value")

  # contains: membership check
  has_db_server = contains(var.servers, "db-1")

  # flatten: collapse nested lists into one
  # combine mulitple list in one
  all_regions = flatten(var.regions)

  # keys/ values: pull out map parts separately
  tag_keys   = keys(local.all_tags)
  tag_values = values(local.all_tags)
}