resource "azurerm_app_service_plan" "appplan1" {
  name = var.appserviceplan1.planname
  resource_group_name = var.resourcegroup1.rgname
  location = var.location
  
  sku {
    tier = "Standard"
    size = "S1"
}
}

  resource "azurerm_app_service" "webapp" {
    name = var.appservice.servicename
    resource_group_name = var.resourcegroup1.rgname
    location =  var.location
    app_service_plan_id = azurerm_app_service_plan.appplan1.id
  }

  output "WebappHostname" {
    value = azurerm_app_service.webapp.default_site_hostname
  }
