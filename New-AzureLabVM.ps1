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

#function Create-NewAZVM {

   #New-AZVM -ResourceGroupName $ResourceGroup `
    #-Name $Script:VMName `
    #-Location $Location `
    #-VirtualNetworkName $VirtualNetworkName `
    #-SubnetName $SubnetName `
    #-PublicIpAddressName $PublicIPAddName `
    #-Image 'Win2019Datacenter' `
    #-NetworkInterfaceDeleteOption 'Delete' `
    #-Size $VMSKU `
    #-Credential $Cred
    
#}
# Prompt for name of new VM
Get-NewVMName
#Create Variable for IPAddress
$PublicIPAddName = $Script:VMName + "-ip"
# Get credentials for new VM
$Cred = (Get-Credential)
$PublicIPAddName = $Script:VMName + "-ip"
# Create Hashtable from JSON
$URI = 'https://raw.githubusercontent.com/tiling-catwalk-liking/Hexagon1527/JSON-Function/VMParams.json?token=GHSAT0AAAAAACCUISV4C5QNQO4H4XNS4LGUZDCPDHQ'
$VMParams = Invoke-WebRequest -Uri $URI
$VMParams = ($VMParams).content
$VMParams = $VMParams | ConvertFrom-Json -AsHashtable
$VMParams.Add("PublicIPAddressName", $PublicIPAddName)
$VMParams.Add("Name", "$Script:VMName")
$VMParams.Add("Credential", $Cred)
$VMParams


# These lines are currently to assist in debugging.
Write-Host "Selected VM Name is: $Script:VMName"
Write-Host "Gonna make $Script:VMName. Please be patient."

# Create VM
#Create-NewAZVM @VMParams