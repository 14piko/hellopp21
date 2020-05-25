#c:\xampp\mysql\bin\mysql -uedunova -pedunova --default_character_set=utf8 < c:\pp21\kolokvij_vjezba_1.sql

drop database if exists kolokvij_vjezba_1;
create database kolokvij_vjezba_1;
use kolokvij_vjezba_1;

create table sestra(
sifra int not null primary key auto_increment,
jmbag char(11),
hlace varchar(42) not null,
vesta varchar(41),
prviputa datetime not null,
modelnaocala varchar(33),
becar int
);

create table becar(
sifra int not null primary key auto_increment,
drugiputa datetime not null,
carape varchar(36),
bojaociju varchar(46),
haljina varchar(32)
);

create table ostavljena(
sifra int not null primary key auto_increment,
jmbag char(11),
bojaociju varchar(49),
suknja varchar(31) not null,
bojakose varchar(45) not null,
prviputa datetime,
carape varchar(41) not null
);

create table mladic(
sifra int not null primary key auto_increment,
prstena int not null,
maraka decimal(15,9) not null,
suknja varchar(30),
narukvica int not null,
ostavljena int not null
);

create table ostavljena_snasa(
sifra int not null primary key auto_increment,
ostavljena int not null,
snasa int not null
);

create table cura(
sifra int not null primary key auto_increment,
bojakose varchar(36),
jmbag char(11) not null,
prstena int not null,
dukserica varchar(38),
mladic int
);

create table snasa(
sifra int not null primary key auto_increment,
eura decimal(14,5),
narukvica int,
drugiputa datetime not null,
carape varchar(41)
);

create table punac(
sifra int not null primary key auto_increment,
ekstroventno bit not null,
vesta varchar(31),
asocijalno bit not null,
prviputa datetime,
eura decimal(15,6) not null,
cura int
);

#vanjski ključevi
alter table sestra add foreign key(becar) references becar(sifra);
alter table ostavljena_snasa add foreign key (ostavljena) references ostavljena(sifra);
alter table ostavljena_snasa add foreign key (snasa) references snasa(sifra);
alter table mladic add foreign key (ostavljena) references ostavljena(sifra);
alter table cura add foreign key (mladic) references mladic(sifra);
alter table punac add foreign key (cura) references cura(sifra);

select * from cura;
select * from mladic;
select * from ostavljena;
select * from ostavljena_snasa;
select * from snasa;
#U tablice cura, mladic i ostavljena_snasa unesite po 3 retka.
insert into snasa(eura,narukvica,drugiputa,carape) values
('20000.50','2','2020-03-03 15:00:00','ljubičaste'),
('30000.00','1','2020-04-12 13:00:00','crvene'),
('55050.50','3','2020-07-30 06:00:00','crne');
insert into ostavljena(jmbag,bojaociju,suknja,bojakose,prviputa,carape) values
('25314563224','crna','crvena','crna','2020-05-18 17:00:00','crvene'),
('25231363224','plave','ljubičasta','plava','2020-05-20 15:00:00','crne'),
('52313136323','zelene','crna','plava','2020-06-08 12:00:00','bijele');
insert into mladic(prstena,maraka,suknja,narukvica,ostavljena) values
('1','2000.33','crvena','2',(1)),
('2','30000.33','crna','3',(2)),
('3','50000.00','plava','1',(3));
insert into cura(bojakose,jmbag,prstena,dukserica,mladic) values
('Crna','21547681237','2','crna',(1)),
('Smeđa','54768123721','1','crvena',(2)),
('Plava','76812372134','3','plava',(3));
insert into ostavljena_snasa(ostavljena,snasa) values
((1),(1)),
((2),(2)),
((3),(3));

#U tablici sestra postavite svim zapisima kolonu hlace na vrijednost Osijek.

insert into sestra (hlace,prviputa) values
('crne','2020-12-02'),
('žute','2020-11-05'),
('ljubičaste','2020-05-11');
describe sestra;
update sestra set hlace='Osijek';
select * from sestra;

#U tablici punac obrišite sve zapise čija je vrijednost kolone vesta različito od AB.

describe punac;
insert into punac(ekstroventno,vesta,asocijalno,prviputa,eura) values
(1,'AB',1,'2020-05-11','200.50'),
(1,'AC',1,'2020-08-22','300.50'),
(1,'crna',1,'2020-05-15','500.50');
select * from punac;

delete from punac where vesta!='AB';

#Izlistajte suknja iz tablice mladic uz uvjet da vrijednost kolone maraka nije 7,11,18,25 ili 40.

select *, suknja from mladic where maraka not in (7,11,18,25 or 40);
select * from mladic;

#5. Prikažite narukvica iz tablice snasa, prviputa iz tablice punac te jmbag iz tablice cura uz uvjet da su vrijednosti kolone maraka iz tablice mladic različito od 95 te da su vrijednosti kolone bojaociju iz tablice ostavljena sadrže niz znakova ba. Podatke posložite po jmbag iz tablice cura silazno.

select f.narukvica , a.prviputa , b.jmbag
from punac a inner join cura b on a.cura =b.sifra
inner join mladic c on b.mladic =c.sifra
inner join ostavljena d on c.ostavljena =d.sifra
inner join ostavljena_snasa e on e.ostavljena =d.sifra
inner join snasa f on e.snasa =f.sifra
where c.maraka != 95 and d.bojakose like '%ba%'
order by b.jmbag desc


#6. Prikažite kolone bojaociju i suknja iz tablice ostavljena čiji se primarni ključ ne nalaze u tablici ostavljena_snasa.

select a.bojaociju , a.suknja
from ostavljena a left join ostavljena_snasa b on a.sifra =b.ostavljena
where b.ostavljena is null;
