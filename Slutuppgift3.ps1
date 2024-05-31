$names = Import-Csv Slutuppgift3.csv

foreach($name in $names){
    $username = $name.firstname + " " + $name.lastname
    
    if(Get-AdUser -F {SamAccountName -eq $username}){
        $username = $username + $usercounter++
        New-ADUser -Name $username -EmailAddress $usermail -Path $Project
        Add-ADGroupmember -Identity $Group -Members $username
    }
    else{
        New-ADUser -Name $username -EmailAddress $usermail -Path $Project 
        Add-ADGroupmember -Identity $Group -Members $username

    }
    #Ta bort en Visstidsanställd efter 30 dagar, inte färdigt.
    if($name.role -eq "Temporary"){
        Remove-ADUser -Identity $username
        $expirationdate = (Get-Date).AddDays(30)

        #Dela en fil med Huvudkontoret
        Invoke-Command -ComputerName adc-a -ScriptBlock{
            New-SmbShare -Name "Huvudkontorfil" -Path "C:\Shares\Mapp"
            }

    }

}
