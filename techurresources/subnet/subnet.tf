resource "azurerm_subnet" "subnet1"{
    name = var.subnet01.subname
    resource_group_name   = var.resourcegroup1.rgname
    virtual_network_name = var.vnet1.vnetname
    address_prefixes      = var.subnetaddress1
    depends_on = [
      var.vnet1output
    ]
}

resource "azurerm_subnet" "subnet2" {
    name = var.subnet02.subname
    resource_group_name   = var.resourcegroup2.rgname
    virtual_network_name = var.vnet2.vnetname
  address_prefixes        = var.subnetaddress2 

  depends_on = [
    var.vnet2output
  ]
}

resource "azurerm_subnet" "subnet3" {
  name = var.subnet03.subname
  resource_group_name = var.resourcegroup1.rgname
  virtual_network_name = var.vnet1.vnetname
  address_prefixes =  var.subnetaddress3
}

resource "azurerm_subnet" "subnet4" {
  name = var.subnet04.subname
  resource_group_name = var.resourcegroup1.rgname
   virtual_network_name = var.vnet1.vnetname
   address_prefixes = var.subnetaddress4
}

resource "azurerm_subnet" "subnet5" {
  name = var.subnet05.subname
  resource_group_name = var.resourcegroup2.rgname
  virtual_network_name = var.vnet2.vnetname
  address_prefixes = var.subnetaddress5
}



output "subnet1id" {
  value = azurerm_subnet.subnet1.id
  
}
output "subnet2id" {
  value = azurerm_subnet.subnet2.id
  
}
output "subnet3id" {
  value = azurerm_subnet.subnet3.id
}


