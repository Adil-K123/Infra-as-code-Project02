variable "environment" {
  type = string
  default = "dev"
}

variable "dbusername" {
  type = string
  default = ""
  sensitive = true
}

variable "dbpassword" {
  type = string
  default = ""
  sensitive = true
}