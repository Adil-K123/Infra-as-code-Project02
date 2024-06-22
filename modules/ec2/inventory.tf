resource "local_file" "inventory" {
    content = templatefile("${path.module}/templates/inventory.tpl",
     {
        webServers = "${var.webServers_PublicIP}"
     }
    )
    filename = "${var.inventoryfilename}"
}