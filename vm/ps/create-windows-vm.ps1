# Connect to Azure
Connect-AzAccount

# Set variables
$resourceGroupName = "YourResourceGroupName"
$location = "YourLocation"
$vmName = "YourVMName"
$adminUsername = "YourAdminUsername"
$adminPassword = "YourAdminPassword"

# Create a resource group
New-AzResourceGroup -Name $resourceGroupName -Location $location

# Specify the VM configuration
$vmConfig = New-AzVMConfig -VMName $vmName -VMSize "Standard_D2s_v3" `
    | Set-AzVMOperatingSystem -Windows `
        -ComputerName $vmName `
        -Credential (Get-Credential -UserName $adminUsername -Password $adminPassword) `
    | Set-AzVMSourceImage -PublisherName "MicrosoftWindowsServer" `
        -Offer "WindowsServer" `
        -Skus "2019-Datacenter" `
        -Version "latest" `
    | Add-AzVMNetworkInterface -Id $nic.Id `
    | Set-AzVMOSDisk -CreateOption "FromImage" `
        -DiskSizeGB 127 `
        -StorageAccountType "Standard_LRS" `
        -Caching "ReadWrite"

# Create the virtual machine
New-AzVM -ResourceGroupName $resourceGroupName -Location $location -VM $vmConfig

# Get the public IP address of the virtual machine
$publicIP = Get-AzPublicIpAddress -ResourceGroupName $resourceGroupName -Name "$vmName-ip"
$ipAddress = $publicIP.IpAddress

# Display the IP address
Write-Host "The IP address of the virtual machine is: $ipAddress"
