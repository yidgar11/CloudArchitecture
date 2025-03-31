# Variable Template
# variable "TBD" {
#   description = "TBD "
#   type        = string
#   default     = "TBD"
# }

##########################################
# VPC
##########################################
variable "region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"  # You can set a default or leave it without one
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpc_name" {
  description = "VPC Name"
  type        = string
  default     = "yidgar-vpc"
}

##########################################
## Security group
##########################################
variable "sg_name" {
  description = "Security Group name"
  type        = string
  default     = "yidgar_security_group"
}

# variable "sg_id" {
#   type = string
#   description = "security group id "
# }


##########################################
# ALB
##########################################
variable "alb_name" {
  description = "ALB Name"
  type        = string
  default =  "yidgar-alb"
}

##########################################
### ASG
##########################################
variable "lt_name" {
  description = "Lunch Template_name"
  type        = string
  default = "my-lunch_template"
}

variable "image_id" {
  description = "Lunch Template_name"
  type        = string
  default     = "TBD"
}

variable "lunch_template_key_name" {
  description = "Lunch Template_name"
  type        = string
  default = "Dev"
}

variable "environment" {
  description = "Environment name "
  type        = string
  default     = "dev"
}

variable "instance_type" {
  type = string                     # The type of the variable, in this case a string
  default = "t2.micro"                 # Default value for the variable
  description = "The type of EC2 instance" # Description of what this variable represents
}

##########################################
## RDS Database
##########################################
variable "db_engine" {
  description = "db engine type in RDS"
  type        = string
  default     = "mysql"
}

variable "db_engine_version" {
  description = "RDS engine DB Version  "
  type        = string
  default     = "8.0"
}

variable "db_root_username" {
  description = "RDS root `username "
  type        = string
  default     = "root"
}

variable "db_root_password" {
  description = "RDS DB Root Password "
  type        = string
  default     = "password"
}


variable "rds_name" {
  description = "RDS Instance Name "
  type        = string
  default     = ""yidgar_rds"
}



