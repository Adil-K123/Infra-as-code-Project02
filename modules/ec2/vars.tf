variable "environment" {
  type    = string
  default = ""
}

variable "mainvpcid" {
  type    = string
  default = ""
}

variable "PublicSubnet1_id" {
  type    = string
  default = ""
}

variable "Ec2InstanceCount" {
  type    = number
  default = 1
}

variable "inventoryfilename" {
  type = string
  default = ""
}

variable "webServers_PublicIP" {
  default = ""
}
