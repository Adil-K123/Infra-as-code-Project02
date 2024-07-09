mainvpc_cidr_block = "10.2.0.0/16"

PublicSubnet1 = {
    cidr_block = "10.2.0.0/24"
    AZ         = "us-east-1a"
}

PrivateSubnet1 = {
    cidr_block = "10.2.1.0/24"
    AZ         = "us-east-1a"
}

PrivateSubnet2 = {
    cidr_block = "10.2.2.0/24"
    AZ         = "us-east-1b"
}

Ec2InstanceCount = 2


