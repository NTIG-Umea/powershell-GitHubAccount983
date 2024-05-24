#Skapa Användare och Mail
#Om användaren/mailen redan finns addera en siffra
#

$names = Import-Csv Slutuppgift.csv
$usercounter = 0;


foreach ($name in $names){
    $username = $name.firstname + " " + $name.lastname
    $usermail = $name.firstname + "." + $name.lastname + "@gmail.com"
    if(Get-AdUser -F {SamAccountName -eq $username}){
        $username = $username + $usercounter++
        $usermail = $usermail + $usercounter++
        New-ADUser -Name $username -EmailAddress $usermail -Path "Eventuell OU"
    }
    else{
        New-ADUser -Name $username -EmailAddress $usermail -Path "Eventuell OU" 
    }

}
#Skapa Grupp och Lägg till Medelem
Add-ADGroupmember -Identity "Wilmers Folk" -Members "Ketch.Upen"

#Ge en grupp rättigheter till specifik mapp
$acl = Get-Acl -Path "\\adc-a\c$\Shares\Test"
$accessRule = New-Object System.Security.AccessControl.FileSystemAccessRule("Wilmers Folk", "Modify","Allow")
$acl.SetAccessRule($accessRule)
$acl | Set-Acl -Path "\\adc-a\c$\Shares\Test"

#Skapa en Organisationsenhet
New-ADOrganizationalUnit -Name "Name"