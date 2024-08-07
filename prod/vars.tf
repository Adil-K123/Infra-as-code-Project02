variable "environment" {
  type    = string
  default = "prod"
}

variable "mainvpc_cidr_block" {
  type    = string
  default = ""
}

variable "PublicSubnet1" {
  type = map(string)
  default = {
    cidr_block = ""
    AZ         = ""
  }
}

variable "PrivateSubnet1" {
  type = map(string)
  default = {
    cidr_block = ""
    AZ         = ""
  }
}

variable "PrivateSubnet2" {
  type = map(string)
  default = {
    cidr_block = ""
    AZ         = ""
  }
}

variable "Ec2InstanceCount" {
  type    = number
  default = 0
}

variable "dbusername" {
  default   = ""
  sensitive = true
}

variable "dbpassword" {
  default   = ""
  sensitive = true
}