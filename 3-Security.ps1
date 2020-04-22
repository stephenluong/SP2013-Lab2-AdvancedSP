# •	Security.txt: Assignment of correct security for each site and site collection, including the secondary site collection administrator
# https://sharepoint.stackexchange.com/questions/144110/powershell-get-permission-on-spsite-spweb-and-all-list
# https://docs.microsoft.com/en-us/previous-versions/office/sharepoint-server/ee583297(v=office.15)?redirectedfrom=MSDN
# https://docs.microsoft.com/en-us/powershell/module/sharepoint-server/new-spuser?view=sharepoint-ps
# NOTE: –UniquePermissions was intialized at subsite creation, therefore inheritance was broken, thus the reassignment of all User / Group Permissions
Set-ExecutionPolicy -ExecutionPolicy “Unrestricted” -Force
Add-PSSnapin Microsoft.SharePoint.PowerShell
# Add Dwight as a secondary site collection administrator
$mainsite = Get-SPWeb http://luong01:20913/dundermifflin/
New-SPUser -UserAlias "STEPHEN\Dwight.Schrute" -Web $mainsite -SiteCollectionAdmin -PermissionLevel "Full Control"
New-SPUser -UserAlias "STEPHEN\Staff" -Web $mainsite -PermissionLevel "Read"
#$mainsite.GetWebsAndListsWithUniquePermissions()
# FAQ
$faq = Get-SPWeb http://luong01:20913/dundermifflin/faq
New-SPUser -UserAlias "STEPHEN\Managers" -Web $faq -PermissionLevel "Full Control"
New-SPUser -UserAlias "STEPHEN\Toby.Flenderson" -Web $faq -PermissionLevel "Full Control"
New-SPUser -UserAlias "STEPHEN\Staff" -Web $faq -PermissionLevel "Read"
# Annoucements
$announcements = Get-SPWeb http://luong01:20913/dundermifflin/announcements
New-SPUser -UserAlias "STEPHEN\Managers" -Web $announcements -PermissionLevel "Full Control"
New-SPUser -UserAlias "STEPHEN\Staff" -Web $announcements -PermissionLevel "Read"
# Blog
$blog = Get-SPWeb http://luong01:20913/dundermifflin/blog
New-SPUser -UserAlias "STEPHEN\Managers" -Web $blog -PermissionLevel "Full Control"
New-SPUser -UserAlias "STEPHEN\Staff" -Web $blog -PermissionLevel "Contribute"
# Survey
$survey = Get-SPWeb http://luong01:20913/dundermifflin/survey 
New-SPUser -UserAlias "STEPHEN\Managers" -Web $survey -PermissionLevel "Full Control"
New-SPUser -UserAlias "STEPHEN\Staff" -Web $survey -PermissionLevel "Contribute"






