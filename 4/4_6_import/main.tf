terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
  }
}
resource "random_id" "server" {
  byte_length = 8
}
output "hex" {
  value = random_id.server.hex
}
output "b64_url" {
  value = random_id.server.b64_url
}