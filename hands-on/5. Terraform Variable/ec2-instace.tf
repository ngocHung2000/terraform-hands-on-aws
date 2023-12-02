resource "aws_security_group" "allow_icmp" {
  name   = "allow_icmp"
  vpc_id = aws_vpc.vpc_custom.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "6" # tcp
    cidr_blocks = ["0.0.0.0/0"]
    # ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    from_port   = 8
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
    # ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    # ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_icmp"
  }
}

resource "tls_private_key" "key_ssh" {
  algorithm = "RSA"
  rsa_bits  = "4096"
}

resource "local_file" "key_pair_remote" {
  content  = tls_private_key.key_ssh.private_key_openssh
  filename = "./private_key/${var.key_ssh}"

  file_permission = "0400"
}

resource "aws_key_pair" "public_key_aws" {
  key_name   = var.key_ssh
  public_key = tls_private_key.key_ssh.public_key_openssh
}

resource "aws_instance" "custom_instace" {
#   Amazon Linux 2
#   ami                         = "ami-0230bd60aa48260c6"
#   instance_type               = "t2.micro"
#   subnet_id                   = aws_subnet.custom_subnet_01.id
#   vpc_security_group_ids      = [aws_security_group.allow_icmp.id]
#   associate_public_ip_address = true
#   key_name                    = aws_key_pair.public_key_aws.key_name # or var.key_ssh
    for_each                    = var.ec2_instance_list
    
    ami                         = each.value.ami
    subnet_id                   = each.value.subnet_id
    security_groups             = each.value.security_groups
    associate_public_ip_address = each.value.associate_public_ip_address
    key_name                    = each.value.key_name
    tags = {
        Name = each.key
    }
    
}
