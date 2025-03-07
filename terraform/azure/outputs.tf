output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

# k3s

output "k3s_public_ip" {
  value = azurerm_linux_virtual_machine.k3s.public_ip_address
}

# API

output "API_public_ip" {
  value = azurerm_linux_virtual_machine.API.public_ip_address
}
