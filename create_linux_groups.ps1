# create_linux_groups.ps1

# Creates two groups in Active Directory with the naming convention sec_hostname_users and sec_hostname_admins
# Follows the AD Group Standard document

# Requirements:
#     - Must be run as a user with Group creation privileges on the Security Groups OU
#     - Must have the RSAT Active Directory Powershell Module installed
#          RSAT for Win7: https://www.microsoft.com/en-us/download/details.aspx?id=7887
#          RSAT for Win10: https://www.microsoft.com/en-us/download/details.aspx?id=45520
#     - From Powershell: import-module activedirectory

# Parameters
#    hostname: the hostname of the server, no domain
#    domain: ADMSU, BNRAD, or FINERP

param (
    [Parameter(Mandatory=$true)][string]$hostname = $( Read-Host "Specify a hostname, no FQDN, eg. -hostname msu-web-prd1" ),
    [Parameter(Mandatory=$true)][string]$domain = $( Read-Host "Specify ADMSU, BNRAD, FINERP" )
 )

# Populate group names
$usergroup = 'sec_' + $hostname + '_users'
$admingroup = 'sec_' + $hostname + '_admins'

# Populate descriptions
$userdesc = "Basic access rights to " + $hostname
$admindesc  = "Admin level access to " + $hostname

# Choose the path based on domain
switch ($domain)
{
    "ADMSU" { $grouppath = "OU=Linux MSU Servers,OU=Security Groups,OU=Groups,DC=admsu,DC=montclair,DC=edu" }
    "BNRAD" { $grouppath = "OU=Linux Banner Servers,OU=Security Groups,OU=Groups,DC=admsu,DC=montclair,DC=edu" }
    "FINERP" { $grouppath = "OU=Linux PeopleSoft Servers,OU=Security Groups,OU=Groups,DC=admsu,DC=montclair,DC=edu" }
    default { 
              write-host "Domain must be ADMSU, BNRAD, or FINERP"
              exit 
             }
}

# Write the groups to the domain
NEW-ADGroup –name "$usergroup" –groupscope Universal –path $grouppath -Description $userdesc
NEW-ADGroup –name “$admingroup" –groupscope Universal –path $grouppath -Description $admindesc
