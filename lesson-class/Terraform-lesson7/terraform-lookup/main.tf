# this is like a dictionary
variable "ami_ids" {
  type = map(string)
  default = {
    us-west-1 = "ami-12345"
    us-west-2 = "ami-34567"
    us-east-1 = "ami-56789"
  }
}
variable "region" {
  default = "us-east-1"
}
variable "instance_type" {
  default = "t2.micro"
}

resource "aws_instance" "web" {
  ami           = lookup(var.ami_ids, var.region)
  instance_type = var.instance_type
}