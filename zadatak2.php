<?php

// zadatak2.php
// stranica prima tri parametra pod ključevima 
// naziv, adresa i mjesto. Program označava vrijednost pod 
// nazivom s h1 oznakom, vrijednost adresa s address oznakom 
// te vrijednost mjesto s span oznakom. 
// sve tri vrijednosti prikazane su vizualno jedne pokraj drugih //

$a=$_GET['naziv'];
$b=$_GET['adresa'];
$c=$_GET['mjesto'];

echo '<h1>Naziv:</h1>', $a,
' Adresa:<adress>', $b,
'</adress><span style="clear:both;"> Mjesto: </span>', $c;


?>