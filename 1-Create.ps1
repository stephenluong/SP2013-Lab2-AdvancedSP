# •	Create.txt: Creation of the site collection and all sub-sites
#=============================================================================================
# https://github.com/borkit/scriptdump/blob/05535cff46642534a42eb3f9c8fdd481f0501af1/PowerShell/Working/SharePoint/SharePoint2013/SP2013CreateSiteCollectionInOwnContentDB.ps1
# https://www.c-sharpcorner.com/article/basic-operations-in-sharepoint-2013-using-powershell/
# https://sharepointmaven.com/3-ways-create-faq-knowledge-base-sharepoint/

#Update-Help
#Get-Command -Module "Microsoft.SharePoint.PowerShell"
# Create a new site collection 
# Creates a new content database and attaches it to the specified Web application.
#New-SPConfigurationDatabase -DatabaseName "SharePointConfigLAB2" -DatabaseServer "LUONG01" -Passphrase (ConvertTo-SecureString "MyPassword" -AsPlainText -force) -FarmCredentials (Get-Credential) -SkipRegisterAsDistributedCacheHost

Set-ExecutionPolicy Unrestricted
Add-PSSnapin Microsoft.SharePoint.PowerShell
$ap = New-SPAuthenticationProvider
New-SPWebApplication -Name "Dunder Mifflin - WebApp" -Port 20913 -URL "http://luong01" -ApplicationPool "DunderMifflin - WebApp" -ApplicationPoolAccount (Get-SPManagedAccount "STEPHEN\SPFarm") -AuthenticationProvider $ap -DatabaseServer LUONG01 -DatabaseName "WSS_Content_2022_LAB2_dundermifflin" -Path C:\inetpub\wwwroot\wss\VirtualDirectories\20913
New-SPManagedPath -RelativeURL "/dundermifflin" -WebApplication http://luong01:20913 -Explicit
#$w = Get-SPWebApplication http://luong01:20913
New-SPSite -URL "http://luong01:20913/dundermifflin" -OwnerAlias STEPHEN\Michael.Scott -SecondaryOwnerAlias STEPHEN\SPAdmin -ContentDatabase WSS_Content_2022_LAB2_dundermifflin -Name "Dunder Mifflin" -Template "STS#1" #"SPSSITES#0" -HostHeaderWebApplication $w 
# Four Team sub-sites (FAQ, Announcements, Blog and Survey)
# Get-SPWebTemplate
# http://luong01:20913/dundermifflin to access home! 
New-SPWeb http://luong01:20913/dundermifflin/faq -Template "STS#0" -Name FAQ –AddToTopNav –UseParentTopNav –UniquePermissions
New-SPWeb http://luong01:20913/dundermifflin/announcements -Template "STS#0" -Name Announcements –AddToTopNav –UseParentTopNav –UniquePermissions
New-SPWeb http://luong01:20913/dundermifflin/blog -Template "STS#0" -Name Blog –AddToTopNav –UseParentTopNav –UniquePermissions
New-SPWeb http://luong01:20913/dundermifflin/survey -Template "STS#0" -Name Survey –AddToTopNav –UseParentTopNav –UniquePermissions

# The Document said, four teams sites... but than you provided a link with different Template IDs....
<#
Get-SPWeb http://luong01:20913/dundermifflin/faq | Set-SPWeb -Template "WIKI#0"
Get-SPWeb http://luong01:20913/dundermifflin/announcements | Set-SPWeb -Template "SPSNHOME#0"
Get-SPWeb http://luong01:20913/dundermifflin/blog | Set-SPWeb -Template "BLOG#0"
Get-SPWeb http://luong01:20913/dundermifflin/survey | Set-SPWeb -Template "MPS#2"
#>
