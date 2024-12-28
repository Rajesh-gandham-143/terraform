resource "aws_vpc" "main_vpc" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"

  tags = {
    Name = "Rajesh_vpc"
  }
}




resource "aws_subnet" "subnet_1" {
  vpc_id                  = aws_vpc.main_vpc.id
  availability_zone       = var.availability_zone_1
  cidr_block              = var.subnet_1_cidr
  map_public_ip_on_launch = var.map_public_ip_on_launch

  tags = {
    Name = "Rajesh_subnet1"
  }
}



resource "aws_subnet" "subnet_2" {
  vpc_id                  = aws_vpc.main_vpc.id
  availability_zone       = var.availability_zone_2
  cidr_block              = var.subnet_2_cidr
  map_public_ip_on_launch = var.map_public_ip_on_launch

  tags = {
    Name = "Rajesh_subnet2"
  }
}



resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "Rajesh_igw"
  }
}

resource "aws_route_table" "route_table_1" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = var.route_cidr
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "Rajesh_public_route_table"
  }
}

resource "aws_route_table" "route_table_2" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "Rajesh_private_route_table"
  }
}

resource "aws_route_table_association" "table_association_1" {
  subnet_id      = aws_subnet.subnet_1.id
  route_table_id = aws_route_table.route_table_1.id
}

resource "aws_route_table_association" "table_association_2" {
  subnet_id      = aws_subnet.subnet_2.id
  route_table_id = aws_route_table.route_table_2.id
}