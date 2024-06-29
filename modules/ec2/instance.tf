resource "aws_security_group" "Project02WebServer_SG" {
  name        = "${var.environment}_Project02WebServer_SG"
  description = "security group for ${var.environment} webservers"
  vpc_id      = var.mainvpcid

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
    Name = "${var.environment}_Project02WebServer_SG"
  }
}

# resource "tls_private_key" "key" {
#   algorithm = "RSA"
# }

# resource "aws_key_pair" "Webserver-ssh-key" {
#   key_name   = "${var.environment}_Webserver-ssh-key"
#   public_key = tls_private_key.key.public_key_openssh
# }

resource "aws_instance" "Webserver" {
  ami                         = "ami-04b70fa74e45c3917"
  instance_type               = "t2.micro"
  vpc_security_group_ids      = [aws_security_group.Project02WebServer_SG.id]
  iam_instance_profile        = data.aws_iam_instance_profile.ec2_instance_profile.name
  key_name                    = "flask_ec2"
  subnet_id                   = var.PublicSubnet1_id
  associate_public_ip_address = true
  count                       = var.Ec2InstanceCount
  tags = {
    Name = "${var.environment}WebServer${count.index + 1}"
  }
}



