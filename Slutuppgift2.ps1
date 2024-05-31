$names = Import-Csv Slutuppgift2.csv
$usercounter = 0;

foreach ($name in $names){
    #Skapar Grupp och OU till varje Projekt om det inte redan finns
    $Project = $name.project
    $Group = $name.project + "Group"
    if(-not(Get-ADOrganizationalUnit -F{Name -eq $Project})){
        New-ADOrganizationalUnit -Name $Project
    if(-not(Get-ADGroup -F{Name -eq $Group})){
        New-ADGroup -Name $Group
        }
    }
    #Skapar unika användare och mail åt varje person
    $username = $name.firstname + " " + $name.lastname
    $usermail = $name.firstname + "." + $name.lastname + "@CC.com"
    
    if(Get-AdUser -F {SamAccountName -eq $username}){
        $username = $username + $usercounter++
        $usermail = $usermail + $usercounter++
        New-ADUser -Name $username -EmailAddress $usermail -Path $Project
        Add-ADGroupmember -Identity $Group -Members $username
    }
    else{
        New-ADUser -Name $username -EmailAddress $usermail -Path $Project 
        Add-ADGroupmember -Identity $Group -Members $username

    }
    #Automatiskt raderar medlemmar i en grupp efter projektet är klart
    if($name.status -eq "Completed"){
        Remove-ADUser -Identity $username
    }
}
#Kopplar upp en VPN med namn CCServer
Add-VpnConnection -Name "CCServer" -ServerAddress 10.1.1.1 -AuthenticationMethod Pap -TunnelType Automatic -RememberCredential $true

