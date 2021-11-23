

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

resource "aws_subnet" "private_a" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.0.16/28"
  availability_zone = "${var.region}a"
  map_public_ip_on_launch = false

  tags = {
    Name = "minecraft-private"
  }
}

resource "aws_subnet" "public_a" {
  vpc_id     = aws_vpc.main.vpc.id
  cidr_block = "10.0.0.0/28"
  availability_zone = "${var.region}a"
  map_public_ip_on_launch = true

  tags = {
    Name = "minecraft-public-${var.region}a"
  }
}

resource "aws_subnet" "private_b" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.0.48/28"
  availability_zone = "${var.region}b"
  map_public_ip_on_launch = false

  tags = {
    Name = "minecraft-private-${var.region}b"
  }
}

resource "aws_subnet" "public_b" {
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

resource "aws_route_table_association" "public_a" {
  subnet_id      = aws_subnet.public_a.id
  route_table_id = aws_route_table.main.id
}

resource "aws_route_table_association" "private_a" {
  subnet_id      = aws_subnet.private_a.id
  route_table_id = aws_route_table.main.id
}
resource "aws_route_table_association" "public_b" {
  subnet_id      = aws_subnet.public_b.id
  route_table_id = aws_route_table.main.id
}

resource "aws_route_table_association" "private_b" {
  subnet_id      = aws_subnet.private_b.id
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