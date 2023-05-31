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