
# Data source :  get the latest Amazon Linux 2 AMI
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

locals {
  user_data = <<EOF
#!/usr/bin/bash
yum install docker -y
systemctl enable docker
systemctl start docker
docker run -d -p 80:80 --name dokuwiki bitnami/dokuwiki:latest
EOF
}

# Use the retrieved AMI in an EC2 instance
resource "aws_instance" "example" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t2.micro"
  # Connect to the VPC and Security group
  subnet_id              = aws_subnet.my_subnet.id
  vpc_security_group_ids = [aws_security_group.web.id]

  # User data script to configure the instance
  user_data  = base64encode(local.user_data)


  # attach with my key pair
  key_name = "aws_key"


}