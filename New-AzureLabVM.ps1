<#
.SYNOPSIS
    Requests new VM name and creates VM with standardized specs.
.DESCRIPTION
    New-AzureLabVM is used to create VMs for an Azure lab. It uses certain hard coded New-AzVM parameters while requesting a VM name and username/password for the new VM.
.PARAMETER  

.EXAMPLE

.INPUTS

.OUTPUTS

.NOTES

.LINK

#>

function Get-NewVMName {
    $Script:VMName = Read-Host -Prompt "Enter Name of New VM"
}

Get-NewVMName

# Get credentials for new VM
$Cred = (Get-Credential)
# Variables for new VM creation
$PublicIPAddName = $Script:VMName + "-ip"
$ResourceGroup = 'ResourceGroup1_TrialSub1'
$Location = 'EastUs2'
$VirtualNetworkName = 'vnet1'
$SubnetName = 'subnet1'
$SecurityGroupName = 'NSG2'
$VMSKU = 'Standard_B2s'
$VMImage = 'Win2019Datacenter'

Write-Host "Selected VM Name is: $Script:VMName"

Write-Host "Gonna make $Script:VMName. Please be patient"

# Create VM
function Create-NewAZVM {

    New-AZVM -ResourceGroupName $ResourceGroup `
    -Name $Script:VMName `
    -Location $Location `
    -VirtualNetworkName $VirtualNetworkName `
    -SubnetName $SubnetName `
    -PublicIpAddressName $PublicIPAddName `
    -Image 'Win2019Datacenter' `
    -NetworkInterfaceDeleteOption 'Delete' `
    -Size $VMSKU `
    -Credential $Cred
    
}



Create-NewAZVM
