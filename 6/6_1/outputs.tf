output "drif_file_content" {
  value = local_file.drift.content
}

output "prod_random_id" {
  value = random_id.prod.hex
}

output "legacy_random_id" {
  value = random_id.legacy_id.hex
}

output "prod_random_id_length" {
  value = length(random_id.prod.hex)
}