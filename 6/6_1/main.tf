resource "local_file" "drift" {
  filename = "drift_target.txt"
  content  = "Test drift target file"
}

resource "random_id" "prod" {
  byte_length = 8
}

resource "random_id" "prod1" {
  byte_length = 10
}
resource "random_id" "legacy_id" {
  byte_length = 4
}