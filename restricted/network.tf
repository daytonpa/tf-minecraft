

provider "aws" {
  alias = "use1"
  region = "us-east-1"
}

# VPC and Subnets
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/24"
  instance_tenancy = "default"
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "minecraft-vpc"
  }
}

resource "aws_subnet" "private" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.0.0/26"
  availability_zone = us-east-1a
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

resource "aws_security_group" "base" {
  name = "minecraft-vpc-base"
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}