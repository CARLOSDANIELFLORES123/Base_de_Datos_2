create database hito_2_v2;
use hito_2_v2;

create table usuarios
(

    id_usuario integer auto_increment primary key,
    nombres    varchar(50)  not null,
    apellidos  varchar(50)  not null,
    edad       integer      not null,
    email      varchar(100) not null

);


insert into usuarios(nombres, apellidos, edad, email)
values ('nombre1', 'apellidos1', 20, 'nombres1@gmail.com'),
       ('nombre2', 'apellidos2', 30, 'nombres2@gmail.com'),
       ('nombre3', 'apellidos3', 40, 'nombres3@gmail.com');

select *
from usuarios as usu;
create view moyores_a_30 as
select *
from usuarios as us
where edad > 30;

alter view moyores_a_30 as
    select usuarios.nombres,
           usuarios.apellidos,
           usuarios.edad,
           usuarios.email
                           from usuarios
                           where usuarios.edad > 30;

select *
from moyores_a_30 as m30;

alter view moyores_a_30 as select
concat(a.nombres,' ', a.apellidos) AS Fullname,
a.edad                         as edad_usuario,
a.email                        as email_usuario
from usuarios as a
where a.edad > 30;

create or replace moyores_a_30 as select
concat(a.nombres,' ', a.apellidos) AS Fullname,
a.edad                         as edad_usuario,
a.email                        as email_usuario
from usuarios as a
where a.edad > 30;

select *
from moyores_a_30 as m30 where m30.Fullname like '%3' ;

drop view moyores_a_30;