# Create a container group
resource "azurerm_container_group" "redmine_container" {
  name                = "redmine-container"
  location            = data.azurerm_resource_group.Redmine-Sandbox.location
  resource_group_name = data.azurerm_resource_group.Redmine-Sandbox.name
  ip_address_type     = "Public"
  dns_name_label      = "redmine-app"
  os_type             = "Linux"

  container {
    name   = "redmine"
    image  = "redmine:4.2"
    cpu    = "1"
    memory = "1.5"

    ports {
      port     = 3000
      protocol = "TCP"
    }

     environment_variables = {
      REDMINE_DB_SQLSERVER      = azurerm_sql_server.example.fully_qualified_domain_name  # SQL Server FQDN
      REDMINE_DB_DATABASE        = azurerm_sql_database.example.name                             # Database name
      REDMINE_DB_USERNAME        = azurerm_sql_server.example.administrator_login              # SQL admin username
      REDMINE_DB_PASSWORD        = azurerm_sql_server.example.administrator_login_password     # SQL admin password
    }
  }
}

