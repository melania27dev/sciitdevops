# k3s security setup
resource "azurerm_network_security_group" "k3s_nsg" {
  name                = "myk3sNSG"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_interface" "k3s_nic" {
  name                    = "k3s_nic"
  location                = azurerm_resource_group.rg.location
  resource_group_name     = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "k3s_nic_configuration"
    subnet_id                     = azurerm_subnet.my_k3s_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.my_k3s_public_ip.id
  }
}

resource "azurerm_network_interface_security_group_association" "nsg_assoc_k3s" {
  network_interface_id      = azurerm_network_interface.k3s_nic.id
  network_security_group_id = azurerm_network_security_group.k3s_nsg.id
}

# API security setup
resource "azurerm_network_security_group" "API_nsg" {
  name                = "myAPINSG"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_interface" "API_nic" {
  name                    = "API_nic"
  location                = azurerm_resource_group.rg.location
  resource_group_name     = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "API_nic_configuration"
    subnet_id                     = azurerm_subnet.my_API_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.my_API_public_ip.id
  }
}

resource "azurerm_network_interface_security_group_association" "nsg_assoc_API" {
  network_interface_id      = azurerm_network_interface.API_nic.id
  network_security_group_id = azurerm_network_security_group.API_nsg.id
}


# Generate random text for a unique storage account name
resource "random_id" "random_id" {
  keepers = {
    # Generate a new ID only when a new resource group is defined
    resource_group = azurerm_resource_group.rg.name
  }

  byte_length = 8
}

# Create storage account for boot diagnostics
resource "azurerm_storage_account" "my_storage_account" {
  name                     = "diag${random_id.random_id.hex}"
  location                 = azurerm_resource_group.rg.location
  resource_group_name      = azurerm_resource_group.rg.name
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
