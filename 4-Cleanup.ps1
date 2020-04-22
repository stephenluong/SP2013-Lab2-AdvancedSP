# •	Cleanup.txt: This will include the PowerShell command to remove the survey sub-site as well as the restore command to restore it later.
<#
The survey site will be removed on January 1st, so provide the PowerShell command to remove this sub-site at that date.  
However, the survey sub-site will likely be restored next November, so provide the PowerShell command to restore the most recent backup of the survey sub-site.
#>
# https://docs.microsoft.com/en-us/powershell/module/sharepoint-server/import-spweb?view=sharepoint-ps
# https://docs.microsoft.com/en-us/powershell/module/sharepoint-server/remove-spweb?view=sharepoint-ps
# https://www.enjoysharepoint.com/delete-sharepoint-site-using-powershell/
Set-ExecutionPolicy -ExecutionPolicy “Unrestricted” -Force
# !!!!! NOTE: Scheduled Jobs are located \Microsoft\Windows\PowerShell\ScheduledJobs !!!!!
# HIGHLIGHT AND PRESS F8 (Comments Below)
# Unregister-ScheduledJob -Name "Remove-Survey-Site"
# Unregister-ScheduledJob -Name "Restore-Survey-Site"
Start-Job -DefinitionName "Sites-Backup-Weekly"
$username = "STEPHEN\SPAdmin"
$password = ConvertTo-SecureString "Password1" -AsPlainText -Force
$cred = New-Object System.Management.Automation.PSCredential -ArgumentList ($username, $password)
$option = New-ScheduledJobOption -RunElevated
# REMOVE
$TriggerJan = New-JobTrigger -Once -At "1/1/2021 12:00 AM"
Register-ScheduledJob -Name "Remove-Survey-Site" -ScriptBlock {
    Add-PSSnapin Microsoft.SharePoint.PowerShell
    $SiteURL = "http://luong01:20913/dundermifflin/survey/"
    $web = Get-SPWeb $SiteURL
    Remove-SPweb -Identity $web -Confirm:$false
} -Credential $cred -ScheduledJobOption $option -Trigger $TriggerJan
# RESTORE
$TriggerNov = New-JobTrigger -Once -At "11/1/2021 12:00 AM"
Register-ScheduledJob -Name "Restore-Survey-Site" -ScriptBlock {
    Add-PSSnapin Microsoft.SharePoint.PowerShell
    New-SPWeb http://luong01:20913/dundermifflin/survey -Template "STS#0" -Name Survey –AddToTopNav –UseParentTopNav –UniquePermissions
    Import-SPWeb http://luong01:20913/dundermifflin/survey -Path "C:\Backup\Survey.bak" -Confirm:$false -Force -IncludeUserSecurity
} -Credential $cred -ScheduledJobOption $option -Trigger $TriggerNov
# HIGHLIGHT AND PRESS F8 to test and validate (Don't forget to refresh the page!) 
# Start-Job -DefinitionName "Remove-Survey-Site"
# Start-Job -DefinitionName "Restore-Survey-Site"


 