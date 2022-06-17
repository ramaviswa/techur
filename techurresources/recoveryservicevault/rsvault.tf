

resource "azurerm_recovery_services_vault" "recoverysv" {
    name = var.recovryservicevult.rsvname
    location = var.locat
    resource_group_name = var.rsvaultrg.name
    sku = "Standard"

    soft_delete_enabled = true

}