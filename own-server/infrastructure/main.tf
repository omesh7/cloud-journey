data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_security_group" "ssh_access" {
  name_prefix = "ssh-access-"
  description = "Allow SSH inbound traffic"

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
    Name = "ssh-access-sg"
  }
}

resource "aws_instance" "own_server_practice" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t2.micro"
  key_name              = "aws_key_pair"
  vpc_security_group_ids = [aws_security_group.ssh_access.id]
  
  tags = {
    Name = "own_server_practice"
  }
}

output "instance_public_ip" {
  value = aws_instance.own_server_practice.public_ip
}

output "ssh_command" {
  value = "ssh -i ~/.ssh/aws_key_pair.pem ubuntu@${aws_instance.own_server_practice.public_ip}"
}
