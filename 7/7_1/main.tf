module "vpc" {
  source             = "terraform-aws-modules/vpc/aws"
  version            = "~> 5.0"
  name               = "nginx-demo"
  cidr               = var.vpc_cidr
  azs                = ["${var.aws_region}a", "${var.aws_region}b"]
  private_subnets    = ["${cidrsubnet(var.vpc_cidr, 8, 1)}", "${cidrsubnet(var.vpc_cidr, 8, 2)}"]
  public_subnets     = ["${cidrsubnet(var.vpc_cidr, 8, 101)}", "${cidrsubnet(var.vpc_cidr, 8, 102)}"]
  enable_nat_gateway = true
  single_nat_gateway = true
  map_public_ip_on_launch = true
}
module "alb_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 5.0"

  name        = "alb-sg"
  description = "Security group for ALB"
  vpc_id      = module.vpc.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      description = "Allow HTTP traffic"
      cidr_blocks = "0.0.0.0/0"
  }]
  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      description = "Allow all outbound traffic"
      cidr_blocks = "0.0.0.0/0"
  }]
}
module "ec2_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 5.0"

  name        = "ec2-sg"
  description = "Security group for EC2 instances"
  vpc_id      = module.vpc.vpc_id

  ingress_with_source_security_group_id = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      description = "Allow HTTP traffic from ALB"
      source_security_group_id = module.alb_sg.security_group_id
  }]
  ingress_with_cidr_blocks = [
    {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        description = "Allow SSH traffic from anywhere"
        cidr_blocks = "0.0.0.0/0"
    },
    {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        description = "Allow HTTP traffic from anywhere"
        cidr_blocks = "0.0.0.0/0"
    }
  ]
  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      description = "Allow all outbound traffic"
      cidr_blocks = "0.0.0.0/0"
  }]
}
module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 9.0"

  name               = "nginx-alb"
  load_balancer_type = "application"
  create_security_group = false
  security_groups    = [module.alb_sg.security_group_id]
  depends_on         = [module.vpc, module.alb_sg]
  subnets            = module.vpc.public_subnets

  enable_deletion_protection = false
  listeners = {
    http = {
      port     = 80
      protocol = "HTTP"
      forward = {
        target_group_key = "nginx"
      }
    }
  }
  target_groups = {
    nginx = {
      name             = "nginx-tg"
      backend_protocol = "HTTP"
      backend_port     = 80
      target_type      = "instance"
      vpc_id           = module.vpc.vpc_id
      create_attachment = false
      health_check = {
        port                = 80
        path                = "/"
        interval            = 30
        timeout             = 5
        healthy_threshold   = 5
        unhealthy_threshold = 2
        matcher             = "200-399"
      }
    }
  }
    additional_target_group_attachments = {
    nginx_1 = {
      target_group_key = "nginx"
      target_id = module.nginx_1.id
      port       = 80
    }
    nginx_2 = {
      target_group_key = "nginx"
      target_id = module.nginx2.id
      port       = 80
    }
  }
}
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}

module "nginx_1" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 5.0"

  name                   = "nginx-1"
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t2.micro"
  key_name               = var.keypair_name # Replace with your key pair name
  vpc_security_group_ids = [module.ec2_sg.security_group_id]
  subnet_id              = module.vpc.private_subnets[0]

  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update -y
              sudo apt-get install nginx -y
              echo "<h1>Hello from nginx-1</h1>" > /var/www/html/index.html
              sudo systemctl start nginx
              sudo systemctl enable nginx
              
              EOF

  tags = {
    Name = "nginx-1"
  }
}
module "nginx2" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 5.0"

  name                   = "nginx-2"
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t2.small"
  key_name               = var.keypair_name # Replace with your key pair name
  vpc_security_group_ids = [module.ec2_sg.security_group_id]
  subnet_id              = module.vpc.private_subnets[1]
 

  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update -y
              sudo apt-get install nginx -y
              echo "<h1>Hello from nginx-2</h1>" > /var/www/html/index.html
              sudo systemctl start nginx
              sudo systemctl enable nginx
              
              EOF

  tags = {
    Name = "nginx-2"
  }
}
