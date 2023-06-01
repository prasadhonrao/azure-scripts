# Login interactively and set a subscription to be the current active subscription
az login
az account set --subscription "Demonstration Account"

# List all resource groups
az group list --output table 

# Create a resource group if needed.
az group create --name "training-rg" --location "uksouth"

# Create a SQL API Cosmos DB account
az cosmosdb create --name "azure-training-cosmosdb" --resource-group "training-rg"

# Create a database
az cosmosdb sql database create --account-name "azure-training-cosmosdb" --resource-group "training-rg" --name "training-db"

# Create a container
az cosmosdb sql container create --account-name "azure-training-cosmosdb" --resource-group "training-rg" --database-name "training-db" --name "training-container" --partition-key-path "/id"

# Create an item
az cosmosdb sql item create --account-name "azure-training-cosmosdb" --resource-group "training-rg" --database-name "training-db" --container-name "training-container" --item @item.json

# List containers
az cosmosdb sql container list --account-name "azure-training-cosmosdb" --resource-group "training-rg" --database-name "training-db" --output table

# List items
// TODO