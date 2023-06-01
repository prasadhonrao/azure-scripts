# doc link - https://docs.microsoft.com/en-us/azure/app-service/samples-powershell

# Create variables
$webappname = "mywebapp$(Get-Random)"
$aspname = "aspmywebapp"
$rgname = 'webapps3-dev-rg'
$location = 'westus2'

# Create a resource group
New-AzResourceGroup -Name $rgname -Location $location

# Create an App Service plan in S1 tier
New-AzAppServicePlan -Name $aspname -Location $location -ResourceGroupName $rgname -Tier S1

# Create a web app
New-AzWebApp -Name $webappname -Location $location -AppServicePlan $webappname -ResourceGroupName $rgname