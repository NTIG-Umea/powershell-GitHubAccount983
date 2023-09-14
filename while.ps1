#While-loop: Repeterar så länge någonting stämmer och slutar när det ändras.
#Variabel med ++ ökar med 1 och -- minskar med 1

$counter = 0;

while ($counter -lt 20) {
    $counter = $counter + 3;
    Write-Output $counter;

}