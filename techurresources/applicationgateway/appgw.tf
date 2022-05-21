 resource "azurerm_public_ip" "apgwpip" {
  name = var.apgwpip.pipname
  resource_group_name = var.resourecgroup1.rganame
  location = var.location
  allocation_method = "Dynamic"
}

