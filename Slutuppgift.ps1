
$names = Import-Csv Slutuppgift.csv
$usercounter = 0;

#Skapar OU beroende på personens roll om ett OU inte redan finns
foreach($role in $names){
    if(-not(Get-ADOrganizationalUnit -F{Name -eq $role.role})){
    New-ADOrganizationalUnit -Name $role.role
    }
}
#Detsamma fast med grupper och elevernas program
foreach($program in $names){
    if (-not (Get-ADGroup -F{Name -eq $program.program})){
    New-ADGroup -Name $program.program
    }

}
foreach ($name in $names){
    #Bestämer OU och Grupp beroende på roll
    if ($name.role -eq "teacher"){
        $Path = "OU=Teachers, DC=TheDomain"
        $Group = "Teachers"
    }
    elseif ($name.role -eq "student") {
        $Path = "OU=Students, DC=TheDomain"
        $Group = "Student-" + " " + $name.program
    }
    #Skapar användare och mail med unika namn, samt lägger till de i korrekt grupp/OU
    $username = $name.firstname + " " + $name.lastname
    $usermail = $name.firstname + "." + $name.lastname + "@gmail.com"
    if(Get-AdUser -F {SamAccountName -eq $username}){
        $username = $username + $usercounter++
        $usermail = $usermail + $usercounter++
        New-ADUser -Name $username -EmailAddress $usermail -Path $Path
        Add-ADGroupmember -Identity $Group -Members $username
    }
    else{
        New-ADUser -Name $username -EmailAddress $usermail -Path $Path
        Add-ADGroupmember -Identity $Group -Members $username 
    }
}
#Skapar en mapp för varje elevgrupp och ger modifierings rättigheter till alla i korrekt grupp
$StudentGroups = Get-ADGroup -F(Name -like "Student-*")
foreach($StudentGroup in $StudentGroups){
    $Folder = $name.program + "Folder"
    New-Item -Path "\\Server\c$" -Name $name.program + "Folder" -ItemType "Directory"
    
    $acl = Get-Acl -Path \\Server\c$\$Folder
    $accessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($Group, "Modify","Allow")
    $acl.SetAccessRule($accessRule)
    $acl | Set-Acl -Path \\Server\c$\$Folder
}
#Samma sak fast för Lärare
$TeacherGroups = Get-ADGroup -F(Name -eq "Teachers")
foreach($TeacherGroup in $TeacherGroups){
    $Folder = $name.program + "Folder"
    New-Item -Path "\\Server\c$" -Name $Folder + "Folder" -ItemType "Directory"
    
    $acl = Get-Acl -Path \\Server\c$\$Folder
    $accessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($Group, "Modify","Allow")
    $acl.SetAccessRule($accessRule)
    $acl | Set-Acl -Path \\Server\c$\$Folder
}
