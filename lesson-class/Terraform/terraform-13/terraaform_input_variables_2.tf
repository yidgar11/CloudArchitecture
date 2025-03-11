# provider "aws" {
#   region = "us-east-1"
# }
# variable "availability_zones" {
#   type        = list(string)
#   default     = ["us-east-1a", "us-east-1b"]
#   description = "List of availability zones"
# }
# resource "aws_instance" "example" {
#   count         = length(var.availability_zones) # create number of instances as the list length
#   ami           = "ami-04b4f1a9cf54c11d0"
#   instance_type = "t2.micro"
#   # by the count index, we will connect to specific availablity zone
#   availability_zone = element(var.availability_zones, count.index)
# }
#
# # use an input value
# # terrafrom apply -var="availability_zones=[\"us-east-1c\", \"us-east-1d\"]'