# Variables
resourceGroupName="<resource-group-name>"
accountName="<cosmosdb-account-name>"
location="<location>"
keyspaceName="<keyspace-name>"
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
  --kind Cassandra \
  --default-consistency-level "Session"

# Create a keyspace
az cosmosdb cassandra keyspace create \
  --account-name $accountName \
  --name $keyspaceName \
  --resource-group $resourceGroupName

# Create a table
az cosmosdb cassandra table create \
  --account-name $accountName \
  --keyspace-name $keyspaceName \
  --name "<table-name>" \
  --resource-group $resourceGroupName \
  --throughput $throughput
