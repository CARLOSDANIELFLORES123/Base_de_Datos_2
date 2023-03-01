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