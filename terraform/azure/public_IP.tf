# Create public IPs
resource "azurerm_public_ip" "my_terraform_public_ip" {
  name                = "DevOpsPublicIP"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Dynamic"
}