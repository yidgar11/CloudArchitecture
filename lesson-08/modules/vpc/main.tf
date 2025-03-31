module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = var.vpc_name
  cidr = var.vpc_cidr # "10.0.0.0/16"

  azs             = ["${var.region}a", "${var.region}b", "${var.region}c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = false # Set to false to disable automatic creation
  enable_vpn_gateway = true

  private_subnet_tags = {
    "Name" = "private-subnet"
    "Tier" = "private"
  }

  public_subnet_tags = {
    "Name" = "public-subnet"
    "Tier" = "public"
  }

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}



# 1. Create Elastic IPs for the NAT Gateways
resource "aws_eip" "nat" {
  count = length(module.vpc.public_subnets)
  tags = {
    Name = "nat-eip-${count.index}"
  }
}

# 2. Create NAT Gateways in each PUBLIC subnet
resource "aws_nat_gateway" "nat_gateway" {
  count         = length(module.vpc.public_subnets)
  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = module.vpc.public_subnets[count.index]

  tags = {
    Name = "nat-gateway-${count.index}"
  }

  depends_on = [module.vpc.igw_id]  # Ensure the Internet Gateway exists before creating NAT Gateways
  # the igw_id is exposed in the OUTPUT of  vpc module that yidgar_vpc is using
}

# 3. Update the route tables for PRIVATE subnets to use the NAT Gateways
resource "aws_route" "private_nat_gateway" {
  count                  = length(module.vpc.private_route_table_ids)
  route_table_id         = module.vpc.private_route_table_ids[count.index]
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gateway[count.index % length(aws_nat_gateway.nat_gateway)].id
}

# The route tables are already created by the VPC module
# Now we just need to add the routes

# PUBLIC subnets route to the Internet Gateway (this is usually done automatically by the VPC module)
resource "aws_route" "public_internet_gateway" {
  count                  = length(module.vpc.public_route_table_ids)
  route_table_id         = module.vpc.public_route_table_ids[count.index]
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = module.vpc.igw_id
}