# module "prod_vpc" {
#   source                    = "./modules/vpc"
#   environment               = var.environment
#   mainvpc_cidr_block        = "10.0.0.0/16"
#   PublicSubnet1_cidr_block  = "10.0.0.0/24"
#   PrivateSubnet1_cidr_block = "10.0.1.0/24"
#   PrivateSubnet2_cidr_block = "10.0.2.0/24"
# }

# module "prod_ec2" {
#   source           = "./modules/ec2"
#   environment      = var.environment
#   mainvpcid        = module.prod_vpc.mainvpcid
#   PublicSubnet1_id = module.prod_vpc.PublicSubnet1id
#   Ec2InstanceCount = var.Ec2InstanceCount
# }

# module "prod_rds" {
#   source            = "./modules/rds"
#   environment       = var.environment
#   mainvpcid         = module.prod_vpc.mainvpcid
#   webserverSGid     = module.prod_ec2.webserverSGid
#   dbusername        = var.dbusername
#   dbpassword        = var.dbpassword
#   dbsubnetgroupname = module.prod_vpc.dbsubnetgroupname
# }

