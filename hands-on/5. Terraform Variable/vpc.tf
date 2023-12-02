# Create VPC
resource "aws_vpc" "vpc_custom" {
  cidr_block       = "10.10.0.0/16"
  instance_tenancy = "default"
  tags = {
    Name   = "vpc_custom_terraform"
    "env"  = "dev"
    "user" = "ngochung1809"
  }
}

# Create Internet Gateway
resource "aws_internet_gateway" "igw_custom" {
  vpc_id = aws_vpc.vpc_custom.id
  tags = {
    Name = "igw_custom"
  }
}
# Create Subnet
resource "aws_subnet" "custom_subnet_01" {
  vpc_id            = aws_vpc.vpc_custom.id
  cidr_block        = "10.10.0.0/26"
  availability_zone = "us-east-1a"
  tags = {
    Name = "subnet_01"
  }
}
# Create Route Table
resource "aws_route_table" "route_table_custom" {
  vpc_id = aws_vpc.vpc_custom.id
  tags = {
    Name = "route_table_custom"
  }
}

resource "aws_default_route_table" "route_table_default_custom" {
  default_route_table_id = aws_vpc.vpc_custom.default_route_table_id
  tags = {
    Name = "route_table_default_custom"
  }
}
# Create route
resource "aws_route" "custom_route" {
  # Routing to routable
  route_table_id         = aws_route_table.route_table_custom.id
  destination_cidr_block = "0.0.0.0/0"
  # Expose to Internet Gateway
  gateway_id = aws_internet_gateway.igw_custom.id
}
# association rtb and subnet_custom
resource "aws_route_table_association" "rtb_association" {
  subnet_id      = aws_subnet.custom_subnet_01.id
  route_table_id = aws_route_table.route_table_custom.id
}

# Deny All protocol default nacls
resource "aws_default_network_acl" "default" {
  default_network_acl_id = aws_vpc.vpc_custom.default_network_acl_id
}
# Create NACLs
resource "aws_network_acl" "custom_nacl" {
  vpc_id = aws_vpc.vpc_custom.id
  # Association to subnet id
  subnet_ids = [aws_subnet.custom_subnet_01.id]

  ingress {
    from_port  = 22
    to_port    = 22
    protocol   = "6" # tcp
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
  }

  ingress {
    from_port  = 8
    to_port    = 0
    icmp_type  = 8
    icmp_code  = 0
    protocol   = "icmp" # icmp
    rule_no    = 200
    action     = "allow"
    cidr_block = "0.0.0.0/0"
  }

  egress {
    from_port  = 0
    to_port    = 0
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
  }

  tags = {
    Name  = "custom_nacls"
    "env" = "allow protocol icmp"
  }
}