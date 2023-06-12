# Variables
resourceGroupName="<resource-group-name>"
accountName="<cosmosdb-account-name>"
location="<location>"
databaseName="<database-name>"
containerName="<container-name>"
partitionKeyPath="/partitionKey"

# Create a resource group
az group create \
  --name $resourceGroupName \
  --location $location

# Create a Cosmos DB account
az cosmosdb create \
  --name $accountName \
  --resource-group $resourceGroupName \
  --locations "$location=0" \
  --kind GlobalDocumentDB \
  --default-consistency-level "Session" \
  --enable-multiple-write-locations true

# Create a database
az cosmosdb sql database create \
  --account-name $accountName \
  --name $databaseName \
  --resource-group $resourceGroupName

# Create a container
az cosmosdb sql container create \
  --account-name $accountName \
  --database-name $databaseName \
  --name $containerName \
  --partition-key-path $partitionKeyPath \
  --throughput 400
