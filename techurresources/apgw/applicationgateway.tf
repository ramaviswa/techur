resource "azurerm_public_ip" "apgwpip" {
  name = var.apgwpip.pipname
  resource_group_name = var.resourcegroup1.rgname
  location = var.location
  allocation_method = "Dynamic"
}