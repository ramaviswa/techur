resource "azurerm_network_interface" "nic1" {
  name                = var.nic1.nicname
  location            = var.vm1.location
  resource_group_name = var.resourcegroup1.rgname

  ip_configuration {
    name                          = var.nic1.ipconfig.ipname
    subnet_id                     = var.subnetoutput1
    private_ip_address_allocation = "Dynamic"
    ##public_ip_address_id         = azurerm_public_ip.pip1.id
  }
}

resource "azurerm_public_ip" "pip1" {
  name                = var.pip1.ipname
  resource_group_name = var.resourcegroup1.rgname
  location            = var.vm1.location
  allocation_method   = "Static"

}

resource "azurerm_public_ip" "pip3" {
  name = var.pip3.ipname
  resource_group_name = var.resourcegroup1.rgname
  location = var.vm1.location
  allocation_method = "Static"
  sku = "Standard"
}


resource "azurerm_virtual_machine" "vm1" {
  name                  = var.vm1.vmname
  location              = var.vm1.location
  resource_group_name   = var.resourcegroup1.rgname
  network_interface_ids = [azurerm_network_interface.nic1.id]
  vm_size               = var.vm1.vmsize

  storage_image_reference {
    publisher = var.vm1.publisher
    offer     = var.vm1.offer
    sku       = var.vm1.sku
    version = "latest"
  }
  storage_os_disk {
    name              = var.vm1.osdiskname
    caching           = var.vm1.caching
    managed_disk_type = "Standard_LRS"
    create_option     = var.vm1.create_option
  }
  os_profile {
    computer_name  = var.vm1.hostname
    admin_username = var.vm1.username
    admin_password = var.vm1.password
  }
  os_profile_windows_config {
      enable_automatic_upgrades = false  
  }

}

resource "azurerm_network_interface" "nic2" {
    name = var.nic2.nicname
    location = var.vm2.location
    resource_group_name = var.resourcegroup2.rgname

    ip_configuration {
      name = var.nic2.ipconfig.ipname
      subnet_id = var.subnetoutput2
      private_ip_address_allocation = "Dynamic"
      ##public_ip_address_id         = azurerm_public_ip.pip2.id
    }
}

resource "azurerm_public_ip" "pip2" {
  name                = var.pip2.ipname
  resource_group_name = var.resourcegroup2.rgname
  location            = var.vm2.location
  allocation_method   = "Static"

}

resource "azurerm_public_ip" "pip4" {
  name = var.pip4.ipname
  resource_group_name = var.resourcegroup2.rgname
  location = var.vm2.location
  allocation_method = "Static"
  sku = "Standard"
}

resource "azurerm_virtual_machine" "vm2" {
  name                  = var.vm2.vmname
  location              = var.vm2.location
  resource_group_name   = var.resourcegroup2.rgname
  network_interface_ids = [azurerm_network_interface.nic2.id]
  vm_size               = var.vm2.vmsize
  
   storage_image_reference {
    publisher = var.vm2.publisher
    offer     = var.vm2.offer
    sku       = var.vm2.sku
    version = "latest"
  }
  storage_os_disk {
    name              = var.vm2.osdiskname
    caching           = var.vm2.caching
    managed_disk_type = "Standard_LRS"
    create_option     = var.vm2.create_option
  }
  os_profile {
    computer_name  = var.vm2.hostname
    admin_username = var.vm2.username
    admin_password = var.vm2.password
  }
   os_profile_windows_config {
      enable_automatic_upgrades = false  
  }
}

resource "azurerm_bastion_host" "bastion1" {
  name = var.vm1.vm1bastion
  location = var.vm1.location
  resource_group_name = var.resourcegroup1.rgname
  ip_configuration {
    name = var.vm1.ipconfig.ipname
    subnet_id = var.subnetoutput4
    public_ip_address_id = azurerm_public_ip.pip3.id       
  }    
}

resource "azurerm_bastion_host" "bastion2"{
     name = var.vm2.vm2bastion
     location = var.vm2.location
     resource_group_name = var.resourcegroup2.rgname

     ip_configuration {
       name = var.vm2.ipconfig.ipname
       subnet_id = var.subnetoutput5
       public_ip_address_id = azurerm_public_ip.pip4.id
     }
}

output "vm1nic1outputid"{
     value = azurerm_network_interface.nic1.id
}

output "vm1nic1outputipconfigname"{
     value = azurerm_network_interface.nic1.ip_configuration[0].name
}

output "vm2outputprivate_ip_addresses" {
     value = azurerm_network_interface.nic2.ip_configuration[0].private_ip_address
}