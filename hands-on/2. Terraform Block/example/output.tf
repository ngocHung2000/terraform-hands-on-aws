output "aws_vpc_custom" {
  value = aws_vpc.vpc_custom_network.tags
}

output "aws_vpc_custom_id" {
  value = aws_vpc.vpc_custom_network.id
}