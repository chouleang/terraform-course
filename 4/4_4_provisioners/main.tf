data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }
  owners = ["099720109477"]
}
data "aws_key_pair" "trf_course" {
  key_name = "trf-course"
}


# EC2 with local-exec provisioner
resource "aws_instance" "demo" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  key_name      = data.aws_key_pair.trf_course.key_name
  tags = {
    Name = "provisioner-demo"
  }

  # LOCAL-EXEC: Run on Terraform machine
  provisioner "local-exec" {
    command = <<-EOF
      echo "Instance ${self.id} created in ${var.environment}" > instance.log
      echo "Public IP: ${self.public_ip}" >> instance.log
      echo "Created at: $(date)" >> instance.log
    EOF
  }
  provisioner "remote-exec" {
    inline = [
      "echo 'Everything complete on $(date)' ",
      "whoami >> /tmp/server_date.txt"
    ]
  }
  # On destroy, also log
  provisioner "local-exec" {
    when    = destroy
    command = "echo 'Instance ${self.id} destroyed' >> instance.log"
  }
}