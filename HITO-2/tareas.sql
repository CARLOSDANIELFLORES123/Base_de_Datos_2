SHOW DATABASES;

CREATE DATABASE hito_2;
use hito_2
create database ejemplo;

drop database ejemplo;


create table  nombres
(
    id_nombres INT PRIMARY KEY NOT NULL,
    nombres VARCHAR (100) NOT NULL,
    apellidos VARCHAR (100) NOT NULL
);
INSERT INTO nombres (id_nombres, nombres,apellidos)
VALUES (1,'carlos','flores');
INSERT INTO nombres (id_nombres,nombres,apellidos)
VALUES (2,'romario','tola');

create database universidad;
use universidad;
create table estudiantes
(
    id_est INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
    nombres VARCHAR(100) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    edad INTEGER NOT NULL,
    fono INTEGER NOT NULL,
    email VARCHAR(100) NOT NULL
);

DESCRIBE estudiantes;
insert into  estudiantes(nombres, apellidos, edad, fono, email)
values ('Nombre1','Apellidos1',10,11111,'user1@gmail.com'),
       ('Nombre2','Apellidos2',20,111114,'user2@gmail.com'),
       ('Nombre3','Apellidos13',100,112111,'user3@gmail.com');

SELECT * FROM estudiantes;

ALTER TABLE estudiantes
ADD COLUMN direccion VARCHAR(100)
DEFAULT 'EL ALTO';

ALTER TABLE estudiantes
ADD COLUMN fax VARCHAR(10),
ADD COLUMN genero VARCHAR(10);

SELECT *
FROM estudiantes as est
WHERE est.nombres = 'Nombre3';

SELECT est.nombres ,est.apellidos,est.edad
FROM estudiantes AS est
WHERE est.edad > 18;

SELECT est.*
FROM estudiantes AS est where est.id_est mod 2 = 1;

create database estudiante;
use estudiante;
create table estudiante
(
    id_est INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
    nombres VARCHAR(100) NOT NULL,
    apellidos VARCHAR(100)NOT NULL ,
    edad INTEGER NOT NULL ,
    fono INTEGER NOT NULL ,
    email VARCHAR(100) NOT NULL

);
CREATE TABLE materias
(
   id_mat int auto_increment primary key not null,
   nombre_mat varchar(100)not null,
   cod_mat varchar(100)not null
);

CREATE TABLE inscripcion
(
    id_ins INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
    id_est INTEGER NOT NULL,
    id_mat INTEGER NOT NULL,
    FOREIGN KEY (id_est) REFERENCES estudiante(id_est),
    FOREIGN KEY (id_mat) REFERENCES materias(id_mat)
);



create database library;
use   library;
drop table categoria
CREATE TABLE categoria
(
    category_id integer auto_increment primary key not null,
    bane varchar(100)not null
);

drop table publisher
create table publisher
(
    publisher_id integer auto_increment primary key not null,
    name varchar (100) not null
);
create table boocks
(
    boock_id       integer auto_increment primary key not null,
    title          varchar(100) not null,
    isbn           varchar(100) not null,
    published_date date         not null,
    descripcion    varchar(100) not null,
    category_id    integer      not null,
    publisher_id   integer      not null,
    foreign key (publisher_id) references publisher (publisher_id),
    foreign key (category_id) references categoria (category_id)
);



