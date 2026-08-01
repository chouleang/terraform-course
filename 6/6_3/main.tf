resource "random_id" "demo" {
  byte_length = 8
}
resource "local_file" "demo" {
  content  = "log-demo-${random_id.demo.hex}"
  filename = "demo.txt"
}
