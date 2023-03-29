CREATE DATABASE tareaHito2;
USE tareaHito2;
CREATE TABLE estudiantes(
    id_est integer auto_increment primary key not null ,
    nombres varchar(30)not null,
    apellidos varchar(30)not null ,
    edad integer not null ,
    gestion integer not null,
    fono integer not null ,
    email varchar(50) not null ,
    direccion varchar(50) not null ,
    sexo varchar(50)
);
CREATE TABLE materias(
    id_mat integer auto_increment primary key not null ,
    nombre_mat varchar(40)not null,
    cod_mat varchar(50)not null

);
CREATE TABLE inscripcion(
    id_ins integer auto_increment primary key not null ,
    semestre varchar(50) not null ,
    gestion integer not null ,
    id_est integer not null ,
    id_mat integer not null ,

    foreign key (id_est)references estudiantes(id_est),
    foreign key (id_mat)references materias(id_mat)
);
INSERT INTO estudiantes (nombres, apellidos, edad,gestion, fono, email, direccion, sexo)
VALUES ('Miguel', 'Gonzales Veliz', 20,2023, 2832115,
'miguel@gmail.com', 'Av. 6 de Agosto', 'masculino'),
('Sandra', 'Mavir Uria', 25,2022, 2832116, 'sandra@gmail.com',
'Av. 6 de Agosto', 'femenino'),
('Joel', 'Adubiri Mondar', 30,2020, 2832117, 'joel@gmail.com',
'Av. 6 de Agosto', 'masculino'),
('Andrea', 'Arias Ballesteros', 21,2021, 2832118,
'andrea@gmail.com', 'Av. 6 de Agosto', 'femenino'),
('Santos', 'Montes Valenzuela', 24,2020, 2832119,
'santos@gmail.com', 'Av. 6 de Agosto', 'masculino');

INSERT INTO materias (nombre_mat, cod_mat)
VALUES ('Introduccion a la Arquitectura', 'ARQ-101'),
('Urbanismo y Diseno', 'ARQ-102'),
('Dibujo y Pintura Arquitectonico', 'ARQ-103'),
('Matematica discreta', 'ARQ-104'),
('Fisica Basica', 'ARQ-105');

INSERT INTO inscripcion (id_est, id_mat, semestre, gestion)
VALUES (1, 1, '1er Semestre', 2018),
(1, 2, '2do Semestre', 2018),
(2, 4, '1er Semestre', 2019),
(2, 3, '2do Semestre', 2019),
(3, 3, '2do Semestre', 2020),
(3, 1, '3er Semestre', 2020),
(4, 4, '4to Semestre', 2021),
(5, 5, '5to Semestre', 2021);

create or replace function comparaMaterias(comp varchar(100),entr varchar(50))
returns bool
begin
    declare resp bool default false;
      if comp= entr then
          set resp = true;
          else
          set resp = false;
      end if;
    return resp;
end;

select est.id_est,est.nombres,est.apellidos,mat.nombre_mat,est.sexo,est.edad
from inscripcion ins
inner join estudiantes est on est.id_est = ins.id_est
inner join materias mat on ins.id_mat = mat.id_mat
where comparaMaterias(mat.cod_mat,'ARQ-104');


select est.nombres,est.apellidos,mat.nombre_mat
from inscripcion ins
inner join estudiantes est on est.id_est = ins.id_est
inner join materias mat on ins.id_mat = mat.id_mat
where comparaMaterias(mat.cod_mat,'ARQ-105');

create or replace function calculopromedio(genero varchar(100),cod_materia varchar(50))
returns integer
begin
    return (select avg(est.edad)
    from estudiantes est
        inner join inscripcion i on est.id_est = i.id_est
        inner join materias m  on m.id_mat = i.id_mat
        where est.sexo =genero and m.cod_mat = cod_materia);
end;

select calculopromedio('femenino ','ARQ_104')AS calculo_promedio_edad_mujeres;
select calculopromedio('masculino','ARQ_104')AS calculo_promedio_edad_hombres;



create or replace function nombresdeestudiantes(nombre varchar(100),apellido varchar(50),edad integer )
returns varchar(100)
begin
    return (select concat ('(',est.nombres,'),(',est.apellidos,')(',est.edad,')') as si
    from estudiantes est where est.nombres = nombre and est.apellidos = apellido and est.edad = edad);
end;
select nombresdeestudiantes(est.nombres,est.apellidos,est.edad) from estudiantes est ;

create or replace view ARQUITECTURA_DIA_LIBRE as
select
concat(est.nombres,'-',est.apellidos) as FULLNAME,
est.edad as EDAD,
ins.gestion as GESTION,
(case
when ins.gestion = 2021 then 'LIBRE'
else 'NO LIBRE'
end

)as DIA_LIBRE
from estudiantes est
inner join inscripcion ins on ins.id_est = est.id_est;

select *from ARQUITECTURA_DIA_LIBRE;

create table carreras(
id_car int auto_increment primary key not null,
carreras varchar (60),
id_est int not null,
foreign key (id_est)references estudiantes (id_est)
);

insert into carreras(carreras, id_est) VALUES  ('Arquitectura',1),('Arquitectura',2),('Arquitectura',3),
('Matematico',4),('Ingeniero en Sistemas',5);

create or replace view paralelo_DBA_1 as
    select nombresdeestudiantes(e.nombres,e.apellidos,e.edad)
        as DATOS_DEL_ESTUDIANTE,i.semestre,m.nombre_mat,car.carreras
from carreras car
inner join estudiantes e on e.id_est = car.id_est
inner join inscripcion i on i.id_est = e.id_est
inner join materias m on m.id_mat = i.id_mat
where e.id_est = 2 or e.id_est = 4;

select* from paralelo_DBA_1;
