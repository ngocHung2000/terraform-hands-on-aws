terraform {
    required_providers {
      aws = {
        source = "hashicorp/aws"
      }
    }
}

provider "aws" {
    region = var.region
    profile = "default"
}

resource "aws_vpc" "vpc-custom-demo" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  tags = {
    Name = "vpc-custom"
  }
}