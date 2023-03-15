create database informacion;
use informacion;
create table  empresa (
    id_empr integer auto_increment primary key not null ,
    nombre varchar(100) not null


);
create table  area (
    id_area integer auto_increment primary key not null ,
    nomre varchar(100) not null


);

create table  empleado (
    id_emp integer auto_increment primary key not null ,
    nombre varchar(100) not null,
    id_empr integer not null,
    id_area integer not null,

    foreign key (id_area) references area (id_area),
    foreign key (id_empr) references  empresa(id_empr)

);

insert into empresa (nombre) values ("pil");
insert into empresa (nombre) values ("unifranz");

insert into area (nomre)
values ("sistema");
insert into area (nomre)
values ("maquinas");
insert into area (nomre)
values ("director");



insert into empleado(nombre, id_empr, id_area) values ("juan jose",1,2);
insert into empleado(nombre, id_empr, id_area) values ("luis",2,1);
insert into empleado(nombre, id_empr, id_area) values ("juan",2,3);
insert into empleado(nombre, id_empr, id_area) values ("Maria",1,1);

select * from area;
select*from empresa;
select *from empleado;



select empleado.nombre, empresa.nombre ,area.nomre  from empleado, empresa, area where empleado.id_emp = id_emp;