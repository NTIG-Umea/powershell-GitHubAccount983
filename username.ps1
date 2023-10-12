$names = Import-Csv names.csv

#Den här:
foreach($name in $names) {
    Write-Host $name.firstname.Substring(0,2) $name.lastname.Substring(0,2)
}

#Eller denna:
foreach($name in $names) {
    Write-Host $name.firstname[0,1] $name.lastname[0,1]
}

