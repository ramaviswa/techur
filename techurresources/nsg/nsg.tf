resource "azurerm_network_security_group"  "nsg01" {
  name = var.networksecurtitygroup1.nsgname
  location = var.location
  resource_group_name = var.resourcegroup1.rgname
}
  