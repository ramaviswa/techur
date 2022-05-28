resource "azurerm_public_ip" "apgwpip" {
  name = var.apgwpip.pipname
  resource_group_name = var.resourcegroup1.rgname
  location = var.location
  allocation_method = "Dynamic"
}

resource "azurerm_application_gateway" "applicationgateway" {
  name = var.appgw.appname
  resource_group_name = var.resourcegroup1.rgname
  location = var.appgw.location
  sku {
    name = var.appgw.sku
    tier  = var.appgw.tier
    capacity = var.appgw.capacity
  }

  gateway_ip_configuration {
    name = var.appgw.ipconfig.gipname
    subnet_id = var.subnetoutput3
  }

  frontend_port {
    name = var.appgw.fport
    port = var.appgw.port
  }

  frontend_ip_configuration {
      name = var.appgw.fipconfig.fipname
      public_ip_address_id = azurerm_public_ip.apgwpip.id
  }

  backend_address_pool { 
    name = var.appgw.bapname
  }
  backend_address_pool { 
    name = "Virtualmachine2docbackendpool"
    ip_addresses = [var.vm2outputprivate_ip_addresses]
  }

  backend_address_pool { 
    name = "Virtualmachine1imagesbackendpool"
  }

backend_http_settings { 
   name = var.appgw.bhttpname
   cookie_based_affinity = "Disabled"
   port = 80
   protocol = "Http"
   request_timeout = 60
}

http_listener {
name = var.appgw.listname
frontend_ip_configuration_name = var.appgw.fipconfig.fipname
frontend_port_name = var.appgw.fport
protocol = "Http"
}

request_routing_rule {
  name = var.appgw.rrrulename
  rule_type = var.appgw.type
  http_listener_name = var.appgw.listname
  backend_address_pool_name = var.appgw.bapname
  backend_http_settings_name = var.appgw.bhttpname
}
}

data "azurerm_subscription" "current" {
}


resource "azurerm_network_interface_backend_address_pool_association" "example" {
  network_interface_id    = var.vm1nic1outputid
  ip_configuration_name   = "vm1nicaccsociation"
  backend_address_pool_id = "/subscriptions/${data.azurerm_subscription.current.subscription_id}/resourceGroups/${var.resourcegroup1.rgname}/providers/Microsoft.Network/applicationGateways/${var.appgw.appname}/backendAddressPools/Virtualmachine1imagesbackendpool"
}
