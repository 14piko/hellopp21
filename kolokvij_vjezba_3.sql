#c:\xampp\mysql\bin\mysql -uedunova -pedunova --default_character_set=utf8 < c:\pp21\kolokvij_vjezba_3.sql

drop database if exists kolokvij_vjezba_3;
create database kolokvij_vjezba_3;
use kolokvij_vjezba_3;

create table svekar(
sifra int not null primary key auto_increment,
novcica decimal(16,8) not null,
suknja varchar(44) not null,
bojakose varchar(36),
prstena int,
narukvica int not null,
cura int not null
);

create table cura(
sifra int not null primary key auto_increment,
dukserica varchar(49),
maraka decimal(13,7),
drugiputa datetime,
majica varchar(49),
novcica decimal(15,8),
ogrlica int not null
);

create table ostavljena(
sifra int not null primary key auto_increment,
kuna decimal(17,5),
lipa decimal(15,6),
majica varchar(36),
modelnaocala varchar(31) not null,
prijatelj int
);

create table prijatelj(
sifra int not null primary key auto_increment,
kuna decimal(16,10),
haljina varchar(37),
lipa decimal(13,10),
dukserica varchar(31),
indiferentno bit not null
);

create table prijatelj_brat(
sifra int not null primary key auto_increment,
prijatelj int not null,
brat int not null
);

create table brat(
sifra int not null primary key auto_increment,
jmbag char(11),
ogrlica int not null,
ekstroventno bit not null
);

create table snasa(
sifra int not null primary key auto_increment,
introvertno bit,
kuna decimal(15,6) not null,
eura decimal(12,9) not null,
treciputa datetime,
ostavljena int not null
);

create table punica(
sifra int not null primary key auto_increment,
asocijalno bit,
kratkamajica varchar(44),
kuna decimal(13,8) not null,
vesta varchar(32) not null,
snasa int
);

#vanjski ključevi
alter table svekar add foreign key(cura) references cura(sifra);
alter table ostavljena add foreign key(prijatelj) references prijatelj(sifra);
alter table prijatelj_brat add foreign key(prijatelj) references prijatelj(sifra);
alter table prijatelj_brat add foreign key(brat) references brat(sifra);
alter table snasa add foreign key(ostavljena) references ostavljena(sifra);
alter table punica add foreign key(snasa) references snasa(sifra);

#1. U tablice snasa, ostavljena i prijatelj_brat unesite po 3 retka.

select * from snasa;
select * from ostavljena;
select * from prijatelj_brat;
select * from prijatelj;
select * from brat;

insert into prijatelj(kuna,haljina,lipa,dukserica,indiferentno) values
('200','Crna','50','Zuta',1),
('200','Rozna','40','Crvena',1),
('200','Crna','30','Plava',1);

insert into brat(jmbag,ogrlica,ekstroventno) values
('45214578962','2',1),
('14578962452','3',1),
('78962785621','1',1);

insert into ostavljena(kuna,lipa,majica,modelnaocala,prijatelj) values
('8500','92','Crvena','Police',1),
('6500','100','Plava','Police',2),
('5000','40','Rozna','RayBan',3);

insert into snasa(introvertno,kuna,eura,treciputa,ostavljena) values
(1,'2000','100','2020-05-11',1),
(1,'2500','200','2020-06-11',2),
(1,'3000','300','2020-07-11',3);

insert into prijatelj_brat(prijatelj,brat) values
(1,1),
(2,2),
(3,3);


#2. U tablici svekar postavite svim zapisima kolonu suknja na vrijednost Osijek.

describe svekar;
select * from svekar;
select * from cura;

insert into cura(maraka,novcica,ogrlica) values
('200','200.50','3');

insert into svekar(novcica,suknja,narukvica,cura) values
('200.50','Crvena','2',1);

update svekar set suknja='Osijek';

#3. U tablici punica obrišite sve zapise čija je vrijednost kolone kratkamajica jednako AB.
select * from punica;

insert into punica(asocijalno,kratkamajica,kuna,vesta,snasa) values
(1,'AB','200','Plava',1),
(1,'Plava','300','Žuta',2),
(1,'Žuta','500','Crvena',3);

delete from punica where kratkamajica='AB';

#4. Izlistajte majica iz tablice ostavljena uz uvjet da vrijednost kolone lipa nije 9,10,20,30 ili 35.
select * from ostavljena;
select majica from ostavljena where lipa not in (9,10,20,30 or 35);

#5. Prikažite ekstroventno iz tablice brat, vesta iz tablice punica te kuna iz tablice snasa uz uvjet da su vrijednosti kolone lipa iz tablice ostavljena različito od 91 te da su vrijednosti kolone haljina iz tablice prijatelj sadrže niz znakova ba. Podatke posložite po kuna iz tablice snasa silazno.
select b.ekstroventno,u.vesta,s.kuna
from brat b inner join prijatelj_brat z on z.brat=b.sifra 
inner join prijatelj p on z.prijatelj=p.sifra 
inner join ostavljena o on o.prijatelj=p.sifra
inner join snasa s on s.ostavljena=o.sifra 
inner join punica u on u.snasa=s.sifra
where o.lipa!='91' and p.haljina like '%ba'
order by s.kuna desc;

#6. Prikažite kolone haljina i lipa iz tablice prijatelj čiji se primarni ključ ne nalaze u tablici prijatelj_brat.
select p.haljina,p.lipa
from prijatelj p left join prijatelj_brat z on p.sifra=z.prijatelj
where z.prijatelj is null;








