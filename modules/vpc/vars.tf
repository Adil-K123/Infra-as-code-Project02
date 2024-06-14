variable "environment" {
  type = string
  default = ""
}

variable "mainvpc_cidr_block" {
  type = string
  default = ""
}
 
variable "PublicSubnet1_cidr_block" {
  type = string
  default = ""
}

variable "PublicSubnet1_AZ" {
  type = string
  default = "us-east-1a"
}

variable "PrivateSubnet1_cidr_block" {
  type = string
  default = ""
}

variable "PrivateSubnet2_cidr_block" {
  type = string
  default = ""
}

variable "PrivateSubnet1_AZ" {
  type = string
  default = "us-east-1a"
}

variable "PrivateSubnet2_AZ" {
  type = string
  default = "us-east-1b"
}

