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

# Prompt for name of new VM
Get-NewVMName
#Create Variable for IPAddress
$PublicIPAddName = $Script:VMName + "-ip"
# Get credentials for new VM
$Cred = (Get-Credential)
$PublicIPAddName = $Script:VMName + "-ip"
# Create Hashtable from JSON. Request JSON URL from Github that contains VM parameters.
$URI = Read-Host -Prompt "Enter URI"
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
New-AzVM @VMParams