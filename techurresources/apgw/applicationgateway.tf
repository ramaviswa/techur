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
   
  backend_address_pool {
    name = "webappbackendpool"
    fqdns = [var.webappoutput]
  }

backend_http_settings { 
   name = var.appgw.bhttpname
   cookie_based_affinity = "Disabled"
   port = 80
   protocol = "Http"
   request_timeout = 60
}
backend_http_settings  {
  name = "Virtualmachine2docbackendpool-httpname"
  cookie_based_affinity = "Disabled"
  port = 80
  protocol = "Http"
  request_timeout = 60

}
backend_http_settings {
  name = "Virtualmachine1imagesbackendpool-httpname" 
  cookie_based_affinity = "Disabled"
  port = 80
  protocol = "Http"
  request_timeout = 60

}
backend_http_settings {
  name = "webappbackendpool-httpname"
  cookie_based_affinity = "Disabled"
  port = 443
  protocol = "Https"
  request_timeout = 60
  
  pick_host_name_from_backend_address  = true
}

http_listener {
  name = var.appgw.listname
  frontend_ip_configuration_name = var.appgw.fipconfig.fipname
  frontend_port_name = var.appgw.fport
  protocol = "Http"
}

 
http_listener {
   name = var.appgw.listname2
   frontend_ip_configuration_name = var.appgw.fipconfig.fipname
   frontend_port_name = var.appgw.fport
   host_name = "0eda3588-b2bb-40c3-bd9f-b391522393cc.cloudapp.net"
   protocol = "Http"

 }

request_routing_rule {
  name = var.appgw.rrrulename
  rule_type = var.appgw.type
  http_listener_name = var.appgw.listname
  backend_address_pool_name = var.appgw.bapname
  backend_http_settings_name = var.appgw.bhttpname
}

request_routing_rule {
  name = var.appgw.routrulename
  rule_type = "PathBasedRouting"
  http_listener_name = var.appgw.listname2
  url_path_map_name = var.appgw.urlpathmapname
 }

 url_path_map  {
   name = var.appgw.urlpathmapname
   default_backend_address_pool_name = var.appgw.bapname
   default_backend_http_settings_name =var.appgw.bhttpname
   ##default_redirect_configuration_name = var.appgw.rrrulename

   path_rule =[{
     name = var.appgw.pathrulename1
     paths = ["/images/*"]
     backend_address_pool_name = "Virtualmachine1imagesbackendpool"
     backend_http_settings_name = "Virtualmachine1imagesbackendpool-httpname"     
   },
   {
    name = var.appgw.pathrulename2
     paths = ["/docs/*"]
     backend_address_pool_name = "Virtualmachine2docbackendpool"
     backend_http_settings_name = "Virtualmachine2docbackendpool-httpname" 
   }
   ]
 }

}

data "azurerm_subscription" "current" {
}

resource "azurerm_network_interface_application_gateway_backend_address_pool_association" "vm1nicassoc" {
  network_interface_id    = var.vm1nic1outputid
  ip_configuration_name   = var.vm1nic1outputipconfigname
  backend_address_pool_id = "/subscriptions/${data.azurerm_subscription.current.subscription_id}/resourceGroups/${var.resourcegroup1.rgname}/providers/Microsoft.Network/applicationGateways/${var.appgw.appname}/backendAddressPools/Virtualmachine1imagesbackendpool"
  depends_on = [
    azurerm_application_gateway.applicationgateway
  ]
}
