resource "azurerm_resource_group" "recoveryrg" {
    name = var.rsvault.name
    location = var.location

    output "rsvrgoutput"  {
            value = azurerm_resource_group.recoveryrg
    }
  
}

resource "azurerm_recovery_services_vault" "recoverysv" {
    name = var.recovryservicevult.rsvname
    location = var.location
    resource_group_name = var.rsvault.name
    sku = "standard"

    soft_delete_enable = "true"

}