SHOW DATABASES;

CREATE DATABASE hito_2;

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

SELECT * FROM estudiantes
