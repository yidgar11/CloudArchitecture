variable "environment" {
  default = "production"
}

resource "aws_instance" "web" {
  ami           = var.environment == "production" ? "ami-04b4f1a9cf54c11d0" : "ami-Other"
  instance_type = "t2.micro"
}

# locals {
#   second_fruit = "banana"
# }
#
# output "second_fruit" {
#   value = locals.second_frout
# }