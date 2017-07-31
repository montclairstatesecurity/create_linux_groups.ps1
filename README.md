# create_linux_groups.ps1

Script to create Active Directory Groups by hostname, domain for Linux Servers. Creates two groups in Active Directory with the naming convention sec\_*hostname*\_users and sec\_*hostname*\_admins. Follows the Security Groups' AD Group Standard.

Requirements:
* Must be run as a user with Group Creation privileges on the Security Groups OU

* Must have the RSAT Active Directory Powershell Module installed: 
 
  RSAT for Win7: https://www.microsoft.com/en-us/download/details.aspx?id=7887  
  RSAT for Win10: https://www.microsoft.com/en-us/download/details.aspx?id=45520

  Once RSAT is installed, enable Active Directory Powershell Module in "Turn Windows Features On or Off"  
  Then in Powershell, run the cmdlet to import the module: **Import-Module ActiveDirectory**

Parameters:
* hostname: the hostname of the server, no domain
* domain: ADMSU, BNRAD, or FINERP
