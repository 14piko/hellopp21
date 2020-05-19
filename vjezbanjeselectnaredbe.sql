use knjiznica;
#VJEŽBANJE SELECT NAREDBE
#prvi zadatak izlistati imena i prezimena svih autora
select ime,prezime from autor
where (sifra>=1);
#Izlistajte sve naslove knjiga u katologu koje u sebi sadrţe niz znakova LJUB
select naslov from katalog 
where naslov like '%LJUB%';
#Izlistajte sva mjesta koja imaju definiran poštanski broj
SELECT naziv, postanskiBroj from mjesto
WHERE (postanskiBroj is not null);
#Izlistajte nazive mjesta čija šifra nije izmeĎu 2000 i 3000
select naziv,sifra from mjesto 
where not (sifra between 2000 and 3000);
#Postoji li u Hrvatsko mjesto koje počinje s slovom Y?NE. :)
select naziv from mjesto
where naziv like 'Y%';
#Koliko je autora roĎeno 7. prosinca 1980? 0 
select datumrodenja from autor 
where datumrodenja='1980-12-07';
#Izlistajte sve aktivne izdavače čiji naziv završava s znakom . (točka)
select naziv,aktivan from izdavac
where aktivan='1'and naziv like '%.';
#Izlistajte sve neaktivne izdavače koji nemaju šifre 346, 234, 589
select naziv,aktivan,sifra from izdavac
where not (sifra=589 or sifra=234 or sifra=346) and aktivan='0';
#Izlistajte sve katalozne zapise čija je šifra veća od 3000 ili naslov u sebi sadrţi riječ ljubav
select naslov,sifra from katalog 
where sifra>=3000 or naslov like '%ljubav%';
