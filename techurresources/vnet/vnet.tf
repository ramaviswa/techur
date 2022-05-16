resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet1.vnetname
  location            = var.location
  resource_group_name = var.resourcegroup1.rgname
  address_space       = var.address
  depends_on = [
    var.rg1output
  ]
  
    }
    
    resource "azurerm_virtual_network" "vnett" {
      name = var.vnet2.vnetname
        location            = var.location
      resource_group_name = var.resourcegroup2.rgname
      address_space = var.addressy
      depends_on = [
        var.rg2output
      ]
    }

output "vnet1out" {
 value=  azurerm_virtual_network.vnet
}

output "vnet2out" {
 value=  azurerm_virtual_network.vnett
}