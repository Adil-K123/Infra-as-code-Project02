# module "shared_ecr" {
#   source = "./modules/ecr"
# }

# module "iam_roles" {
#   source = "./modules/iam"
# }

# module "shared_vpc" {
#     source = "./modules/vpc"
#     environment = "${var.environment}"
#     mainvpc_cidr_block = "10.3.0.0/16"
#     PublicSubnet1_cidr_block = "10.3.0.0/24"
#     PrivateSubnet1_cidr_block = "10.3.1.0/24"
#     PrivateSubnet2_cidr_block = "10.3.2.0/24"
# }