#!/bin/bash

# Login to Azure
az login

# Set variables
resourceGroupName="YourResourceGroupName"
location="YourLocation"
vmName="YourVMName"
adminUsername="YourAdminUsername"
adminPassword="YourAdminPassword"

# Create resource group
az group create --name $resourceGroupName --location $location

# Create virtual machine
az vm create \
    --resource-group $resourceGroupName \
    --name $vmName \
    --image UbuntuLTS \
    --admin-username $adminUsername \
    --admin-password $adminPassword \
    --location $location \
    --size Standard_D2s_v3

# Open port 22 for SSH
az vm open-port --port 22 --resource-group $resourceGroupName --name $vmName

# Get the public IP address of the virtual machine
ipAddress=$(az vm show -d --resource-group $resourceGroupName --name $vmName --query publicIps -o tsv)

# Display the IP address
echo "The IP address of the virtual machine is: $ipAddress"

#Log into the Linux VM over SSH
ssh $adminUsername@$ipAddress