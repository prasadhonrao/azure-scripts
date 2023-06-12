# Variables
resourceGroupName="<resource-group-name>"
accountName="<cosmosdb-account-name>"
location="<location>"
databaseName="<database-name>"
collectionName="<collection-name>"
throughput="<throughput>"

# Create a resource group
az group create \
  --name $resourceGroupName \
  --location $location

# Create a Cosmos DB account
az cosmosdb create \
  --name $accountName \
  --resource-group $resourceGroupName \
  --locations "$location=0" \
  --kind MongoDB \
  --default-consistency-level "Session"

# Create a database
az cosmosdb mongodb database create \
  --account-name $accountName \
  --name $databaseName \
  --resource-group $resourceGroupName

# Create a collection
az cosmosdb mongodb collection create \
  --account-name $accountName \
  --database-name $databaseName \
  --name $collectionName \
  --resource-group $resourceGroupName \
  --throughput $throughput
