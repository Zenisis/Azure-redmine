terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.65"
    }
  }
}
# Create a resource group
data "azurerm_resource_group" "Redmine-Sandbox" {
  name     = "Redmine-Sandbox"
  #location = "East US"
}
