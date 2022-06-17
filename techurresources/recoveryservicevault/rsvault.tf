

resource "azurerm_recovery_services_vault" "recoverysv" {
    name = var.recovryservicevult.rsvname
    location = var.locat
    resource_group_name = var.rsvaultrg.name
    sku = "Standard"

    soft_delete_enabled = true

}

resource "azurerm_backup_policy_vm" "backupvm" {
    name = var.backupvm.name
    resource_group_name = azurerm_recovery_services_vault.recoverysv.resource_group_name
    recovery_vault_name = azurerm_recovery_services_vault.recoverysv.name

    timezone = "UTC"

    backup {
      frequency = "Daily"
      time = "23:00"
    }

     retention_daily {
         count = 8
     }

     retention_weekly {
    count    =  12
    weekdays = ["Sunday", "Wednesday", "Saturday"]

     }



  
}