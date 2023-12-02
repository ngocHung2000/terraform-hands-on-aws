resource "aws_instance" "ec2-vm-server" {
    ami = ""
    security_groups = [ "","","" ]
    instance_type = "t2.micro"
    user_data = file("${path.module}/install.sh")
    tags = {
      name = "ec2-instace-test"
    }
}

# terraform init
# terraform fmt
# terraform plan -destroy
# terraform apply -auto-approve
# terraform destroy -auto-approve