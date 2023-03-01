create database trabajo;
use trabajo;

create table empresa
(
    cod_empresa integer primary key not null,
    nombre varchar (100)not null

);
create table area
(
    id_director varchar(100)primary key not null
    recepcion varchar(100)NOT NULL,
    secretaria varchar(100)NOT NULL
);
create table empleado
(
    C.I INTEGER PRIMARY KEY NOT NULL
    nombre
)