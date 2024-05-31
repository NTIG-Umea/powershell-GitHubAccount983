
Add-ADGroupmember -Identity "Wilmers Folk" -Members "Ketch.Upen"

New-Item -Path "\\adc-a\c$\Shares" -Name "Test" -ItemType "Directory"

$acl = Get-Acl -Path "\\adc-a\c$\Shares\Test"
$accessRule = New-Object System.Security.AccessControl.FileSystemAccessRule("Wilmers Folk", "Modify","Allow")
$acl.SetAccessRule($accessRule)
$acl | Set-Acl -Path "\\adc-a\c$\Shares\Test"

Invoke-Command -ComputerName adc-a -ScriptBlock{
New-SmbShare -Name "Test" -Path "C:\Shares\Test"
}