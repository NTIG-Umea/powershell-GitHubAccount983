$users = Import-Csv userlist.csv | select *,username,mail,password

$characters = "abcdefqhijklmnopqrstuvwxyz123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ!£&"

foreach($user in $users) {
    $user.username = $user.firstname + "." + $user.lastname
    $user.mail = $user.firstname + "." + $user.lastname + "@gmail.com"
    
    $password = ""
    for ($i = 0; $i -lt 8; $i++) {
        $randomnum = Get-Random -max $characters.Length
        $password += $characters[$randomnum]
    }
    $user.password = $password
    }
    $users


