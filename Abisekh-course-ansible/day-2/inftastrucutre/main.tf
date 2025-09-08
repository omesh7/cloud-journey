data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_key_pair" "ansible_key" {
  key_name   = "ansible-key"
  public_key = file("../../ssh/ansible-key.pub")
}

resource "aws_security_group" "ansible_sg" {
  name_prefix = "ansible-sg"

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
}

resource "aws_instance" "managed_nodes" {
  count                  = 3
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.ansible_key.key_name
  vpc_security_group_ids = [aws_security_group.ansible_sg.id]

  instance_market_options {
    market_type = "spot"
    spot_options {
      max_price = "0.005"
    }
  }

  tags = {
    Name = "ansible-managed-node-${count.index + 1}"
    Type = "managed-node"
  }

  user_data = file("startup.sh")
}

output "managed_nodes_ips" {
  value = {
    for i, instance in aws_instance.managed_nodes :
    "node-${i + 1}" => {
      public_ip  = instance.public_ip
      private_ip = instance.private_ip
    }
  }
}
