

provider "aws" {
  alias = var.aws_region_alias
  region = var.aws_region
}

# VPC and Subnets
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  instance_tenancy = "default"
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "minecraft-vpc-${}"
  }
}

resource "aws_subnet" "private" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.0.0/26"
  availability_zone = 
  map_public_ip_on_launch = false

  tags = {
    Name = "minecraft-private"
  }
}

resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.main.vpc.id
  cidr_block = "10.0.0.0/26"
  availability_zone = us-east-1a
  map_public_ip_on_launch = true

  tags = {
    Name = "minecraft-private"
  }
}

# IG and Routes
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
}

resource "aws_route_table" "main" {
  vpc_id = aws_vpc.main.id

  route = [
    {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.main.id
    }
  ]
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.main.id
}

resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.main.id
}

# ***************** SECURITY GROUPS *****************

