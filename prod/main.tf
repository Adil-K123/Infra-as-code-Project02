module "prod_vpc" {
  source             = "./modules/vpc"
  environment        = var.environment
  mainvpc_cidr_block = var.mainvpc_cidr_block
  PublicSubnet1      = var.PublicSubnet1
  PrivateSubnet1     = var.PrivateSubnet1
  PrivateSubnet2     = var.PrivateSubnet2
}

module "prod_ec2" {
  source           = "./modules/ec2"
  environment      = var.environment
  mainvpcid        = module.prod_vpc.mainvpcid
  PublicSubnet1_id = module.prod_vpc.PublicSubnet1id
  Ec2InstanceCount = var.Ec2InstanceCount
}

module "prod_rds" {
  source            = "./modules/rds"
  environment       = var.environment
  mainvpcid         = module.prod_vpc.mainvpcid
  webserverSGid     = module.prod_ec2.webserverSGid
  dbusername        = var.dbusername
  dbpassword        = var.dbpassword
  dbsubnetgroupname = module.prod_vpc.dbsubnetgroupname
}

