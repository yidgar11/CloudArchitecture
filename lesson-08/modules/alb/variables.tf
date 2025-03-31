

variable "alb_name" {
  description = "ALB Name"
  type        = string
}


variable "vpc_id" {
  description = "VPC ID"
  type        = string
}


variable "vpc_public_subnets" {
  description = "VPC subnets"
  type        = any
}
