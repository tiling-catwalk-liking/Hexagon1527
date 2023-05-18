<#
.SYNOPSIS
   Creates VM with standardized specs. Requests new VM name, credentials, and URI for JSON containing parameters.
.DESCRIPTION
    New-AzureLabVM is used to create VMs for an Azure lab. It uses a JSON file to define the parameters while requesting a VM name and username/password for the new VM.
.PARAMETER  

.EXAMPLE

.INPUTS

.OUTPUTS

.NOTES
    Could consider making it act more like a cmdlet by add Param block.
    The advantage to the current config is that it works you through the process without needing to remember what params to use.
.LINK

#>

# Prompt for name of new VM
$VMName = Read-Host -Prompt "Enter Name of New VM"
#Create Variable for IPAddress
$PublicIPAddName = $VMName + "-ip"
# Get credentials for new VM
$Cred = (Get-Credential)
$PublicIPAddName = $VMName + "-ip"
# Create Hashtable from JSON. Request JSON URL from Github that contains VM parameters.
$URI = Read-Host -Prompt "Enter URI"
$VMParams = Invoke-WebRequest -Uri $URI
$VMParams = ($VMParams).content
$VMParams = $VMParams | ConvertFrom-Json -AsHashtable
$VMParams.Add("PublicIPAddressName", $PublicIPAddName)
$VMParams.Add("Name", "$VMName")
$VMParams.Add("Credential", $Cred)
$VMParams


# These lines are currently to assist in debugging.
Write-Host "Selected VM Name is: $VMName"
Write-Host "Building $VMName. Please be patient."

# Create VM
New-AzVM @VMParams