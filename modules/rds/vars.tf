variable "environment" {
  type    = string
  default = ""
}

variable "mainvpcid" {
  type    = string
  default = ""
}

variable "webserverSGid" {
  type    = string
  default = ""
}

variable "allocated_storage" {
  type    = number
  default = 20
}

variable "dbusername" {
  type    = string
  default = ""
}

variable "dbpassword" {
  type      = string
  sensitive = true
  default   = ""
}

variable "dbsubnetgroupname" {
  type    = string
  default = ""
}