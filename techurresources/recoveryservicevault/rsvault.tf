resource "azurerm_resource_group" "recoveryrg" {
    name = var.rsvault.name
    location = var.location

    
  
}

resource "azurerm_recovery_services_vault" "recoverysv" {
    name = var.recovryservicevult.rsvname
    location = var.location
    resource_group_name = var.rsvault.name
    sku = "standard"

    soft_delete_enabled = true

}