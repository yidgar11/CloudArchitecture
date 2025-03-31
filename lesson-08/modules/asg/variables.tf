variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "lt_name" {
  description = "Lunch Template_name"
  type        = string
}


variable "image_id" {
  description = "Lunch Template_name"
  type        = string
}

variable "key_name" {
  description = "Lunch Template_name"
  type        = string
}

variable "instance_type" {
  type = string
  description = "The type of EC2 instance"
}

variable "sg_id" {
  type = string
  description = "security group id "
}