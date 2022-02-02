

provider "aws" {
  alias = "use1"
  region = "us-east-1"
}

# VPC and Subnets
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/26"
  instance_tenancy = "default"
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "minecraft-vpc"
  }
}
resource "aws_subnet" "private_primary" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.0.16/28"
  availability_zone = "${var.region}a"
  map_public_ip_on_launch = false

  tags = {
    Name = "minecraft-private"
  }
}
resource "aws_subnet" "public_primary" {
  vpc_id     = aws_vpc.main.vpc.id
  cidr_block = "10.0.0.0/28"
  availability_zone = "${var.region}a"
  map_public_ip_on_launch = true

  tags = {
    Name = "minecraft-public-${var.region}a"
  }
}
resource "aws_subnet" "private_recovery" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.0.48/28"
  availability_zone = "${var.region}b"
  map_public_ip_on_launch = false

  tags = {
    Name = "minecraft-private-${var.region}b"
  }
}
resource "aws_subnet" "public_recovery" {
  vpc_id     = aws_vpc.main.vpc.id
  cidr_block = "10.0.0.32/28"
  availability_zone = "${var.region}b"
  map_public_ip_on_launch = true

  tags = {
    Name = "minecraft-public-${var.region}b"
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

resource "aws_route_table_association" "private_primary" {
  subnet_id      = aws_subnet.private_primary.id
  route_table_id = aws_route_table.main.id
}

resource "aws_route_table_association" "private_recovery" {
  subnet_id      = aws_subnet.private_recovery.id
  route_table_id = aws_route_table.main.id
}
resource "aws_route_table_association" "public_primary" {
  subnet_id      = aws_subnet.public_primary.id
  route_table_id = aws_route_table.main.id
}

resource "aws_route_table_association" "public_recovery" {
  subnet_id      = aws_subnet.public_recovery.id
  route_table_id = aws_route_table.main.id
}
