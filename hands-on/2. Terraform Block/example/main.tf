terraform {
  required_version = ">= 1.5.7"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.28.0"
    }
  }
}

provider "aws" {
  profile = var.aws_account_profile
  region  = var.aws_region
}

resource "aws_vpc" "vpc_custom_network" {
  cidr_block       = "10.10.10.0/24"
  instance_tenancy = "default"
  tags = {
    name = "vpc-custom"
  }
}

