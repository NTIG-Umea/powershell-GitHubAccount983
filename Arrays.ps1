#Arrays är en lista av saker, räkningen börjar alltid på noll, det går att byta namn på något i lista samt välja vilka som ska vara synliga

$rooms = "Athena", "Troja", "Aristoteles", "Platon"

Write-Host $rooms.Length
Write-Host $rooms[0]
Write-Host $rooms[0,2]
Write-Host $rooms[0..3]
Write-Host $rooms[-1]

$rooms[2] = "Sapfo"
Write-Host $rooms