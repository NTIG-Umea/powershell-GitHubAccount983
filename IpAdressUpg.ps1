
$name = 0;

while ($name -lt 256) {
    $name = $name + 1;
    Write-Output "192.168.0.$name";

}