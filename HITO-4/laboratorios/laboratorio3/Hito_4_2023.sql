create database hito_4_2023;
use hito_4_2023;

CREATE OR REPLACE TABLE numeros
(
  numero BIGINT PRIMARY KEY NOT NULL,
  cuadrado BIGINT,
  cubo BIGINT,
  raiz_cuadrada REAL
);


INSERT INTO numeros (numero) VALUES (2);

SELECT * FROM numeros;

 # CREAR UN TRIGGER QUE REALIZE OPERACIONES Y LUEGO QUE SUME TODASD LOS RESULTADOS DE LAS COLUMANAS EN UNA SOLA SUMA TOTAL
TRUNCATE numeros;

alter table numeros
add sumaTodo Real;

CREATE or replace TRIGGER tr_completa_datos
    BEFORE INSERT
    ON numeros
    FOR EACH ROW
    BEGIN
        DECLARE valor_cuadrado BIGINT;
        DECLARE valor_cubo BIGINT;
        DECLARE valor_raiz REAL;
        DECLARE suma_total REAL;

        SET valor_cuadrado = POWER(NEW.numero, 2);
        SET valor_cubo = POWER(NEW.numero, 3);
        SET valor_raiz = SQRT(NEW.numero);
        set suma_total = valor_cuadrado + valor_cubo + valor_raiz + new.numero;

        SET NEW.cuadrado = valor_cuadrado;
        SET NEW.cubo = valor_cubo;
        SET NEW.raiz_cuadrada = valor_raiz;
        set new.sumaTodo = suma_total;
    END;


INSERT INTO numeros (numero) VALUES (2);
SELECT * FROM numeros;

# GENERANDO PASSWORDS: crear una tabla de nombre usuarios  con la columnas : id, nombres, apellisods
-- el campo passwords debe ser producto de la concatenacion entre el las primeras dos caracteres del nombreapellido y edad
CREATE OR REPLACE TABLE usuario
(
  id_usr int auto_increment PRIMARY KEY NOT NULL,
  nombres varchar (50) not null,
  apellidos varchar(50) not null,
  edad int not null ,
    correo varchar(50) not null,
    password varchar(50)

);

insert into usuario
( nombres, apellidos, edad, correo)
values ('Alfredo','Torres',24,'alfr@gmail.com');


CREATE or replace TRIGGER genrar_contraseña
    BEFORE INSERT
    ON usuario
    FOR EACH ROW
    BEGIN
        DECLARE contraseña text;


        SET contraseña = concat(substr(new.nombres,1,2),substr(new.apellidos,1,2),new.edad);
        SET NEW.password = contraseña;

    END;

insert into usuario
( nombres, apellidos, edad, correo)
values ('Alfredo','Torres',24,'alfr@gmail.com');

select * from usuario ;


#Laboratorio 2
drop trigger genrar_contraseña;

#Esta funcion nos permmite saber el ultimo id insertado en la base de datos
SELECT last_insert_id();

-- trigger con el uso de AFTER
-- CONCLUSION: No se puede modificar un registro desde un trigger cuando se esta insertando
CREATE or replace TRIGGER generar_contraseña_con_AFTER
    AFTER INSERT
    ON usuario
    FOR EACH ROW
    BEGIN
        UPDATE usuario SET password = CONCAT(
            SUBSTR(nombres,1,2),
            SUBSTR(apellidos,1,2),
            edad
            )
        WHERE id_usr = last_insert_id();
    END;

insert into usuario ( nombres, apellidos, edad, correo)
values ('Roberto','Flores',24,'Rob@gmail.com');

-- codigo no funcional
-- ----------------------------------------------------------------

drop table usuario;

CREATE OR REPLACE TABLE usuario
(
  id_usr int auto_increment PRIMARY KEY NOT NULL,
  nombres varchar (50) not null,
  apellidos varchar(50) not null,
  fecha_de_nacimiento date not null ,
  correo varchar(50) not null,
  password varchar(50)
);

CREATE OR REPLACE TRIGGER tr_calcula_pass_edad
    BEFORE INSERT
    ON usuario
    FOR EACH ROW
    BEGIN
       SET NEW.password = LOWER(CONCAT(
                SUBSTR(NEW.nombres,1,2),
                SUBSTR(NEW.apellidos,1,2),
                SUBSTR(NEW.correo,1,2)
           ));
      SET NEW.edad = TIMESTAMPDIFF (YEAR, NEW.fecha_de_nacimiento , CURDATE());
    END;

insert into usuario (nombres, apellidos, fecha_de_nacimiento, correo)
values ('carlos','flores','2001-08-01','car@gmail.com');

select * from usuario;

-- esta funcion me permite el formato de fecha predeterminado del gestor de la base de datos

select current_date;

-- crear un trigger para la tabla usuario sverificar si la tabla tine mas de 10 carateres

CREATE OR REPLACE TRIGGER tr_verificar_password_cantidad
    BEFORE INSERT
    ON usuario
    FOR EACH ROW
    BEGIN

        declare cantidad_de_password text default char_length(new.password);

        SET NEW.edad = TIMESTAMPDIFF (YEAR, NEW.fecha_de_nacimiento , CURDATE());


        if (cantidad_de_password <= 10) then

           SET NEW.password = LOWER(CONCAT(
                SUBSTR(NEW.nombres,-2),
                SUBSTR(NEW.apellidos,-2),
                SUBSTR(NEW.edad,-2)
           ));
        else
            SET NEW.password = NEW.password;
        end if;


    END;


insert into usuario (nombres, apellidos, fecha_de_nacimiento, correo, password)
values ('tomyy','Torn','2000-06-20','alb@gmail.com', '1283');

insert into usuario (nombres, apellidos, fecha_de_nacimiento, correo, password)
values ('harod','Torn','2000-06-20','alb@gmail.com', '12834358564543');

select * from usuario;

-- funcion para seber el dia actual, el nombre
select dayname(current_date);
-- -----------------------------------------------------
#ejercicio para bloquear al usuario si la base de datos esta en mantenimiento
CREATE OR REPLACE TRIGGER tr_usuarios_mantenimiento
    BEFORE INSERT
    ON usuario
    FOR EACH ROW
    BEGIN
        DECLARE dia_de_la_semana TEXT DEFAULT '';
        SET dia_de_la_semana = DAYNAME(CURRENT_DATE);

        IF (dia_de_la_semana = 'Wednesday') THEN
            SIGNAL SQLSTATE '45000'
            SET  MESSAGE_TEXT = 'Base de datos en MANTENIMIENTO';
        end if;

    END;
drop table usuario;
truncate  usuario;

insert into usuario (nombres, apellidos, fecha_de_nacimiento, correo, password)
values ('daniel','paucara','2001-08-01','dan@gmail.com', '1283');

select * from usuario;


-- ejercicio de bloquear acceso y dar acceso
alter table usuario
    add column nacionalidad varchar(50);
drop trigger tr_usuarios_nacionalidad
CREATE OR REPLACE TRIGGER tr_usuarios_nacionalidad
    BEFORE INSERT
    ON usuario
    FOR EACH ROW
    BEGIN

         declare nacio text default NEW.nacionalidad;
         /*
        IF (nejemploacio != 'Bolivia' or nacio != 'Argentina' or nacio != 'Paraguay'  ) THEN
            SIGNAL SQLSTATE '45000'
            SET  MESSAGE_TEXT = 'nacionalidad no disponible en este momento!!!';
        end if;
        */

        case nacio
            when nacio != 'Bolivia' then SIGNAL SQLSTATE '45000'
            SET  MESSAGE_TEXT = 'nacionalidad no disponible en este momento!!!';
            when nacio != 'Argentina' then SIGNAL SQLSTATE '45000'
            SET  MESSAGE_TEXT = 'nacionalidad no disponible en este momento!!!';
            when nacio != 'paraguay' then SIGNAL SQLSTATE '45000'
            SET  MESSAGE_TEXT = 'nacionalidad no disponible en este momento!!!';
        end case;
    END;

drop trigger tr_usuarios_mantenimiento;

insert into usuario (nombres,apellidos, fecha_de_nacimiento, correo, password,nacionalidad)
values ('daniel','paucara','2001-08-01','dan@gmail.com', '1283', 'Bolivia');

#LABORATORIO 3
# AUDITORIA DE BASE E DATOS


CREATE OR REPLACE TABLE usuarios_rrhh
(
  id_usr int auto_increment PRIMARY KEY NOT NULL,
  nombre_completo varchar (50) not null,
  fecha_de_nacimiento date not null ,
  correo varchar(50) not null,
  password varchar(50)
);
alter table usuarios_rrhh
    add column nacionalidad varchar(50);
#me permite obtener la fecha actual current_date
select current_date;

insert into usuarios_rrhh(id_usr, nombre_completo, c, correo, password)
values (123456,'Carlos Flores','2001-01-01','car@gmail.com','123456');
select * from usuarios_rrhh;
# select now() me permite obtener la fecha actual y la hora
select now();
# select user() me permite obtener el usuario logueado
select user();
# select @@HOSTNAME; me permite saber el hostaname el nombre de la pc
select @@HOSTNAME;

SHOW VARIABLES ;

CREATE TABLE audit_usuarios_rrhh
(
    fecha_mod TEXT NOT NULL ,
    usuario_log TEXT NOT NULL ,
    hostname TEXT NOT NULL ,
    accion TEXT NOT NULL ,

    id_usr TEXT NOT NULL,
    nombre_completo TEXT NOT NULL ,
    password TEXT NOT NULL
);
alter table audit_usuarios_rrhh
    add column nacionalidad varchar(50);

CREATE OR REPLACE TRIGGER tr_audit_usuarios_rrhh
    AFTER DELETE
    ON usuarios_rrhh
    FOR EACH ROW
    BEGIN
        DECLARE id_usuario TEXT ;
        DECLARE nombres TEXT;
        DECLARE usr_password TEXT;

        SET id_usuario = OLD.id_usr;
        SET nombres = OLD.nombre_completo;
        SET usr_password = OLD.password;

        INSERT INTO audit_usuarios_rrhh(
        fecha_mod, usuario_log, hostname, accion, id_usr, nombre_completo, password)
        SELECT now(), user(),@@HOSTNAME,'DELETE', id_usuario, nombres,usr_password;

    end;

insert into usuarios_rrhh(id_usr, nombre_completo, fecha_de_nacimiento, correo, password)
values (13323456,'Carlos2 Flores','2001-01-01','car@gmail.com','123456');

SELECT * FROM usuarios_rrhh;
SELECT * FROM audit_usuarios_rrhh;

DELETE FROM usuarios_rrhh WHERE id_usr = 123456
DELETE FROM usuarios_rrhh WHERE id_usr = 13323456


# CON INSERT
CREATE OR REPLACE TRIGGER tr2_audit_usuarios_rrhh
    AFTER INSERT
    ON usuarios_rrhh
    FOR EACH ROW
    BEGIN
        INSERT INTO audit_usuarios_rrhh(
        fecha_mod, usuario_log, hostname, accion, id_usr, nombre_completo, password)
        SELECT now(), user(),@@HOSTNAME,'INSERT', NEW.id_usr, NEW.nombre_completo,NEW.password;

    end;

insert into usuarios_rrhh(id_usr, nombre_completo, fecha_de_nacimiento, correo, password)
values (33434249,'Carlos2 Flores','2001-01-01','car@gmail.com','123456');

SELECT * FROM usuarios_rrhh;
SELECT * FROM audit_usuarios_rrhh;


CREATE OR REPLACE TABLE audit_usuarios_rrhh
(
    fecha_mod TEXT NOT NULL,
    usuario_log TEXT NOT NULL,
    hostname TEXT NOT NULL,
    accion TEXT NOT NULL,

 -- datos que deseamos recuperar de la tabla original

    antes_del_cambio text not null,
    despues_del_cambio text not null
);

TRUNCATE usuarios_rrhh;

CREATE OR REPLACE TRIGGER tr_audit_usuarios_rrhh
    before update
    ON usuarios_rrhh
    FOR EACH ROW
    BEGIN

        INSERT INTO audit_usuarios_rrhh(
            fecha_mod, usuario_log, hostname, accion,antes_del_cambio,despues_del_cambio)
            SELECT
            now(), user(), @@HOSTNAME, 'update', concat(OLD.id_usr,'-',old.nombre_completo,'-',OLD.fecha_de_nacimiento), concat(NEW.id_usr,'-',NEW.nombre_completo,'-',NEW.fecha_naC) ;
    END;

INSERT INTO usuarios_rrhh(id_usr, nombre_completo, fecha_de_nacimiento, correo, password)
        VALUES (1234567, 'Pepito','2001-02-02', 'pep@gmail.com','1234567');

SELECT * FROM usuarios_rrhh;
SELECT * FROM audit_usuarios_rrhh;

UPDATE usuarios_rrhh AS us
SET us.nombre_completo = 'Alfedo torres' where us.nombre_completo = 'Pepito';


#procedimientos alamacenados

CREATE OR REPLACE PROCEDURE inserta_datos(
    fecha TEXT,
    usuario  TEXT,
    hostname TEXT,
    accion  TEXT,
    antes  TEXT,
    depues  TEXT
)
    BEGIN
        INSERT INTO audit_usuarios_rrhh(fecha_mod, usuario_log, hostname, accion,antes_del_cambio,despues_del_cambio)
            VALUES (fecha, usuario,hostname, accion, antes, depues) ;
    END;


TRUNCATE TABLE audit_usuarios_rrhh;

CREATE OR REPLACE TRIGGER tr_audit_usuarios_rrhh
    after update
    ON usuarios_rrhh
    FOR EACH ROW
    BEGIN
        DECLARE antes TEXT DEFAULT '';
        DECLARE despues TEXT DEFAULT  '';
        set antes = concat(OLD.id_usr,' - ',old.nombre_completo,' - ',OLD.fecha_de_nacimiento);
        set despues = concat(NEW.id_usr,' - ',NEW.nombre_completo,' - ',NEW.fecha_de_nacimiento);
      # call sirve para llamar al procedimiento almacenado
        CALL inserta_datos(
            now(),
            user(),
            @@HOSTNAME,
            'UPDATE',
            antes,
            despues
            );
    END;
 select * from usuarios_rrhh;
select  * from audit_usuarios_rrhh;






