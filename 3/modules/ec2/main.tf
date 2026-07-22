data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }
}

resource "aws_instance" "main" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id

  tags = merge(
    local.tags,
    {
      Name = var.instance_name
    }
  )
  user_data = <<-EOF
              #!/bin/bash
              echo "EC2 instance created by Terraform module" > /tmp/module-info.txt
              echo "Instance Name: ${var.instance_name}" >> /tmp/module-info.txt
              echo "Environment: ${var.environment}" >> /tmp/module-info.txt
              echo "Created at: $(date)" >> /tmp/module-info.txt              
              EOF
}