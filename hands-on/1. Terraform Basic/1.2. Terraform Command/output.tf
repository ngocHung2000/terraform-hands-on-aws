output "public_ip_address" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.ec2-demo.public_ip
}