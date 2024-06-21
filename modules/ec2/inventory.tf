resource "local_file" "inventory" {
    content = templatefile("${path.module}/templates/inventory.tpl",
     {
        webServers = aws_instance.Webserver.*.public_ip
     }
    )
    filename = "${var.inventoryfilename}"
}