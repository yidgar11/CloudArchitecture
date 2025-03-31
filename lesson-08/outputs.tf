output "instance_public_ip" {
  value = "TBD"                                          # The actual value to be outputted
  description = "The public IP address of the EC2 instance" # Description of what this output represents
}

output "vpc_id" {
  value = module.my_vpc.vpc_id
}

output "security_group_id" {
  value = module.my_security.security_group_id
}

