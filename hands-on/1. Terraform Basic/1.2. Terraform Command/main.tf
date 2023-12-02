terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      #   version = "5.28.0"
    }
  }
}

provider "aws" {
  profile = "default"      #  Sử dụng aws account của profile nào
  region  = var.aws_region # Region muốn khởi tạo tài nguyên
}

resource "aws_instance" "ec2-demo" {
  ami           = "ami-0230bd60aa48260c6"
  instance_type = var.aws_instance_type

  tags = {
    Name = "ec2-instace-demo-ne"
  }
}