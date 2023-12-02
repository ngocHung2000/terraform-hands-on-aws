terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  # region = ""
  profile = "default"
}

provider "aws" {
  profile = "dev-account"
  alias   = "aws_dev_account"
}

resource "aws_security_group" "sg-instace-custom" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  ingress {
    description      = "TLS from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}

// To Generate Private Key
resource "tls_private_key" "rsa_4096" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

// Create Key Pair for Connecting EC2 via SSH
resource "aws_key_pair" "key_pair" {
  key_name   = "demo-key.pem"
  public_key = tls_private_key.rsa_4096.public_key_openssh
  depends_on = [ tls_private_key.rsa_4096 ]
}

// Save PEM file locally
resource "local_file" "private_key" {
  content  = tls_private_key.rsa_4096.private_key_pem
  filename = aws_key_pair.key_pair.key_name
  file_permission = "0400"

  depends_on = [ aws_key_pair.key_pair ]
}

resource "aws_instance" "instace-custom" {
  ami = "ami-06e4ca05d431835e9"
  tags = {    
    "name"          : var.name_vpc
    "vpc_resource"  : "change vpc"
    "Name"            : "vpc-custom-hehe"
  }
  vpc_security_group_ids = [ se ]
  tags_all = {
    Name = "ec2-instace-custom-demo"
    "user" = "hello ec2"
  }
  key_name = aws_key_pair.key_pair.key_name
  instance_type = "t2.micro"
  user_data = file("${path.module}/nginx.sh")
}
