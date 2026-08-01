resource "random_id" "source" {
  byte_length = 8
}

resource "random_id" "source_a" {
  byte_length = 10
}

resource "random_id" "source_b" {
  byte_length = 6
}

import {
    to = random_id.imported
    id = random_id.source.hex
}

resource "random_id" "imported" {
  byte_length = 8
}
locals {
  import_map = {
  "svc_a" = random_id.source_a.hex
  "svc_b" = random_id.source_b.hex
}
}
import {
for_each = local.import_map
to = random_id.bulk[each.key]
id = each.value
}

resource "random_id" "bulk" {
  for_each = local.import_map
  byte_length = 4
}