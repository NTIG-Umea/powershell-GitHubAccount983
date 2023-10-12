$names = Import-Csv names.csv

foreach($name in $names) {
    Write-Output $name.firstname $name.lastname

}