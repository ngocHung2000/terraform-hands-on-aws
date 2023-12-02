variable "aws_region" {
  type        = string
  description = "AWS Region"
}

variable "key_ssh" {
  type        = string
  default     = "ssh.pem"
  description = "key remote ssh server"
}

variable "ec2_instance_list" {
  type = map(object({
    ec2_instace = object({
      ami                             = string
      instance_type                   = string
      subnet_id                       = string
      key_pair                        = string
      security_groups                 = set(string)
      associate_public_ip_address     = bool
    }) 
  }))
}