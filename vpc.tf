resource "azurerm_virtual_network" "vnet" {
  name                = "redmine-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = data.azurerm_resource_group.Redmine-Sandbox.location
  resource_group_name = data.azurerm_resource_group.Redmine-Sandbox.name
}

resource "azurerm_subnet" "subnet" {
  name                  = "redmine-subnet"
  resource_group_name   = data.azurerm_resource_group.Redmine-Sandbox.name
  virtual_network_name  = azurerm_virtual_network.vnet.name
  address_prefixes      = ["10.0.1.0/24"]
}

resource "azurerm_public_ip" "public_ip" {
  name                = "redmine-public-ip"
  location            = data.azurerm_resource_group.Redmine-Sandbox.location
  resource_group_name = data.azurerm_resource_group.Redmine-Sandbox.name
  allocation_method   = "Dynamic"
}

resource "azurerm_network_interface" "nic" {
  name                = "redmine-nic"
  location            = data.azurerm_resource_group.Redmine-Sandbox.location
  resource_group_name = data.azurerm_resource_group.Redmine-Sandbox.name

  ip_configuration {
    name                          = "internal"
    subnet_id                    = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id         = azurerm_public_ip.public_ip.id
  }
}
