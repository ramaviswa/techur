resource "azurerm_resource_group" "rg1" {
  name = var.resourcegroup1.rgname
  location = var.location
  
}

resource "azurerm_resource_group" "rg2" {
  name = var.resourcegroup2.rgname
  location = var.location 
}


