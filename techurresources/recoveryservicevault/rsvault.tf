
/*resource "azurerm_resource_group" "recoveryrg" {
    name = var.rsvault.name
    location = var.location

    
  
}*/
/*
resource "azurerm_recovery_services_vault" "recoverysv" {
    name = var.recovryservicevult.rsvname
    location = resource_group.recoveryrg.location
    resource_group_name = resource_group.recoveryrg.name
    sku = "Standard"

    soft_delete_enabled = true

}*/