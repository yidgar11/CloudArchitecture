variable "environment" {
  default = true
}

resource "aws_instance" "web" {
  ami           = var.environment && "ami-04b4f1a9cf54c11d0" || "ami-04b4f1a9cf54c11d7"
  instance_type = "t2.micro"
}

locals {
  frutes = ["apple", "banana", "orange"]
}

# print value from array
output "favorite_frutes"  {
  //value = element(local.fruet, 1)
  ## same as above
  value = local.fruet[1]
}

# change flow to integer
locals {
  pi = 3.141256
}

output "round_pi" {
  value = floow(local.pi)
}