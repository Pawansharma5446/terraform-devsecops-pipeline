terraform {
  required_version = ">= 1.0.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.57.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "0aaac62a-370e-4f7a-9695-47e6ba2c678f"

}

locals {
  resource_group_name = "todoapprg1"
  location            = "West Europe"
  vnet_name           = "todoappvnet"
  subnet1_name        = "frontend_subnet"

}
resource "azurerm_resource_group" "example" {
  name     = local.resource_group_name
  location = local.location
}

resource "azurerm_virtual_network" "vnet" {
  depends_on = [ azurerm_resource_group.example ]
  name                = local.vnet_name
  resource_group_name = local.resource_group_name
  location            = local.location
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "subnet1" {
  depends_on = [ azurerm_virtual_network.vnet ]
  name                 = local.subnet1_name
  resource_group_name  = local.resource_group_name
  virtual_network_name = local.vnet_name
  address_prefixes     = ["10.0.1.0/24"]
}

# resource "azurerm_subnet" "subnet2" {
#   name                 = local.subnet2_name
#   resource_group_name  = local.resource_group_name
#   virtual_network_name = local.vnet_name
#   address_prefixes     = ["10.0.2.0/24"]
#   depends_on           = [azurerm_resource_group.example]
#   address_prefixes     = ["10.0.2.0/24"]    
#   depends_on = [ azurerm_resource_group.example ]

# }
















