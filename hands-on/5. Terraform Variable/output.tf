output "ec2_instace_icmp_public_ip" {
  value = aws_instance.custom_instace.public_ip
}