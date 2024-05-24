$names = Import-Csv Slutuppgift.csv
$usercounter = 0;

foreach ($name in $names){
    $username = $name.firstname + " " + $name.lastname
    if(Get-AdUser -F {SamAccountName -eq $username}){
        $username = $username + $usercounter++
        New-ADUser -Name $username -EmailAddress $usermail -Path "Eventuell OU"
    }
    else{
        New-ADUser -Name $username -EmailAddress $usermail -Path "Eventuell OU" 

    }

}
#Lägger till en VPN koppling med Test1 som har en ip på 10.1.1.1
Add-VpnConnection -Name "Test1" -ServerAddress 10.1.1.1 

#Automatiskt raderar medlemmar i en grupp efter projektet är klart
if(Projekt A -eq finished) {
    Foreach($member in Get-AdGroupMember -Identity Test1)
    Remove-ADUser -Identity $username


}