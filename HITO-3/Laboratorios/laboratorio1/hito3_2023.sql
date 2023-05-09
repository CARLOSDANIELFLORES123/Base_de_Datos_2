create database hito3_2023;
use hito3_2023;
set @usuario = 'ADMIN';
set @locacion = 'EL ALTO';
set @usuario2 = 'GUEST';
set @usuario3 = 'usuario invitado';
set @HITO_3 = 'ADMIN';
select @usuario;
select @locacion;
select @usuario2;
select @usuario3;
select @HITO_3;
create or replace function variable()
returns text
begin
    return @usuario;
end;

select variable();

show variables ;

create function valida_usuario()
returns varchar(50)
begin
    declare respuesta varchar(50);
    if @HITO_3 = 'ADMIN'THEN
        SET respuesta = 'usuario ADMIN';
        else
        set respuesta = 'Usuario Invitado';
    end if;
    return respuesta;
end;

select valida_usuario();


CREATE OR REPLACE FUNCTION valida_usuario()
RETURNS VARCHAR(50)
BEGIN
    DECLARE respuesta VARCHAR(50);
    CASE @HITO_3
        WHEN 'ADMIN'THEN SET respuesta = 'usuario ADMIN';
        ELSE SET respuesta = 'Usuario Invitado';
    END CASE;
    RETURN respuesta;
END;

SELECT valida_usuario();
#generar los orimeros 10 numeros naturales

CREATE OR REPLACE FUNCTION numeros_naturales(limite int)
RETURNS TEXT
BEGIN
    DECLARE cont INT DEFAULT 1;
    DECLARE respuesta TEXT DEFAULT ' ';
    WHILE cont <= limite do
    SET respuesta = CONCAT(respuesta,cont,',');
    SET cont = cont + 1;
    END WHILE;
RETURN respuesta;

END;

select numeros_naturales(10);

CREATE  FUNCTION pares_impares(limite integer)
RETURNS TEXT
BEGIN
    DECLARE pares INT DEFAULT 2;
    DECLARE impares INT DEFAULT 1;
    DECLARE cont INT DEFAULT 1;
    DECLARE respuesta TEXT DEFAULT ' ';
    WHILE cont <= limite do
        if cont % 2 = 1 then
    SET respuesta = CONCAT(respuesta,pares,',');
    SET pares = pares + 2;
    ELSE
    SET respuesta = CONCAT(respuesta, impares,',');
    SET impares = impares +2;
    END IF;
        SET cont = cont + 1;
    END WHILE;
RETURN respuesta;
END;

select pares_impares(10);


/*MAJEJO DE REPEAT */


CREATE OR REPLACE FUNCTION manejo_de_reapeat(
x int
)
RETURNS TEXT
BEGIN DECLARE str TEXT DEFAULT ''; -- str = 1

    REPEAT
        SET str = CONCAT(str,x ,',');
        SET x = x - 1 ;
    until x <= 0  end repeat;
   RETURN str;
end;

select manejo_de_reapeat(10);


CREATE OR REPLACE FUNCTION manejo_de_reapeat_v2(x int)
RETURNS TEXT
BEGIN DECLARE str TEXT DEFAULT ''; -- str = 1
    REPEAT
        IF x%2 = 0 then
        SET str = CONCAT(str,x ,' -AA- ');
        ELSE
        SET str = CONCAT(str,x ,' -BB- ');
        END IF ;
        SET x = x - 1 ;
    UNTIL x <= 0  END REPEAT;
   RETURN str;
END;

select manejo_de_reapeat_v2(10);

CREATE OR REPLACE FUNCTION manejo_de_loop(x int)
RETURNS TEXT
BEGIN
    DECLARE str TEXT DEFAULT '';
    dbaii: LOOP
        IF x > 0 THEN
            LEAVE dbaii;
        end if;
        SET str =   CONCAT(str,x,',');
        SET x = x + 1;
        ITERATE dbaii;
    end loop;
    RETURN str;
end;

SELECT manejo_de_loop(-10);



CREATE OR REPLACE FUNCTION manejo_de_loop_v2(x int)
RETURNS TEXT
BEGIN
    DECLARE str TEXT DEFAULT '';
    dbaii: LOOP
        if x > 0 THEN
            LEAVE dbaii;
        end if;
        if x % 2 = 0 then
        SET str =   CONCAT(str,x,'-aa-');
        end if;
        SET x = x + 1;
        SET str =   CONCAT(str,x,'-bb-');
        ITERATE dbaii;
    end loop;
    RETURN str;
end;

select manejo_de_loop_v2(-10);


CREATE OR REPLACE FUNCTION cliente_estado(credit_number integer)
returns text
BEGIN
    DECLARE str TEXT DEFAULT ',';

        if credit_number > 10000 THEN SET str  = 'PLATINIUM';
        end if;
        if credit_number >= 10000
               AND credit_number <=  50000 THEN SET str  = 'GOLD';
        end if;
        if credit_number < 10000 THEN SET str  = 'SILVER';
        end if;

    RETURN str;
end;

SELECT cliente_estado(2000);
/*SELECT  char_length('dbaii);*/
CREATE FUNCTION  valida_length_7(pasword TEXT)
returns text
begin
    DECLARE resp TEXT DEFAULT '';
    IF char_length(pasword) > 7 then
    SET resp = 'PASED';
    ELSE
        SET resp = 'FAILED';

    end if;
    return resp;
end;

SELECT valida_length_7(123456);

select strcmp('DBAII2023','dbaii2023');
#determinar si dos cadenas so iguales .
#sis son iguales retornra la respuesta cadenad iguales .
#si son distintos retornar la respuesta cadenas distintas .

CREATE FUNCTION  uso_de_strcmp(cadena1 TEXT, cadena2 TEXT)
returns text
begin
    DECLARE resp TEXT DEFAULT '';
    IF strcmp(cadena1,cadena2) = 0 then
    SET resp = 'CADENAS IGUALES';
    ELSE
        SET resp = 'CADENAS DISTINTAS';

    end if;
    return resp;
end;

CREATE FUNCTION  uso_de_substr(cadena1 TEXT, cadena2 TEXT)
returns text
begin
    DECLARE resp TEXT DEFAULT '';
    IF substr(cadena1,cadena2) = 0 then
    SET resp = 'CADENAS IGUALES';
    ELSE
        SET resp = 'CADENAS DISTINTAS';

    end if;
    return resp;
end;
#DE IZQUIERDA A DERECHA
 SELECT uso_de_substr('DBAII 2023 Unifranz',7);
 SELECT uso_de_substr('DBAII 2023 Unifranz',7, 4);
 SELECT uso_de_substr('HOLA',1,1);
# DEASDE LA DERECHA
 SELECT uso_de_substr('DBAII 2023 Unifranz',-8);
 SELECT uso_de_substr('DBAII 2023 Unifranz',-13,4);
#MANEJO BASE DE DATOS 2,GESTION 2023 UNIFRANZ
#A partir desde el 27
SELECT LOCATE('2023','Base de Datos II, gestion 2023 Unifranz 2023', 30);


CREATE or replace FUNCTION  busca_ext_en_un_CI(PAR1 TEXT, PAR2 TEXT)
returns text
begin
    DECLARE resp TEXT DEFAULT '';
    DECLARE busca_cadena INT DEFAULT LOCATE(PAR1,PAR2);
    IF busca_cadena > 0 then
    SET resp = CONCAT('si existe : ',busca_cadena);
    ELSE
        SET resp = 'No existe';

    end if;
    return resp;
end;
SELECT busca_ext_en_un_CI(63060578,'lp');



CREATE  FUNCTION numeros_naturales_v2(limite integer)
RETURNS TEXT
BEGIN
    DECLARE cont INT DEFAULT 0;
    DECLARE respuesta TEXT DEFAULT ' ';
    WHILE cont <= limite do
    SET respuesta = CONCAT(respuesta,cont,',');
    SET cont = cont +2;
    END WHILE;
RETURN respuesta;
END;

select numeros_naturales(10);

CREATE or replace FUNCTION concatenaNveces(PAR1 TEXT, limite INT)
returns text
begin
    DECLARE resp TEXT DEFAULT'';

    while limite >=0 do
        set resp = concat(resp,PAR1,'-');
        set limite = limite - 1;
        end while;
    return resp;
end;

select concatenaNveces('DBAII',3)
#DADA UNA CADENA CUANTAS VOCALES HAY

























































































































































































