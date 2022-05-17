resource "azurerm_network_security_group"  "nsg01" {
  name = var.networksecurtitygroup1.nsgname
  location = var.location
  resource_group_name = var.resourcegroup1.rgname
}
resource "azurerm_network_security_group" "nsg2" {
 name = var.networksecuritygroup2.nsgname
 location = var.location
 resource_group_name = var.resourcegroup2.rgname 
}