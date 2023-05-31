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



