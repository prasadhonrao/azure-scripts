# Login interactively and set a subscription to be the current active subscription
az login
az account set --subscription "Demonstration Account"

# List all resource groups
az group list --output table 

# Create a resource group if needed.
az group create \
    --name "psdemo-rg" \
    --location "centralus"

# Create a Linux Azure App Service plan
az appservice plan create --name webapps-dev-plan \
  --resource-group webapps-dev-rg \
  --sku s1 \
  --is-linux


# Create a web app  
az webapp create -g webapps-dev-rg \
  -p webapps-dev-plan \
  -n mp10344884 \
  --runtime "node|10.14"