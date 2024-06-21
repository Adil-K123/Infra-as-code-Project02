module "dev_vpc" {
    source = "./modules/vpc"
    environment = "${var.environment}"
    mainvpc_cidr_block = "10.2.0.0/16"
    PublicSubnet1_cidr_block = "10.2.0.0/24"
    PrivateSubnet1_cidr_block = "10.2.1.0/24"
    PrivateSubnet2_cidr_block = "10.2.2.0/24"
}

module "dev_ec2" {
    source = "./modules/ec2"
    environment = "${var.environment}"
    mainvpcid = "${module.dev_vpc.mainvpcid}" 
    PublicSubnet1_id = "${module.dev_vpc.PublicSubnet1id}"
    inventoryfilename = "${path.module}/inventory/hosts.cfg"
}

module "dev_rds" {
    source = "./modules/rds"
    environment = "${var.environment}"
    mainvpcid = "${module.dev_vpc.mainvpcid}" 
    webserverSGid = "${module.dev_ec2.webserverSGid}"
    dbusername = var.dbusername
    dbpassword = var.dbpassword
    dbsubnetgroupname = "${module.dev_vpc.dbsubnetgroupname}"
}


