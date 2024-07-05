resource "aws_vpc" "mainvpc" {
  cidr_block       = var.mainvpc_cidr_block
  enable_dns_hostnames = true
  instance_tenancy = "default"

  tags = {
    Name = "${var.environment}_mainvpc"
  }
}

resource "aws_subnet" "PublicSubnet1" {
  vpc_id            = aws_vpc.mainvpc.id
  cidr_block        = var.PublicSubnet1_cidr_block
  availability_zone = var.PublicSubnet1_AZ

  tags = {
    Name = "${var.environment}_PublicSubnet1"
  }
}

resource "aws_subnet" "PrivateSubnetsForDB" {
  count             = 2
  vpc_id            = aws_vpc.mainvpc.id
  cidr_block        = element(["${var.PrivateSubnet1_cidr_block}", "${var.PrivateSubnet2_cidr_block}"], count.index)
  availability_zone = element(["${var.PrivateSubnet1_AZ}", "${var.PrivateSubnet2_AZ}"], count.index)

  tags = {
    Name = "${var.environment}_PrivateSubnet${count.index + 1}"
  }
}

resource "aws_db_subnet_group" "db_subnet_group1" {
  name = "${var.environment}_db_subnet_group1"
  subnet_ids = [
    aws_subnet.PrivateSubnetsForDB[0].id,
    aws_subnet.PrivateSubnetsForDB[1].id
  ]

  tags = {
    Name = "${var.environment}_db_subnet_group1"
  }
}

resource "aws_internet_gateway" "mainIGW" {
  vpc_id = aws_vpc.mainvpc.id

  tags = {
    Name = "${var.environment}_mainIGW"
  }
}

resource "aws_route_table" "PublicRouteTable" {
  vpc_id = aws_vpc.mainvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.mainIGW.id
  }

  tags = {
    Name = "${var.environment}_PublicRouteTable"
  }
}

resource "aws_route_table" "PrivateRouteTable" {
  vpc_id = aws_vpc.mainvpc.id

  tags = {
    Name = "${var.environment}_PrivateRouteTable"
  }
}

resource "aws_route_table_association" "PublicSubnet1Association" {
  subnet_id      = aws_subnet.PublicSubnet1.id
  route_table_id = aws_route_table.PublicRouteTable.id
}

resource "aws_route_table_association" "PrivateSubnetsForDBAssociation" {
  count          = 2
  subnet_id      = aws_subnet.PrivateSubnetsForDB["${count.index}"].id
  route_table_id = aws_route_table.PrivateRouteTable.id
}

