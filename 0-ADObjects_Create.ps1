Set-ExecutionPolicy Unrestricted 
#A
Enter-PSSession -ComputerName LUONG01 -Credential STEPHEN\Administrator 

# Create AD OBJECTS 
## GROUPS 

New-ADGroup -Name "Staff" -GroupCategory Security -GroupScope "Global"
New-ADGroup -Name "Managers" -GroupCategory Security -GroupScope "Global"
New-ADGroup -Name "Downtown" -GroupCategory Security -GroupScope "Global"
New-ADGroup -Name "Mayfield" -GroupCategory Security -GroupScope "Global"

## Managers
#=============================================================================================
New-ADUser -Name "Michael Scott" -GivenName "Michael" -Surname "Scott" -SamAccountName "Michael.Scott" -UserPrincipalName "Michael.Scott@stephen.local" -Office "HQ" -Title "Manager" -AccountPassword (ConvertTo-SecureString -AsPlainText "Password1" -Force) -Enabled $true

New-ADUser -Name "Dwight Schrute" -GivenName "Dwight" -Surname "Schrute" -SamAccountName "Dwight.Schrute" -UserPrincipalName "Dwight.Schrute@stephen.local" -Office "HQ" -Title "Manager" -AccountPassword (ConvertTo-SecureString -AsPlainText "Password1" -Force) -Enabled $true

Add-ADGroupMember -Identity "Managers" -Members Michael.Scott, Dwight.Schrute

Write-Host "Users created and added to the Manager Group."
 

## Downtown
#=============================================================================================
New-ADUser -Name "Kelly Kapoor" -GivenName "Kelly" -Surname "Kapoor" -SamAccountName "Kelly.Kapoor" -UserPrincipalName "Kelly.Kapoor@stephen.local" -Office "Downtown" -Title "Manager" -AccountPassword (ConvertTo-SecureString -AsPlainText "Password1" -Force) -Enabled $true

Add-ADGroupMember -Identity "Downtown" -Members Kelly.Kapoor, Dwight.Schrute

Write-Host "Users created and added to the Downtown Group."

## Mayfield
#=============================================================================================
New-ADUser -Name "Jim Halpert" -GivenName "Jim" -Surname "Halpert" -SamAccountName "Jim.Halpert" -UserPrincipalName "Jim.Halpert@stephen.local" -Office "Mayfield" -Title "Manager" -AccountPassword (ConvertTo-SecureString -AsPlainText "Password1" -Force) -Enabled $true

New-ADUser -Name "Pam Beelsy" -GivenName "Pam" -Surname "Beelsy" -SamAccountName "Pam.Beelsy" -UserPrincipalName "Pam.Beelsy@stephen.local" -Office "Mayfield" -Title "Accountant" -AccountPassword (ConvertTo-SecureString -AsPlainText "Password1" -Force) -Enabled $true

Add-ADGroupMember -Identity "Mayfield" -Members Jim.Halpert, Pam.Beelsy

Write-Host "Users created and added to the Mayfield Group."


## HR
New-ADUser -Name "Toby Flenderson" -GivenName "Toby" -Surname "Flenderson" -SamAccountName "Toby.Flenderson" -UserPrincipalName "Toby.Flenderson@stephen.local" -Office "Mayfield" -Title "HR Representative" -AccountPassword (ConvertTo-SecureString -AsPlainText "Password1" -Force) -Enabled $true

Add-ADGroupMember -Identity "Staff" -Members Michael.Scott, Dwight.Schrute, Kelly.Kapoor, Jim.Halpert, Pam.Beelsy, Toby.Flenderson