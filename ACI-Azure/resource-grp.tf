# Create a resource group
data "azurerm_resource_group" "Redmine-Sandbox" {
  name     = "Redmine-Sandbox"
  #location = "East US"
}
