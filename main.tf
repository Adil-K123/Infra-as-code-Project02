resource "aws_vpc" "mainvpc" {
  cidr_block       = "192.168.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "mainvpc"
  }
}

resource "aws_subnet" "PublicSubnet1" {
  vpc_id     = aws_vpc.mainvpc.id
  cidr_block = "192.168.0.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "PublicSubnet1"
  }
}

resource "aws_subnet" "PrivateSubnetsForDB" {
  count = 2
  vpc_id     = aws_vpc.mainvpc.id
  cidr_block = element(["192.168.1.0/24","192.168.2.0/24"], count.index)
  availability_zone = element(["us-east-1a","us-east-1b"],count.index)

  tags = {
    Name = "PrivateSubnet${count.index+1}"
  }
}

resource "aws_db_subnet_group" "db_subnet_group1" {
  name       = "db_subnet_group1"
  subnet_ids = [
    aws_subnet.PrivateSubnetsForDB[0].id,
    aws_subnet.PrivateSubnetsForDB[1].id
    ]

  tags = {
    Name = "db_subnet_group1"
  }
}

resource "aws_internet_gateway" "mainIGW" {
  vpc_id = aws_vpc.mainvpc.id

  tags = {
    Name = "mainIGW"
  }
}

resource "aws_route_table" "PublicRouteTable" {
  vpc_id = aws_vpc.mainvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.mainIGW.id
  }

  tags = {
    Name = "PublicRouteTable"
  }
}

resource "aws_route_table" "PrivateRouteTable" {
  vpc_id = aws_vpc.mainvpc.id

  tags = {
    Name = "PrivateRouteTable"
  }
}

resource "aws_route_table_association" "PublicSubnet1Association" {
  subnet_id      = aws_subnet.PublicSubnet1.id
  route_table_id = aws_route_table.PublicRouteTable.id
}

resource "aws_route_table_association" "PrivateSubnetsForDBAssociation" {
  count = 2
  subnet_id      = aws_subnet.PrivateSubnetsForDB["${count.index}"].id
  route_table_id = aws_route_table.PrivateRouteTable.id
}

resource "aws_security_group" "Project02WebServer_SG" {
  name        = "Project02WebServer_SG"
  description = "security group using Terraform"
  vpc_id      = aws_vpc.mainvpc.id

  ingress {
    description      = "HTTPS"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "Project02WebServer_SG"
  }
}

resource "aws_security_group" "Project02RDS_SG" {
  name = "Project02RDS_SG"
  description = "SG for RDS"
  vpc_id = aws_vpc.mainvpc.id

  ingress {
    description      = "Allow SQL Traffic only from Webserver"
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    security_groups  = [aws_security_group.Project02WebServer_SG.id]
  }

  tags = {
    Name = "Project02RDS_SG"
  }
  
}

resource "tls_private_key" "key" {
  algorithm = "RSA"
}

resource "aws_key_pair" "Webserver-ssh-key" {
  key_name = "Webserver-ssh-key"
  public_key = tls_private_key.key.public_key_openssh
}

resource "aws_instance" "Webserver" {
  ami           = "ami-04b70fa74e45c3917"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.Project02WebServer_SG.id]
  key_name = aws_key_pair.Webserver-ssh-key.key_name
  subnet_id     = aws_subnet.PublicSubnet1.id
  associate_public_ip_address = true
  tags = {
    Name = "WebServer"
  }
}

resource "aws_db_instance" "productreviewRDS" {
  allocated_storage    = 20
  storage_type         = "gp2"
  db_name              = "productreviewdb"
  identifier           = "productreviewdb" 
  engine               = "mysql"
  engine_version       = "8.0.35"
  multi_az             = false
  instance_class       = "db.t3.micro"
  username             = "adilk"
  password             = "Sql12345"
  db_subnet_group_name = aws_db_subnet_group.db_subnet_group1.name
  vpc_security_group_ids = [aws_security_group.Project02RDS_SG.id]
  skip_final_snapshot  = true
  parameter_group_name    = "default.mysql8.0"
  auto_minor_version_upgrade  = false 
}

terraform {
  cloud {
    organization = "adilk_terraform"

    workspaces {
      name = "AWS_INFRA_TEST"
    }
  }
}
