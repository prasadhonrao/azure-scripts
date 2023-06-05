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

# Create a virtual network
$vnet = New-AzVirtualNetwork -ResourceGroupName $resourceGroupName -Location $location `
    -Name "YourVNET" `
    -AddressPrefix "10.0.0.0/16"
$subnetConfig = Add-AzVirtualNetworkSubnetConfig -Name "YourSubnet" `
    -AddressPrefix "10.0.0.0/24" `
    -VirtualNetwork $vnet

# Create a public IP address
$publicIP = New-AzPublicIpAddress -ResourceGroupName $resourceGroupName -Location $location `
    -Name "YourPublicIP" `
    -AllocationMethod Dynamic

# Create a network security group
$nsg = New-AzNetworkSecurityGroup -ResourceGroupName $resourceGroupName -Location $location `
    -Name "YourNSG"
$rule = New-AzNetworkSecurityRuleConfig -Name "AllowSSH" `
    -Protocol Tcp `
    -Direction Inbound `
    -Priority 1000 `
    -SourceAddressPrefix "*" `
    -SourcePortRange "*" `
    -DestinationAddressPrefix "*" `
    -DestinationPortRange 22 `
    -Access Allow
$nsg | Add-AzNetworkSecurityRuleConfig -NetworkSecurityRuleConfig $rule
$nsg | Set-AzNetworkSecurityGroup

# Create a network interface
$nic = New-AzNetworkInterface -Name "YourNIC" `
    -ResourceGroupName $resourceGroupName `
    -Location $location `
    -SubnetId $vnet.Subnets[0].Id `
    -PublicIpAddressId $publicIP.Id `
    -NetworkSecurityGroupId $nsg.Id

# Specify the VM configuration
$vmConfig = New-AzVMConfig -VMName $vmName -VMSize "Standard_D2s_v3" `
    | Set-AzVMOperatingSystem -Linux `
        -ComputerName $vmName `
        -Credential (Get-Credential -UserName $adminUsername -Password $adminPassword) `
    | Set-AzVMSourceImage -PublisherName "Canonical" `
        -Offer "UbuntuServer" `
        -Skus "18.04-LTS" `
        -Version "latest" `
    | Add-AzVMNetworkInterface -Id $nic.Id

# Create the virtual machine
New-AzVM -ResourceGroupName $resourceGroupName -Location $location -VM $vmConfig
