# main.tf

provider "aws" {
  region = "us-east-1"
}

# using the ec2 instance modules
module "ec2_instance" {
  source = "./modules/ec2_instance"
  ami           = "ami-04b4f1a9cf54c11d0"
  instance_type = "t2.micro"

  tags = {
    Name        = "my-instance"
    Environment = "dev"
  }
}

output "instance_id" {
  value = module.ec2_instance.instance_id
}

output "public_ip" {
  value = module.ec2_instance.public_ip
}