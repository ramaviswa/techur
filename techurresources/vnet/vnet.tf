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

resource "azurerm_virtual_network_peering" "vnet1tovnet2" {
  name                      = "peervnet1tovnet2"
  resource_group_name       = var.resourcegroup1.rgname
  virtual_network_name      = var.vnet1.vnetname
  remote_virtual_network_id = azurerm_virtual_network.vnett.id
}

resource "azurerm_virtual_network_peering" "vnet2tovnet1" {
  name                      = "peervnet2tovnet1"
  resource_group_name       =  var.resourcegroup2.rgname
  virtual_network_name      =  var.vnet2.vnetname
  remote_virtual_network_id = azurerm_virtual_network.vnet.id
}


output "vnet1out" {
 value=  azurerm_virtual_network.vnet
}

output "vnet2out" {
 value=  azurerm_virtual_network.vnett
}