output "webserverSGid" {
  value = aws_security_group.Project02WebServer_SG.id
}

# output "webServers_PublicIP" {
#   value = [for instance in aws_instance.Webserver : instance.public_ip]
# }