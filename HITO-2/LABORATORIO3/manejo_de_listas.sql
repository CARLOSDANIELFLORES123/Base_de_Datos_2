CREATE DATABASE  hito_2_v2;
use hito_2_v2;

create table usuarios
(
    id_usuario INTEGER AUTO_INCREMENT PRIMARY KEY,
    nombres    VARCHAR(200) NOT NULL,
    apellidos  VARCHAR(100) NOT NULL,
    edad       INTEGER      NOT NULL,
    email      VARCHAR(100) NOT NULL

);

insert into  usuarios (nombres,apellidos, edad, email)
values ('nombres1','apellidos1',20, 'npmbres1@gmail.com'),
       ('nombres2','apellidos2',12, 'npmbres2@gmail.com'),
       ('nombres3','apellidos3',50, 'npmbres3@gmail.com');

select *
from usuarios;

create view mayores_36 as
select *
from usuarios
where edad > 36;

alter view mayores_36 as
    select  concat (us.nombres,'',us.apellidos) as fullname,
           us.edad as edad_usuario,
           us.email as email_usuario
    from usuarios as us
where us.edad > 36;


select* from mayores_36 as m36
where m36.fullname like '%3';

select ma.fullname,
       ma.edad_usuario,
       ma.email_usuario
from mayores_36 as ma
where ma.fullname like '%3';

// para crear o reemplazar'create or replace'
// para eliminar vista 'drop view'


