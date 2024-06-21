resource "local_file" "inventory" {
    content = templatefile("${path.module}/templates/inventory.tpl",
     {
        webServers = aws_instance.Webserver.*.associate_public_ip_address
     }
    )
    filename = "${var.inventoryfilename}"
}