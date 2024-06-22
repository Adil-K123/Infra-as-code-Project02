variable "environment" {
  type    = string
  default = "dev"
}

variable "dbusername" {
  default   = ""
  sensitive = true
}

variable "dbpassword" {
  default   = ""
  sensitive = true
}

# variable "inventoryfilename" {
#   type = string
#   default = ""
# }