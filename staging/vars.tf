variable "environment" {
  type    = string
  default = "staging"
}

variable "Ec2InstanceCount" {
  type    = number
  default = 2
}

variable "dbusername" {
  default   = ""
  sensitive = true
}

variable "dbpassword" {
  default   = ""
  sensitive = true
}