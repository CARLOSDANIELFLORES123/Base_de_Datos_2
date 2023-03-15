SHOW databases;
create database hitos_2;

use hitos_2;

create table estudiante(
    cod int primary key,
    nombre varchar( 20),
    apellido varchar( 20)

);

insert estudiante values ( 1, 'LUis', 'Alvarez');
insert estudiante values ( 2, 'Saul', 'Alvarez');

select * from estudiante;

drop table if exists estudiante;


create database universidad1;
use universidad1;

create table estudiante (
    id_est integer auto_increment primary key  not null,
    nombre varchar ( 100) not null,
    apellidos varchar ( 100) not null,
    edad integer not null,
    fono integer not null,
    email varchar ( 50) not null


);

describe estudiante;

insert into  estudiante ( nombre,apellidos,edad,fono,email) values
    ( 'Nombre1','Apellido1',10,11111,'user1@gmail.com');

    insert into  estudiante ( nombre,apellidos,edad,fono,email) values
    ( 'Nombre2','Apellido2',20,11111,'user2@gmail.com');

insert into  estudiante ( nombre,apellidos,edad,fono,email) values
    ( 'Nombre3','Apellido3',10,11111,'user3@gmail.com');


select last_insert_id();
select * from estudiante;


alter table estudiante add column  direccion varchar(200) default 'EL Alto';

alter table estudiante drop column direccion;

select * from estudiante;