$names = Import-Csv Adduser.csv

foreach($name in $names) {
    $username = $name.firstname + " " + $name.lastname
    $usernamecounter = 0;
    If(Get-ADUser -F {SamAccountName -eq $username}) {
        $username = $username + $usernamecounter++
        New-ADUser -Name $username -Path "OU=Wilmers Anvandare, DC=Walters, DC=Labb"
    }
    else{
        New-ADUser -Name $username -Path "OU=Wilmers Anvandare, DC=Walters, DC=Labb"
    }
}
