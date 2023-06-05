param resourceGroupName string = 'YourResourceGroupName'
param registryName string = 'YourRegistryName'
param location string = 'YourLocation'

resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: resourceGroupName
  location: location
}

resource acr 'Microsoft.ContainerRegistry/registries@2021-06-01-preview' = {
  name: registryName
  location: rg.location
  properties: {
    sku: {
      name: 'Standard'
    }
    adminUserEnabled: true
  }
}

// az deployment group create --resource-group YourResourceGroupName --template-file create-acr.bicep
