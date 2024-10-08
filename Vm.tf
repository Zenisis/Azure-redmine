resource "azurerm_linux_virtual_machine" "vm" {
  name                = "redmine-vm"
  resource_group_name = data.azurerm_resource_group.Redmine-Sandbox.name
  location            = data.azurerm_resource_group.Redmine-Sandbox.location
  size               = "Standard_DS1_v2"  # Choose your VM size
  admin_username      = "yourusername"
  admin_password      = "yourpassword" # Use secure methods for passwords
  network_interface_ids = [azurerm_network_interface.nic.id]
  admin_ssh_key {
    username   = "yourusername"            # Must match your admin_username
    public_key = tls_private_key.ssh_key.public_key_openssh
  }

  os_disk {
    caching              = "ReadWrite"
    #create_option       = "FromImage"
    storage_account_type   = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-LTS"
    version   = "latest"
  }

  #custom_data = <<-EOF
              #!/bin/bash
              #sudo apt-get update
              #sudo apt-get install -y build-essential libssl-dev libreadline-dev zlib1g-dev
              #sudo apt-get install -y git
              #curl -sSL https://get.rvm.io | bash -s stable
              #source /usr/local/rvm/scripts/rvm
             # rvm install 2.7.0
             # gem install rails -v 6.1.3
             # gem install redmine -v 5.0.0
             # EOF
}



output "public_ip" {
  value = azurerm_public_ip.public_ip.ip_address
}

output "private_key" {
  value     = tls_private_key.ssh_key.private_key_pem
  sensitive = true  # Mark the output as sensitive to prevent it from being displayed in plain text
}
