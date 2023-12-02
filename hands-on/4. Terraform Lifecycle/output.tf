# output "vpc_output" {
#   value       = aws_vpc.vpc-custom.arn
#   description = "Amazon Resource Name"
# }

# output "vpc_output_cidr" {
#   value       = aws_vpc.vpc-custom.cidr_block
#   description = "CIDR Block VPC"
# }

output "instace-public-ip" {
  value = aws_instance.instace-custom.public_ip
  description = "IP Public instace"
}

output "sg-name-instace" {
  value = aws_security_group.sg-instace-custom.name
  description = "Security Group name instace"
}