SHOW databases;
create database hito_23;

use hito_2;

create table estudiante
(
    cod      int primary key,
    nombre   varchar(20),
    apellido varchar(20)

);

insert estudiante
values (1, 'LUis', 'Alvarez');
insert estudiante
values (2, 'Saul', 'Alvarez');

select *
from estudiante;

drop table if exists estudiante;


create database universidad;
use universidad;

create table estudiante
(
    id_est    integer auto_increment primary key not null,
    nombre    varchar(100)                       not null,
    apellidos varchar(100)                       not null,
    edad      integer                            not null,
    fono      integer                            not null,
    email     varchar(50)                        not null


);

describe estudiante
    insert into  estudiante ( nombre,apellidos,edad,fono,email) values
    ( 'Nombre1','Apellido1',10,11111,'user1@gmail.com');

insert into estudiante (nombre, apellidos, edad, fono, email)
values ('Nombre2', 'Apellido2', 20, 11111, 'user2@gmail.com')

insert into estudiante (nombre, apellidos, edad, fono, email)
values ('Nombre3', 'Apellido3', 10, 11111, 'user3@gmail.com')


select last_insert_id()
select *
from estudiante


alter table estudiante
    add column direccion varchar(200) default 'EL Alto'

alter table estudiante
    drop column direccion

select *
from estudiante


/*  para agregar campos extras */
alter table estudiante
    add column fax  varchar(200),
    add column sexo varchar(200)

alter table estudiante
    drop column fax

select *
from estudiante

select *
from estudiante
where estudiante.nombre = 'nombre4'


/* muestra los detalles de las tablas*/


select est.nombre, est.apellidos, est.edad
from estudiante as est
where est.edad > 18;
describe  estudiante;




    select * from estudiante as est where est.id_est mod 2 !=0 ;



drop table estudiante;

create table estudaintes(
  id_est    integer auto_increment primary key   not null,
    nombre    varchar(100)                       not null,
    apellidos varchar(100)                       not null,
    edad      integer                            not null,
    fono      integer                            not null,
    email     varchar(100)                        not null
);

create table materias(
    id_mat int auto_increment primary key not null,
    nombre_mat varchar(100)  not null,
    cod_mat  varchar(100)  not null

);


create table inscripcion (
    id_ins int auto_increment primary key not null,
    id_mat int not null,
     id_est integer not null,

     foreign key (id_mat)references materias(id_mat),
     foreign key (id_est)references estudaintes(id_est)

) ;

create database library;
use library;

create table categories(
    category_id integer auto_increment primary key not null,
    name varchar(100) not null


);

create table publishers(
    publisher_id integer auto_increment primary key  not null,
    name varchar(100) not null


);

create table books(
  book_id integer auto_increment primary key  not null,
  title varchar(100) not null,
  isbn varchar(100) not null ,
  published_date date not null,
  description varchar(100) not null,
      publisher_id integer not null,
        category_id integer not null,

        foreign key (publisher_id) references publishers (publisher_id),
         foreign key (category_id) references categories (category_id)

);
create tabl





create table  empleado (
    id_emp integer auto_increment primary key not null ,
    id_empr


);
