aws_region = "us-east-1"
ec2_instance_list = {
  "instace_01" = {
        ami                         = "ami-0230bd60aa48260c6"
        instance_type               = "t2.micro"
        subnet_id                   = 1
        key_pair                    = "key1.pem"
        vpc_security_group_ids      = [1]
        associate_public_ip_address = true
  }
  "instace_02" = {
        ami                         = "ami-0230bd60aa48260c6"
        instance_type               = "t2.micro"
        subnet_id                   = 1
        key_pair                    = "key2.pem"
        vpc_security_group_ids      = [1]
        associate_public_ip_address = false
  }
}

# map(object({
#     ec2_instace = object({
#       ami                             = string
#       instance_type                   = string
#       subnet_id                       = string
#       key_pair                        = optional(string)
#       vpc_security_group_ids          = set(string)
#       associate_public_ip_address     = bool
#     }) 
#   }))