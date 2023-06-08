create database DEFENSA_HITO4;
use DEFENSA_HITO4;

create or replace table Departamento
(
    id_dep int primary key  not null ,
    nombre varchar(100)
);

create or replace table Provincia
(
    id_prov int primary key  not null ,
    nombre varchar(100),
    id_dep int, foreign key (id_dep) references Departamento (id_dep)
);

create or replace table Proyecto
(
    id_proy int primary key NOT NULL,
    nombre_Proy varchar(100),
    tipo_Proy varchar(100)
);

create or replace table Detalle_proyecto
(
    id_dp int primary key  NOT NULL,
    id_per int , foreign key (id_per) references  Persona (id_per),
    id_proy int , foreign key (id_proy) references  Proyecto (id_proy)
);

select * from Detalle_proyecto;
drop table persona;
drop table detalle_proyecto;
drop table proyecto;
create or replace table Persona
(
    id_per int PRIMARY KEY NOT NULL,
    nombre varchar (100),
    apellidos varchar(100),
    fecha_nac date,
    edad int,
    email varchar(100),
    id_dep int , foreign key (id_dep) references Departamento (id_dep),
    id_prov int , foreign key (id_prov) references  Provincia (id_prov),
    sexo char(1)
);


insert into Departamento(nombre)
values ('Oruro'),('Cochabamba');

insert into Provincia(nombre)
values ('colquiri'),('sipe sipe');

insert into  Proyecto(nombre_Proy, tipo_Proy)
values ('peninsula','tecnologico');

insert into Detalle_proyecto(id_dp,id_per,id_proy)
values (1,1,1),(2,2,2);

insert into Persona(nombre, apellidos, fecha_nac, edad, email, sexo)
values ('JUAN','JIMENEZ','2000-02-18',22,'juajimenez@gmail.com','M'),
       ('Luz','Boyan','2002-02-05',21,'luzboy@gmail.com','F');
DROP TABLE  audit_proyectos;




create table audit_proyectos(
    nombre_proy_anterior varchar (30),
    nombre_proy_posterior varchar (30),
    tipo_proy_anterior varchar (60),
    tipo_proy_posterior varchar (50),
    operation varchar (50),
    userId varchar (50),
    hostname varchar (50)
);

create or replace trigger audit_update
    before  update  on Proyecto
    for each row
    begin
        declare nombre_proy_anterior text default '';
        declare nombre_proy_posterior text default '';
        declare tipo_proy_anterior text default '';
        declare tipo_proy_posterior text default '';

        set nombre_proy_posterior = OLD.nombre_Proy;
        set nombre_proy_anterior = NEW.nombre_Proy;
        set tipo_proy_posterior = OLD.tipo_Proy;
        set tipo_proy_anterior = NEW.tipo_proy;
        insert into
            audit_proyectos(nombre_proy_anterior, nombre_proy_posterior, tipo_proy_anterior, tipo_proy_posterior, operation, userId, hostname)
                select 'agua y riego','tecnologia','tecnologico',' clasico', 'manual','carlos','jefe';
    end;

select * from audit_proyectos;


create or replace trigger audit_insert
    after  insert  on Proyecto
    for each row
    begin
        declare nombre_proy_anterior text default '';
        declare nombre_proy_posterior text default '';
        declare tipo_proy_anterior text default '';
        declare tipo_proy_posterior text default '';

        set nombre_proy_posterior = OLD.nombre_Proy;
        set nombre_proy_anterior = NEW.nombre_Proy;
        set tipo_proy_posterior = OLD.tipo_Proy;
        set tipo_proy_anterior = NEW.tipo_proy;
        insert into
            audit_proyectos(nombre_proy_anterior, nombre_proy_posterior, tipo_proy_anterior, tipo_proy_posterior, operation, userId, hostname)
                select 'agua y riego','tecnologia','tecnologico',' clasico', 'manual','carlos','jefe';
    end;


create or replace trigger audit_delete
    after  delete  on Proyecto
    for each row
    begin
        declare nombre_proy_anterior text default '';
        declare nombre_proy_posterior text default '';
        declare tipo_proy_anterior text default '';
        declare tipo_proy_posterior text default '';

        set nombre_proy_posterior = OLD.nombre_Proy;
        set nombre_proy_anterior = NEW.nombre_Proy;
        set tipo_proy_posterior = OLD.tipo_Proy;
        set tipo_proy_anterior = NEW.tipo_proy;
        insert into
            audit_proyectos(nombre_proy_anterior, nombre_proy_posterior, tipo_proy_anterior, tipo_proy_posterior, operation, userId, hostname)
                select now(),user(),@@HOSTNAME,'DELETE',

    end;



create or replace view reporte_proyectos
as select concat(per.nombre, ',', per.apellidos) as
    fullname,
       concat(p.nombre_proy,',', p.tipo_proy) as
    desc_proyecto,d.nombre as Departamento
        from persona as per inner join Departamento D on per.id_dep = D.id_dep
        inner join detalle_proyecto dp on per.id_per = dp.id_per
        inner join proyecto p on dp.id_proy = p.id_proy;

        case
        when  Departamento.nombre = 'LA PAZ' then 'LP'
        when Departamento.nombre = 'COCHABAMBA' then 'CBBA'
        when Departamento.nombre = 'EL ALTO' then 'EAT'

        end;


create or replace function diccionario(dia_nombre varchar(25))
returns  varchar  as
    begin
        declare dia_traducido varchar ;
        if dia_nombre = 'wednesday' then
            set dia_traducido = 'Miecoles';
            else
            set dia_traducido =dia_nombre;
        end if;
        return dia_traducido;
    end;

select dia_traducido('Wednesday');









