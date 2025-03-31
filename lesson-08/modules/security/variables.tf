
variable "sg_name" {
  description = "security group name"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "cidr_block" {
  description = "The cidr block "
  type        = string
}



#
# data "aws_vpc" "default_vpc" {
#   default = true
# }
#
# data "aws_subnet_ids" "subnets" {
#   vpc_id = data.aws_vpc.default_vpc.id
# }
#
# data "aws_security_group" "default-sg" {
#   name = "default"
# }
#
#
#
# variable "public_subnets" {
#   description = "list of public subnets"
#   type        = string
# }