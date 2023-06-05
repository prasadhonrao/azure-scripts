# Set variables
variable "resource_group_name" {
  default = "YourResourceGroupName"
}

variable "registry_name" {
  default = "YourRegistryName"
}

variable "location" {
  default = "YourLocation"
}

# Create resource group
resource "azurerm_resource_group" "example" {
  name     = var.resource_group_name
  location = var.location
}

# Create container registry
resource "azurerm_container_registry" "example" {
  name                = var.registry_name
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  sku                 = "Standard"
  admin_enabled       = true
}
  