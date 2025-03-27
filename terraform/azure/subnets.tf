# Create subnet
resource "azurerm_subnet" "my_terraform_subnet" {
  name                 = "DevOpsSubnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.my_terraform_network.name
  address_prefixes     = ["10.0.1.0/24"]
}