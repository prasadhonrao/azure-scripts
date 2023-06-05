#!/bin/bash

# Set variables
resourceGroupName="YourResourceGroupName"
registryName="YourRegistryName"
location="YourLocation"
adminUserEnabled=true

# Create resource group
az group create \
  --name $resourceGroupName \
  --location $location

# Create container registry
az acr create \
  --name $registryName \
  --resource-group $resourceGroupName \
  --location $location \
  --admin-enabled $adminUserEnabled
