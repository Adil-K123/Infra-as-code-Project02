resource "aws_security_group" "Project02RDS_SG" {
  name = "${var.environment}_Project02RDS_SG"
  description = "SG for ${var.environment} RDS"
  vpc_id = "${var.mainvpcid}"

  ingress {
    description      = "Allow SQL Traffic only from Webserver"
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    security_groups  = ["${var.webserverSGid}"]
  }

  tags = {
    Name = "${var.environment}_Project02RDS_SG"
  }
  
}

resource "aws_db_instance" "productreviewRDS" {
  allocated_storage    = "${var.allocated_storage}"
  storage_type         = "gp2"
  db_name              = "${var.environment}-productreviewdb"
  identifier           = "${var.environment}-productreviewdb" 
  engine               = "mysql"
  engine_version       = "8.0.35"
  multi_az             = false
  instance_class       = "db.t3.micro"
  username             = "${var.dbusername}"
  password             = "${var.dbpassword}"
  db_subnet_group_name = "${var.dbsubnetgroupname}"
  vpc_security_group_ids = [aws_security_group.Project02RDS_SG.id]
  skip_final_snapshot  = true
  parameter_group_name    = "default.mysql8.0"
  auto_minor_version_upgrade  = false 
}

