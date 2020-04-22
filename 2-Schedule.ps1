# •	Schedule.txt: Scheduling of backups, in the correct location, with appropriate names for each backup file
# https://docs.microsoft.com/en-gb/powershell/module/sharepoint-server/backup-spfarm?view=sharepoint-ps
# https://docs.microsoft.com/en-gb/powershell/module/sharepoint-server/backup-spsite?view=sharepoint-ps
# https://docs.microsoft.com/en-us/powershell/module/sharepoint-server/export-spweb?view=sharepoint-ps
# https://devblogs.microsoft.com/scripting/use-powershell-to-create-scheduled-tasks/
# https://devblogs.microsoft.com/scripting/weekend-scripter-use-powershell-to-back-up-sharepoint-installation/
# https://docs.microsoft.com/en-gb/powershell/module/psscheduledjob/about/about_scheduled_jobs?view=powershell-5.1
#PSSchechduledJob
#Get-Command -Module "ScheduledTasks"
#Add-PSSnapin Microsoft.SharePoint.PowerShell -ErrorAction Stop
Set-ExecutionPolicy -ExecutionPolicy “Unrestricted” -Force
Add-PSSnapin Microsoft.SharePoint.PowerShell
# HIGHLIGHT AND PRESS F8 (Comments Below)
# Unregister-ScheduledJob -Name "Sites-Backup-Weekly"
# Unregister-ScheduledJob -Name "Farm-Backup-Monthly"
New-Item -ItemType "directory" -Path "c:\Backup\Farm.bak"
# !!!!! NOTE: Scheduled Jobs are located \Microsoft\Windows\PowerShell\ScheduledJobs !!!!!
#       Ensure SPFarm + SPQLService have Read/Write Permissions on Backup folder
# Variables 
$username = "STEPHEN\SPAdmin" 
$password = ConvertTo-SecureString "Password1" -AsPlainText -Force
$cred = New-Object System.Management.Automation.PSCredential -ArgumentList ("$username", $password)
$option = New-ScheduledJobOption -RunElevated
# Backup Monthly - Farm
$TriggerM = New-JobTrigger -Weekly -At "12:00 AM" -DaysOfWeek Saturday -WeeksInterval 4
# Register the Farm and Site collection Backup in the Task Scheduler 
Register-ScheduledJob -Name "Farm-Backup-Monthly" -ScriptBlock {
    Add-PSSnapin Microsoft.SharePoint.PowerShell
    Backup-SPFarm -Directory c:\Backup\Farm.bak -BackupMethod Full 
    Backup-SPSite http://luong01:20913/dundermifflin -Path "C:\Backup\dundermifflin.bak"
} -Credential $cred -ScheduledJobOption $option -Trigger $TriggerM
# Backup Weekly - Subsites
$TriggerW = New-JobTrigger -Weekly -At "12:00 AM" -DaysOfWeek Saturday -WeeksInterval 1
Register-ScheduledJob -Name "Sites-Backup-Weekly" -ScriptBlock {
    Add-PSSnapin Microsoft.SharePoint.PowerShell
    Export-SPWeb http://luong01:20913/dundermifflin/faq -Path "C:\Backup\FAQ.bak" -Force -IncludeUserSecurity
    Export-SPWeb http://luong01:20913/dundermifflin/announcements -Path "C:\Backup\Announcements.bak" -Force -IncludeUserSecurity
    Export-SPWeb http://luong01:20913/dundermifflin/blog -Path "C:\Backup\Blog.bak" -Force -IncludeUserSecurity
    Export-SPWeb http://luong01:20913/dundermifflin/survey -Path "C:\Backup\Survey.bak" -Force -IncludeUserSecurity
    # Could include the parameter -UseSqlSnapshot for user / site availability 
} -Credential $cred -ScheduledJobOption $option -Trigger $TriggerW
# Get-Job
Start-Job -DefinitionName "Sites-Backup-Weekly"
Start-Job -DefinitionName "Farm-Backup-Monthly"









