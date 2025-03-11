provider "aws" {
  region = "us-east-1"
}
resource "aws_instance" "web" {
  count = 3
  ami = "ami-1234"
  instance_type = "t2.micro"
  tags = {
    Name = "web-server-${count.index + 1}"
  }
  lifecycle {
    create_before_destroy = true
  }
}

output "public_ips" {
  value = aws_instance.web.*.public_ip
} # or use count index