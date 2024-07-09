# module "dev_vpc" {
#   source             = "./modules/vpc"
#   environment        = var.environment
#   mainvpc_cidr_block = var.mainvpc_cidr_block
#   PublicSubnet1      = var.PublicSubnet1
#   PrivateSubnet1     = var.PrivateSubnet1
#   PrivateSubnet2     = var.PrivateSubnet2
# }

# module "dev_ec2" {
#   source           = "./modules/ec2"
#   environment      = var.environment
#   Ec2InstanceCount = var.Ec2InstanceCount
#   mainvpcid        = module.dev_vpc.mainvpcid
#   PublicSubnet1_id = module.dev_vpc.PublicSubnet1id
# }

# module "dev_rds" {
#   source            = "./modules/rds"
#   environment       = var.environment
#   mainvpcid         = module.dev_vpc.mainvpcid
#   webserverSGid     = module.dev_ec2.webserverSGid
#   dbusername        = var.dbusername
#   dbpassword        = var.dbpassword
#   dbsubnetgroupname = module.dev_vpc.dbsubnetgroupname
# }


