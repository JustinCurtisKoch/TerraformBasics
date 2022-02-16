terraform {
  backend "azurerm" {
    resource_group_name  = "jckterraformbackend"
    storage_account_name = "jcksaterraformbasics"
    container_name       = "jckcontterraformbasics"
    key                  = "jck_key_tfbasics"
  }
}