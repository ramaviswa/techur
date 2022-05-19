resource "azurerm_app_service_plan" "appplan1" {
  name = var.appserviceplan1.planname
  resource_group_name = var.resourcegroup1.rgname
  location = var.location
  
  sku {
    tier = "Standard"
    size = "S1"
}
}