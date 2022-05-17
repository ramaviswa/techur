##Backenddetails
terraform {
  backend "azurerm" {}
}

## The below lines from 2 to 9 are providers details of terraform
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.4.0"
    }
  }
}

##The below lines for features details for azurerm

provider "azurerm" {
  features {
    
  }
}

##This below lines to exexute module for creating resource group
module "techurrg" {
  source ="./techurresources/resourcegroup"
  resourcegroup1 = var.techurresourcegroup1
  resourcegroup2 = var.techurresourcegroup2
  location       = var.loc
}

module "techurvnet" {
  source ="./techurresources/vnet"
  vnet1 = var.techvnet1
  vnet2 = var.techvnet2
  address = var.vnetaddress1
  
  addressy = var.vnetaddress3
 
  location = var.loca
  resourcegroup1 = var.techurresourcegroup1
  resourcegroup2 = var.techurresourcegroup2

  rg1output = module.techurrg.rg1out
  rg2output = module.techurrg.rg2out
}
 module "techursubnet" {
   source ="./techurresources/subnet"
   vnet1 = var.techvnet1
   vnet2 = var.techvnet2
   resourcegroup1 = var.techurresourcegroup1
   resourcegroup2 = var.techurresourcegroup2
   subnet01 = var.techsubnet1
   subnet02 = var.techsubnet2
   subnetaddress1 = var.techaddress
   subnetaddress2 = var.techaddresss
   vnet1output = module.techurvnet.vnet1out
   vnet2output = module.techurvnet.vnet2out
 }

module "techurvms" {
    source ="./techurresources/virtualmechines"
    resourcegroup1 = var.techurresourcegroup1
    nic1 = var.techurnic1
    subnetoutput1 = module.techursubnet.subnet1id
    pip1 = var.techurpip1
    vm1 = var.techurvm1
    subnetoutput2 = module.techursubnet.subnet2id
    resourcegroup2 = var.techurresourcegroup2
    nic2 = var.techurnic2
    pip2 = var.techurpip2
    vm2 = var.techurvm2
  }
  
  module "techurnsg" {
    source = "./techurresources/nsg"
    networksecurtitygroup1 = var.nsgtech
    resourcegroup1 = var.techurresourcegroup1
    location = var.loca
  }
