output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

# output "public_ip_address" {
#   value = azurerm_linux_virtual_machine.vm_azure.public_ip_address
# }

# output "admin_password" {
#   sensitive = true
#   value     = azurerm_windows_virtual_machine.main.admin_password
# }

# output "resource_group_name" {
#   value = azurerm_resource_group.rg.name
# }

output "public_ip_address" {
  value = azurerm_linux_virtual_machine.my_terraform_vm.public_ip_address
}

output "web_server_ip" {
  value = azurerm_public_ip.my_terraform_public_ip_2.ip_address
}