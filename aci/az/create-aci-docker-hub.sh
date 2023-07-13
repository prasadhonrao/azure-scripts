# Set variables
resourceGroup="aci-rg"
containerName="aci-tic-tac-toe"
imageName="prasadhonrao/tic-tac-toe"
portNumber=80

# Create a resource group (if it doesn't exist)
az group create --name $resourceGroup --location uksouth

# Create the container instance
az container create \
    --resource-group $resourceGroup \
    --name $containerName \
    --image $imageName \
    --ports $portNumber \
    --ip-address Public \
    --environment-variables "PORT=$portNumber"

# Get the container instance details
az container show \
    --resource-group $resourceGroup \
    --name $containerName \
    --output table
