resource "aws_key_pair" "ansible_key" {
  key_name   = "ansible-key"
  public_key = file("../../ssh/ansible-key.pub")
}

resource "aws_instance" "managed_nodes" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.ansible_key.key_name
  vpc_security_group_ids = [aws_security_group.ansible_sg.id]

  instance_market_options {
    market_type = "spot"

  }
}


data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}
