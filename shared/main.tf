# module "shared_ecr" {
#     source = "./modules/ecr"
# }

# module "iam_roles" {
#     source = "./modules/iam"
# }

# module "shared_vpc" {
#     source = "./modules/vpc"
#     environment = "${var.environment}"
#     mainvpc_cidr_block = "10.3.0.0/16"
#     PublicSubnet1_cidr_block = "10.3.0.0/24"
#     PrivateSubnet1_cidr_block = "10.3.1.0/24"
#     PrivateSubnet2_cidr_block = "10.3.2.0/24"
# }

# resource "aws_security_group" "Monitoring_Server_SG" {
#   name        = "Monitoring_Server_SG"
#   description = "security group for Monitoring server"
#   vpc_id      = "${module.shared_vpc.mainvpcid}"

#   ingress {
#     description      = "HTTPS"
#     from_port        = 443
#     to_port          = 443
#     protocol         = "tcp"
#     cidr_blocks      = ["0.0.0.0/0"]
#     ipv6_cidr_blocks = ["::/0"]
#   }

#   ingress {
#     description      = "HTTP"
#     from_port        = 80
#     to_port          = 80
#     protocol         = "tcp"
#     cidr_blocks      = ["0.0.0.0/0"]
#     ipv6_cidr_blocks = ["::/0"]
#   }

#   ingress {
#     description      = "SSH"
#     from_port        = 22
#     to_port          = 22
#     protocol         = "tcp"
#     cidr_blocks      = ["0.0.0.0/0"]
#     ipv6_cidr_blocks = ["::/0"]
#   }

#  ingress {
#     description      = "Prometheus_server"
#     from_port        = 9090
#     to_port          = 9090
#     protocol         = "tcp"
#     cidr_blocks      = ["0.0.0.0/0"]
#     ipv6_cidr_blocks = ["::/0"]
#   }
  
#   ingress {
#     description      = "Grafana_server"
#     from_port        = 3000
#     to_port          = 3000
#     protocol         = "tcp"
#     cidr_blocks      = ["0.0.0.0/0"]
#     ipv6_cidr_blocks = ["::/0"]
#   }

#   egress {
#     from_port        = 0
#     to_port          = 0
#     protocol         = "-1"
#     cidr_blocks      = ["0.0.0.0/0"]
#     ipv6_cidr_blocks = ["::/0"]
#   }

#   tags = {
#     Name = "${var.environment}_Monitoring_Server_SG"
#   }
# }

# resource "aws_instance" "Monitoring_server" {
#   ami                         = "ami-04b70fa74e45c3917"
#   instance_type               = "t2.micro"
#   vpc_security_group_ids      = [aws_security_group.Monitoring_Server_SG.id]
#   key_name                    = "flask_ec2"
#   subnet_id                   = "${module.shared_vpc.PublicSubnet1id}"
#   associate_public_ip_address = true
#   count                       = 1
#   tags = {
#     Name = "MonitoringServer${count.index + 1}"
#   }
# }



