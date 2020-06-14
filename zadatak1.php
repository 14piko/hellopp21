<?php

// zadatak1.php
// stranica prima dva brojčana parametra pod ključevima 
//b1 i b2 program ispisuje u tabličnom formi sljedeće podatke
// zbroj, razliku,umnožak i kvocijent
//mora biti dostupno na 
//https://polaznikxx.edunova.hr/zadatak1.php

$b1=$_GET['b1'];
$b2=$_GET['b2'];

echo "<table style='width:100%'>",
"<tr>","<td>",$b1 + $b2,"</td>",
"<td>",$b1 - $b2,"</td>",
"<td>",$b1 * $b2,"</td>",
"<td>",$b1/$b2,"</td>",
"<tr>","</table>";

?>