# module "staging_vpc" {
#   source                    = "./modules/vpc"
#   environment               = var.environment
#   mainvpc_cidr_block        = "10.1.0.0/16"
#   PublicSubnet1_cidr_block  = "10.1.0.0/24"
#   PrivateSubnet1_cidr_block = "10.1.1.0/24"
#   PrivateSubnet2_cidr_block = "10.1.2.0/24"
# }

# module "staging_ec2" {
#   source           = "./modules/ec2"
#   environment      = var.environment
#   mainvpcid        = module.staging_vpc.mainvpcid
#   PublicSubnet1_id = module.staging_vpc.PublicSubnet1id
#   Ec2InstanceCount = var.Ec2InstanceCount
# }

# module "staging_rds" {
#   source            = "./modules/rds"
#   environment       = var.environment
#   mainvpcid         = module.staging_vpc.mainvpcid
#   webserverSGid     = module.staging_ec2.webserverSGid
#   dbusername        = var.dbusername
#   dbpassword        = var.dbpassword
#   dbsubnetgroupname = module.staging_vpc.dbsubnetgroupname
# }

