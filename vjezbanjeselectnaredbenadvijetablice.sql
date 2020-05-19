use knjiznica;
select b.naslov
from autor a inner join katalog b
on a.sifra=b.autor
where a.ime='August' and a.prezime='Šenoa';

select b.naslov,d.naziv
from autor a
inner join katalog b on a.sifra=b.autor
inner join izdavac c on b.izdavac=c.sifra
inner join mjesto d on b.mjesto=d.sifra 
where a.datumrodenja between '1976-01-01' and '1976-12-31' and c.aktivan=1;