data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}
# Using COUNT - Create N identical instance
resource "aws_instance" "count_demo" {
    count = var.instance_count
    ami = data.aws_ami.ubuntu.id
    instance_type = "t2.micro"
    tags = {
      Name = "instance-${count.index}"
      Type = "count-demo"
    }
}
# USING for-each - create instanec with different configs
resource "aws_instance" "foreach_demo" {
  for_each = var.instances
  ami = data.aws_ami.ubuntu.id
  instance_type = each.value

  tags = {
    Name = each.key
    Type = "foreach-demo"
  }
}