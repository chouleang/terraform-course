data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }
  owners = ["099720109477"] # Canonical
}

resource "aws_security_group" "app_server" {
  name        = "${var.environment}-${var.instance_name}-sg"
  description = "Ot dg jes tea dak dak tov"
  # if don't have vpc id , it mean default.
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name        = "${var.environment}-${var.instance_name}-sg"
    Environment = var.environment
    ManagedBy   = "Terraform"
    Owner       = "SQ"
  }
}
resource "aws_instance" "app_server" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  monitoring             = var.enable_monitoring
  vpc_security_group_ids = [aws_security_group.app_server.id]
  tags = {
    Name        = "${var.environment}-${var.instance_name}"
    Environment = var.environment
    ManagedBy   = "Terraform"
    Owner       = "SQ"
  }
  user_data = base64encode(<<-EOF
              #!/bin/bash
              echo "Fucking Stupid Lesson" > /tmp/day2-2.txt 
              EOF
  )
}
