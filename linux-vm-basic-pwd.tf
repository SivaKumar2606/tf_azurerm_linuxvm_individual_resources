
# Create virtual machine

resource "azurerm_linux_virtual_machine" "myterraformvm" {
    name                  = "${var.vm_name}"
    location              = azurerm_resource_group.myterraformgroup.location
    resource_group_name   = azurerm_resource_group.myterraformgroup.name
    network_interface_ids = [azurerm_network_interface.myterraformnic.id]
    size                  = "${var.vm_size}"
    admin_username        = "${var.username}"
    admin_password        = "${var.password}"
    disable_password_authentication = false

    os_disk {
        name              = "myOsDisk"
        caching           = "ReadWrite"
        storage_account_type = "Premium_LRS"
    }

    source_image_reference {
        publisher = "${var.publisher}"
        offer     = "${var.offer}"
        sku       = "${var.sku}"
        version   = "latest"
    }

    boot_diagnostics {
        storage_account_uri = azurerm_storage_account.mystorageaccount.primary_blob_endpoint
    }

    tags = {
        environment = "${var.env}"
    }
}