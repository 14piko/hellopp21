#c:\xampp\mysql\bin\mysql -uedunova -pedunova --default_character_set=utf8 < c:\pp21\kolokvij_vjezba_2.sql

drop database if exists kolokvij_vjezba_2;
create database kolokvij_vjezba_2;
use kolokvij_vjezba_2;

create table cura(
sifra int not null primary key auto_increment,
haljina varchar(33) not null,
drugiputa datetime not null,
suknja varchar(38),
narukvica int,
introvertno bit,
majica varchar(40) not null,
decko int
);

create table decko(
sifra int not null primary key auto_increment,
indiferentno bit,
vesta varchar(34),
asocijalno bit not null
);

create table decko_zarucnica(
sifra int not null primary key auto_increment,
decko int not null,
zarucnica int not null
);

create table zarucnica(
sifra int not null primary key auto_increment,
narukvica int,
bojakose varchar(37) not null,
novcica decimal(15,9),
lipa decimal(15,8) not null,
indiferentno bit not null
);

create table neprijatelj(
sifra int not null primary key auto_increment,
majica varchar(32),
haljina varchar(43) not null,
lipa decimal(16,8),
modelnaocala varchar(49) not null,
kuna decimal(12,6) not null,
jmbag char(11),
cura int
);

create table brat(
sifra int not null primary key auto_increment,
suknja varchar(47),
ogrlica int not null,
asocijalno bit not null,
neprijatelj int not null
);

create table prijatelj(
sifra int not null primary key auto_increment,
modelnaocala varchar(37),
treciputa datetime not null,
ekstroventno bit,
prviputa datetime,
svekar int not null
);

create table svekar(
sifra int not null primary key auto_increment,
stilfrizura varchar(48),
ogrlica int not null,
asocijalno bit not null
);

#vanjski ključevi
alter table cura add foreign key(decko) references decko(sifra);
alter table decko_zarucnica add foreign key(decko) references decko(sifra);
alter table decko_zarucnica add foreign key(zarucnica) references zarucnica(sifra);
alter table neprijatelj add foreign key(cura) references cura(sifra);
alter table brat add foreign key(neprijatelj) references neprijatelj(sifra);
alter table prijatelj add foreign key(svekar) references svekar(sifra);


#1 U tablice neprijatelj, cura i decko_zarucnica unesite po 3 retka.
select * from zarucnica;
select * from neprijatelj;
select * from cura;
select * from decko_zarucnica;
select * from decko;

insert into decko(indiferentno,vesta,asocijalno) values
(1,'Bazga',1),
(1,'Plava',1),
(1,'Crvena',1);

insert into cura (haljina,drugiputa,suknja,narukvica,introvertno,majica,decko) values
('Crvena','2020-05-11','Crna','1',1,'Žuta',1),
('Crna','2020-06-11','Crna','2',1,'Crna',1),
('Žuta','2020-07-11','Crvena','3',1,'Crvena',1);

insert into neprijatelj(majica,haljina,lipa,modelnaocala,kuna,jmbag,cura) values
('Crvena','Crvena','45','Police','200','45231478678',(1)),
('Crna','Crna','30','Police','300','31478678452',(2)),
('Plava','Plava','20','RayBan','500','78678452314',(3));

insert into zarucnica(narukvica,bojakose,novcica,lipa,indiferentno) values
('1','Smeđa','1000','50',1),
('2','Crna','2000','30',1),
('3','Plava','3000','400',1);



insert into decko_zarucnica (decko,zarucnica) values
((1),(1)),
((2),(2)),
((3),(3));

#2 U tablici prijatelj postavite svim zapisima kolonu treciputa na vrijednost 30. travnja 2020.
describe prijatelj;
select * from prijatelj;
select * from svekar;
insert into svekar(stilfrizura,ogrlica,asocijalno) values
('Afro','2',1);

insert into prijatelj (treciputa,svekar) values
('2020-07-30',(1)),
('2020-08-30',(1));
update prijatelj set treciputa='2020-04-30';

#3 U tablici brat obrišite sve zapise čija je vrijednost kolone ogrlica različito od 14.
select * from brat;
insert into brat(suknja,ogrlica,asocijalno,neprijatelj) values
('Crvena','14',1,(1)),
('Crna','2',1,(2)),
('Plava','1',1,(3));
delete from brat where ogrlica!=14;

#4 Izlistajte suknja iz tablice cura uz uvjet da vrijednost kolone drugiputa nepoznate.
select suknja from cura where drugiputa is null;

#5 Prikažite novcica iz tablice zarucnica, neprijatelj iz tablice brat te haljina iz tablice neprijatelj uz uvjet da su vrijednosti kolone drugiputa iz tablice cura poznate te da su vrijednosti kolone vesta iz tablice decko sadrže niz znakova ba. Podatke posložite po haljina iz tablice neprijatelj silazno.
select z.novcica,b.neprijatelj,n.haljina
from brat b inner join neprijatelj n on b.neprijatelj=n.sifra
inner join cura c on n.cura=c.sifra
inner join decko d on c.decko=d.sifra 
inner join decko_zarucnica e on e.decko=d.sifra 
inner join zarucnica z on e.zarucnica=z.sifra
where c.drugiputa is not null and d.vesta like '%ba%'
order by n.haljina desc;

select * from brat;
select * from cura;
select * from decko;

#6 Prikažite kolone haljina i lipa iz tablice neprijatelj čiji se primarni ključ ne nalaze u tablici brat.
select n.haljina,n.lipa
from neprijatelj n left join brat a on n.sifra=a.neprijatelj
where a.neprijatelj is null;

