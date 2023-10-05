$characters = "abcdefqhijklmnopqrstuvwxyz123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ!£&"
$password = ""

for ($i = 0; $i -lt 8; $i++) {
    $randomnum = Get-Random -max $characters.Length
    $password += $characters[$randomnum]
}

Write-Host $password