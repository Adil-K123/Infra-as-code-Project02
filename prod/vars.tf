variable "environment" {
  type    = string
  default = "staging"
}

variable "Ec2InstanceCount" {
  type    = number
  default = 3
}

variable "dbusername" {
  default   = ""
  sensitive = true
}

variable "dbpassword" {
  default   = ""
  sensitive = true
}