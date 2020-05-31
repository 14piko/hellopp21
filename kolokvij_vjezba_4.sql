#c:\xampp\mysql\bin\mysql -uedunova -pedunova --default_character_set=utf8 < c:\pp21\kolokvij_vjezba_4.sql

drop database if exists kolokvij_vjezba_4;
create database kolokvij_vjezba_4;
use kolokvij_vjezba_4;

create table punac(
sifra int not null primary key auto_increment,
treciputa datetime,
majica varchar(46),
jmbag char(11) not null,
novcica decimal(18,7) not null,
maraka decimal(12,6) not null,
ostavljen int not null
);

create table ostavljen(
sifra int not null primary key auto_increment,
modelnaocala varchar(43),
introvertno bit,
kuna decimal(14,10)
);

create table zena(
sifra int not null primary key auto_increment,
suknja varchar(39) not null,
lipa decimal(18,7),
prstena int not null
);

create table zena_mladic(
sifra int not null primary key auto_increment,
zena int not null,
mladic int not null
);

create table mladic(
sifra int not null primary key auto_increment,
kuna decimal(15,9),
lipa decimal(18,5),
nausnica int,
stilfrizura varchar(49),
vesta varchar(34) not null
);

create table snasa(
sifra int not null primary key auto_increment,
introvertno bit,
treciputa datetime,
haljina varchar(44) not null,
zena int not null
);

create table becar(
sifra int not null primary key auto_increment,
novcica decimal(14,8),
kratkamajica varchar(48) not null,
bojaociju varchar(36) not null,
snasa int not null
);

create table prijatelj(
sifra int not null primary key auto_increment,
eura decimal(16,9),
prstena int not null,
gustoca decimal(16,5),
jmbag char(11) not null,
suknja varchar(47) not null,
becar int not null
);


alter table punac add foreign key (ostavljen) references ostavljen(sifra);
alter table zena_mladic add foreign key (zena) references zena(sifra);
alter table zena_mladic add foreign key (mladic) references mladic(sifra);
alter table snasa add foreign key (zena) references zena(sifra);
alter table becar add foreign key (snasa) references snasa(sifra);
alter table prijatelj add foreign key (becar) references becar(sifra);


#1. U tablice becar, snasa i zena_mladic unesite po 3 retka. (7)

select * from zena;
select * from mladic;
select * from becar;
select * from snasa;
select * from zena_mladic;

insert into zena(suknja,lipa,prstena) values
('Crvena','50','4'),
('Plava','75','2'),
('Crna','60','5');

insert into mladic(kuna,lipa,nausnica,stilfrizura,vesta) values
('200','50','3','Lona','Crvena'),
('100','50','2','Bekemica','Crvena'),
('300','70','1','Ćelav','Plava');

insert into snasa(introvertno,treciputa,haljina,zena) values
(1,'2020-04-11','Plava',1),
(1,'2020-04-15','Crvena',2),
(1,'2020-04-20','Crna',3);

insert into becar(novcica,kratkamajica,bojaociju,snasa) values
('200','Plava','Smeđa',1),
('250','Crvena','Zelena',2),
('300','Crna','Plava',3);

insert into zena_mladic(zena,mladic) values
(1,1),
(2,2),
(3,3);

#2. U tablici punac postavite svim zapisima kolonu majica na vrijednost Osijek.
select * from punac;
select * from ostavljen;

insert into ostavljen(modelnaocala,introvertno,kuna) values
('Police',1,'200');

insert into punac(treciputa,majica,jmbag,novcica,maraka,ostavljen) values
('2020-05-11','Crvena','45789632144','200','500',1);

update punac set majica='Osijek';

#3. U tablici prijatelj obrišite sve zapise čija je vrijednost kolone prstena veće od 17.
select * from prijatelj;
insert into prijatelj(eura,prstena,gustoca,jmbag,suknja,becar) values
('200','18','5','4578965213','Crvena',1),
('250','2','3','4789652133','Plava',2),
('300','3','6','8965213457','Crna',3);

delete from prijatelj where prstena>17;

#4. Izlistajte haljina iz tablice snasa uz uvjet da vrijednost kolone treciputa nepoznate.
select * from snasa;
select haljina from snasa where treciputa is unknown;

#5. Prikažite nausnica iz tablice mladic, jmbag iz tablice prijatelj te kratkamajica iz tablice becar uz uvjet da su vrijednosti kolone treciputa iz tablice snasa poznate te da su vrijednosti kolone lipa iz tablice zena različite od 29. Podatke posložite po kratkamajica iz tablice becar silazno.
select m.nausnica,p.jmbag,b.kratkamajica
from mladic m inner join zena_mladic c on m.sifra=c.zena
inner join zena z on c.zena=z.sifra 
inner join snasa s on s.zena=z.sifra
inner join becar b on b.snasa=s.sifra
inner join prijatelj p on p.becar=b.sifra
where s.treciputa is not null and z.lipa!=29
order by b.kratkamajica desc;

#6. Prikažite kolone lipa i prstena iz tablice zena čiji se primarni ključ ne nalaze u tablici zena_mladic.
select z.lipa,z.prstena
from zena z left join zena_mladic c on z.sifra=c.zena
where c.zena is null;
