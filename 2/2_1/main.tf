data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }
  owners = ["099720109477"] # Canonical
}
resource "aws_security_group" "app_server" {
  name        = "${local.full_instance_name}-sg"
  description = "Security group for ${local.full_instance_name}"
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress  {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = local.common_tags
}

resource "aws_instance" "app_server" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  #   key_name      = var.key_name
  monitoring             = local.detailed_monitoring_enabled
  vpc_security_group_ids = [aws_security_group.app_server.id]
  tags = merge(
    local.common_tags,
    {
      Name = local.full_instance_name
    }
  )
  user_data = base64encode(<<-EOF
        #!/bin/bash
        echo "Instance created by Terraform - Day 2 Lab" > /tmp/day2.txt
        EOF
  )
}
