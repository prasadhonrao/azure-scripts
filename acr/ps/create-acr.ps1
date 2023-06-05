# Set variables
$resourceGroupName = "YourResourceGroupName"
$registryName = "YourRegistryName"
$location = "YourLocation"
$adminUserEnabled = $true

# Create resource group
New-AzResourceGroup `
  -Name $resourceGroupName `
  -Location $location

# Create container registry
New-AzContainerRegistry `
  -Name $registryName `
  -ResourceGroupName $resourceGroupName `
  -Location $location `
  -AdminUserEnabled $adminUserEnabled
