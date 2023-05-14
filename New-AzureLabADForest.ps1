<#
Create Domain Controller

Sample Powershell script for setting up ADDS
https://cloud.google.com/architecture/deploy-fault-tolerant-active-directory-environment

#>

# Install ADDS
Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools

# Configure Variables
$DomainName = 'ad.hexagon1527.com'
$DomainMode = "7"
$ForestMode = "7"
$DatabasePath = "C:\Windows\NTDS"
$SysvolPath = "C:\Windows\SYSVOL"
$LogPath = "C:\Logs"

# Create new ADDS Forest
Install-ADDSForest -CreateDnsDelegation:$false `
-DatabasePath $DatabasePath `
-LogPath $LogPath `
-SysvolPath $SysvolPath `
-DomainName $DomainName `
-DomainMode $DomainMode `
-ForestMode $ForestMode `
-InstallDNS:$true `
-NoRebootOnCompletion:$true `
-Force:$true

Write-Host "AD Forest creation complete"

#Restart Computer
Restart-Computer