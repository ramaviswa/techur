resource "app_service_plan" "appplan1" {
  name = var.appserviceplan1.planname
  resource_group_name = var.resourcegroup1.rgname
  location = var.location
  sku_name = "F1"
}
