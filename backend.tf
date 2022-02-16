terraform {
  backend "azurerm" {
    resource_group_name  = "jckterraformbackend"
    storage_account_name = "jcktfstorageaccount"
    container_name       = "jckterraformcontainer"
    key                  = "Key_tfbasics"
  }
}