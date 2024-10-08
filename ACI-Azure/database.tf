resource "azurerm_sql_server" "example" {
  name                         = "redmine-sql-server"
  resource_group_name          = data.azurerm_resource_group.Redmine-Sandbox.name
  location                     = "East Us"
  version                      = "12.0"
  administrator_login          = "sqladmin"
  administrator_login_password  = "Y0urS3cureP@ssw0rd!"
  #ssl_enforcement_enabled      = true
}

resource "azurerm_sql_database" "example" {
  name                = "redmine-db"
  resource_group_name = data.azurerm_resource_group.Redmine-Sandbox.name
  location            = "East Us"
  server_name         = azurerm_sql_server.example.name
  requested_service_objective_name = "S0"  # Service tier for performance
}

