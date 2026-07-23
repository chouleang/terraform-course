resource "aws_security_group" "simple" {
  name        = "dynamic-simple"
  description = "Security group with dynamic simplet port"
  dynamic "ingress" {
    for_each = var.allowed_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "simple-dynamic"
  }
}

resource "aws_security_group" "complex" {
  name        = "dynamic-complex"
  description = "Security group with dynamic complex rules "
  dynamic "ingress" {
    for_each = var.security_rule
    content {
      from_port   = ingress.value.port
      to_port     = ingress.value.port
      protocol    = ingress.value.protocol
      cidr_blocks = ["0.0.0.0/0"]
      description = ingress.value.name
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "complex-dynamic"
  }
}