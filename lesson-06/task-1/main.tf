# 1. Create a new VPC
resource "aws_vpc" "my_vpc" {
  cidr_block           = "10.0.0.0/16"
  # enable_dns_support   = true
  # enable_dns_hostnames = true
  tags = {
    Name = "my-vpc"
  }
}

# 2. Create a subnet within the VPC my_vpc
resource "aws_subnet" "my_subnet" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.1.0/24"
  # map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"
  tags = {
    Name = "my-subnet"
  }
}

# 3. Create Security group with ingress rule allowing communication from anywhere on port 80
# named: dokuwiki-sg
# SG will be connected to the VPC my_vpc
resource "aws_security_group" "web" {
  name        = "dokuwiki-sg"
  description = "Allow web incgress and egress http/https traffic"
  vpc_id      = aws_vpc.my_vpc.id
  tags = {
    Name = "my-sg"
  }

  # SG - http port
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

    # SG - ssh port
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # SG - Open access to public network
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create Internet GW and connect to VPC my_vpc
resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "my-igw"
  }
}

# Create a route table and connect to VPC my_vpc
resource "aws_route_table" "my_rt" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "my-public-rt"
  }
}

# Add the route  table to the internet Gateway
resource "aws_route" "my_route" {
  route_table_id         = aws_route_table.my_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.my_igw.id
}

# Associate the Route Table with a Subnet
resource "aws_route_table_association" "my_rta" {
  subnet_id      = aws_subnet.my_subnet.id
  route_table_id = aws_route_table.my_rt.id
}