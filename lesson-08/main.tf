
module "my_vpc" {
  source = "./modules/vpc"
  # Pass all the input variables to the module
  # make sure to define them in the module variables.tf with "name" and "type" (optional - default value)
  vpc_name = var.vpc_name
  vpc_cidr = var.vpc_cidr
  region   = var.region

  # Note that the module outputs are the ones returned and ca be used in other tf files
}

module "my_security" {
  source = "./modules/security"
  # define vpc_id in output.tf in the VPC Module
  # and define vpc_id  as input variable in the security module variables.tf
  sg_name = var.sg_name
  vpc_id = module.my_vpc.vpc_id
  cidr_block = var.vpc_cidr
}

# module "my_alb" {
#   source = "./modules/alb"
#
#   alb_name    = var.alb_name
#   vpc_id  = module.my_vpc.vpc_id
#   vpc_public_subnets = module.my_vpc.public_subnets
# }

# module "asg" {
#   source = "./modules/asg"
#   # define vpc_id in output.tf in the VPC Module
#   # and define vpc_id  as input variable in the security module variables.tf
#   vpc_id = module.my_vpc.vpc_id
#   lt_name = var.lt_name
#   image_id      = "TBD"
#   key_name      = var.lunch_template_key_name
#   instance_type = var.instance_type
#   security_group_id = module.my_security.security_group_id
#   sg_id = "TBD"
# }
#
# output "asg_id" {
#   value = module.asg.asg_id
# }

module "rds" {
  source                 = "./modules/rds"
  db_engine              = var.db_engine
  db_engine_version      = var.db_engine_version
  db_root_username       = var.db_root_username
  db_root_password       = var.db_root_password
  rds_security_group_ids = [module.my_vpc.rds_sg_id]
  rds_name               = var.rds_name
  subnet_ids             = module.my_vpc.private_subnets
  environment            = var.environment
}