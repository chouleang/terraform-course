data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }
  owners = ["099720109477"] # Canonical

}
resource "aws_security_group" "app_server" {
  name        = "app_server_sg"
  description = "sg for app server"


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
    Name = "app_server_sg"
  }
}

resource "aws_instance" "app_server" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  # Replace with your key pair name
  vpc_security_group_ids = [aws_security_group.app_server.id]

  tags = {
    Name        = var.instance_name
    Environment = var.environment
    CreatedBy   = "Terraform"
    owner       = var.owner
  }
}
