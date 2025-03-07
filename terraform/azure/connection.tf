# connection k3s

resource "azurerm_virtual_network" "k3s_VNet" {
  name                = "k3s_VNet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "my_k3s_subnet" {
  name                 = "my_k3s_subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.k3s_VNet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_public_ip" "my_k3s_public_ip" {
  name                = "my_k3s_public_ip"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Dynamic"
}

# connection API

resource "azurerm_virtual_network" "API_VNet" {
  name                = "API_VNet"
  address_space       = ["7.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "my_API_subnet" {
  name                 = "my_API_subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.API_VNet.name
  address_prefixes     = ["7.0.1.0/24"]
}

resource "azurerm_public_ip" "my_API_public_ip" {
  name                = "my_API_public_ip"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Dynamic"
}
