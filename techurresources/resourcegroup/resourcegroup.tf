resource "azurerm_resource_group" "rg1" {
  name = var.resourcegroup1.rgname
  location = var.location
  
}

resource "azurerm_resource_group" "rg2" {
  name = var.resourcegroup2.rgname
  location = var.location 
}

output "rg1out"{
  value = azurerm_resource_group.rg1
}

output "rg2out" {
  value = azurerm_resource_group.rg2
}