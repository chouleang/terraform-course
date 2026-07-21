resource "aws_security_group" "main" {
  name        = var.name
  description = var.description
  vpc_id      = var.vpc_id

  tags = merge(
    local.tags,
    {
      Name = var.name
    }
  )
}
resource "aws_security_group_rule" "ssh" {
  count              = var.allow_ssh ? 1 : 0
  type               = "ingress"
  from_port          = 22
  to_port            = 22
  protocol           = "tcp"
  cidr_blocks        = ["0.0.0.0/0"]
  security_group_id  = aws_security_group.main.id
}
resource "aws_security_group_rule" "http" {
  count              = var.allow_http ? 1 : 0
  type               = "ingress"
  from_port          = 80
  to_port            = 80
  protocol           = "tcp"
  cidr_blocks        = ["0.0.0.0/0"]
  security_group_id  = aws_security_group.main.id
}
resource "aws_security_group_rule" "https" {
  count              = var.allow_https ? 1 : 0
  type               = "ingress"
  from_port          = 443
  to_port            = 443
  protocol           = "tcp"
  cidr_blocks        = ["0.0.0.0/0"]
    security_group_id  = aws_security_group.main.id
}
