create database  hito3_2023v2 ;
use hito3_2023v2;

set @usuario =  ' INVITADO ' ;
set @ubicacion =  ' El Alto ' ;
select @usuario;
select @ubicación;


create or replace function variable()
returns text
begin
    return @usuario;
end;

select variable();
show variables;


create or replace function validaUsuario ()
returns varchar ( 100 )
begin
    declare respuesta varchar ( 100 );
    if@Hito_3 =  ' ADMINISTRADOR ' then
      set respuesta = ' Usuario Admin ' ;
    else
        set respuesta =  ' Usuario invitado ' ;
    end if ;
return respuesta;
end;
select validaUsuario();


 create or replace function validaUsuario1 ()
returns varchar ( 100 )
begin
    declare respuesta varchar ( 100 );
   case @Hito_3
       when ' ADMIN ' then set respuesta = ' Usuario Admin ' ;
        else set respuesta = ' Usuario Invitado ' ;
    end case;

return respuesta;
end;

select validaUsuario1();



create or replace function   numerosNaturales (limite int )
returns text
begin
declare cont int  default 1;
declare respuesta text default  ' ' ;

    while cont <= limite do
        set respuesta = concat(respuesta,cont, ' , ' );
        set cont = cont + 1 ;
       end while ;

return respuesta;
end;


select numerosNaturales( 10 );

create function  numerosNaturales1 (limite int )
returns text
begin
declare cont int default 2 ;
declare respuesta text default ' ' ;

    while cont <= limite do
        set respuesta = concat(respuesta,cont, ' , ' );
        set cont = cont + 2 ;
       end while;

return respuesta;
end;

select numerosNaturales1( 10 );



create function  numeros1 (limite int )

returns text
begin
declare cont int default 1 ;
declare respuesta text default ' ' ;
declare imp int default 1 ;
declare par int default 2 ;
    while cont <= limite do
        if (cont % 2  !=  0 ) then
            set  respuesta = concat(respuesta,par, ' , ' );
            set   par = par + 2 ;
            else
            set respuesta = concat(respuesta,imp, ' , ' );
            set imp = imp + 2 ;
        end if;

        set cont = cont + 1 ;
       end while;

return respuesta;
end;

select numeros1( 8 );


create or replace function dowhile (x int )
    returns text
    begin

    declare str text default ' ' ;

    REPEAT
    set str = concat(str,x, ' , ' );
    set x = x - 1 ;
    until x <=  0 end repeat;
    return str;


    end;

select dowhile( 10 );

create or replace function dowhileletra (x int )
    returns text
    begin
declare str text default ' ' ;
declare a text default ' A ' ;
declare b text default ' B ' ;
    REPEAT

    if x% 2 = 0  then
    set str = concat(str,x, ' - ' ,a,a, ' - ' , ' , ' );
    else
    set str = concat(str,x, ' - ' ,b,b, ' - ' , ' , ' );
    end if;
    set x = x - 1 ;
    until x <=  0 end repeat ;
    return str;


end;
select dowhileletra( 10 );






 create or replace function manejoDeLoop_label (x int )
    returns text
    begin
    declare str text default ' ' ;
    dbail: LOOP
    IF x > 0 THEN
   LEAVE dbail; /* andate */
    END IF;
    set str = concat(str,x, ' , ' );
    set x = x + 1 ;
    iterate dbail; /* seguinomas */
    end loop;
    return str;
    end;
select manejoDeLoop_label( - 10 );


create or replace function  manejoDeLoop_labelletra (x int )
    returns text
    begin
    declare str text default ' ' ;
    dbail: loop
    if x > 0 then
    leave dbail; /* andate */
    end if;
    if (x% 2 = 0 ) then
        set str = concat(str,x, ' -AA- ' , ' , ' );

    else
        set str = concat(str,x, ' -BB- ' , ' , ' );

     end if;
    set x = x + 1 ;
    iterate dbail; /* seguinomas */
    end loop;
    return str;
    end;

    select manejoDeLoop_labelletra( - 10 );

create or replace function  estatusdelcliente (credit_namber integer )
    returns text
    begin
    declare str text default ' ' ;
    if credit_namber > 50000 then set   str =  ' PLATINO ' ;
    end if;
    if(credit_namber >= 10000  and credit_namber <= 50000 ) then set str =  ' GOLD ' ;
    end if;
    if (credit_namber < 10000 )then set str = ' SILVER ' ;
    end if;
    return str;
    end;


select estatusdelcliente( - 5 );
select estatusdelcliente( 20000 );
select estatusdelcliente( 50001 );


    # uso de charlength
    # cuanos caracteres tiene una palabra hola = 4

select char_length( ' BDAII ' ); # -> 5 palabras
select char_length( ' BDAII 2023 ' ); # -> 10 palabras
select char_length( ' BDAII 2023 ' ); # -> 12 palabras



create or replace function validaLegth_7 ( pasword text )
returns text
begin
    declare res text default ' ' ;
    if char_length (pasword) > 7 then
        set res =  ' APROBADO ' ;
    else
        set res =  ' FALLO ' ;
    end if ;
    return res;
end;


select validaLegth_7( ' 123456 ' );



# comparacion de cadenas
# si dos cadenas son iguales
# DBAII = DBAII ? verdadero
# DBAI = DBAI ? FALSO



select strcmp( ' DBAII ' , ' DBA2023 ' ); # regresa 1 o -1 porque es falso (no son iguales)
select strcmp( ' DBAII ' , ' DBAII ' ); # devuelve 0 porque es verdadero
select strcmp( ' dbaii ' , ' DBAII ' ); # no existe destino entre mayusculas y minusculas

create or replace function  determinaigualdad (cadena1 text ,cadena2 text )
returns text
begin
    declare res text default ' ' ;
    if strcmp(cadena1,cadena2) = 0 then
        set res =  ' son iguales ' ;
    else
        set res =  ' no son iguales ' ;
    end if ;
    return res;
end;

select determinaigualdad( ' BDAII ' , ' BDA2023 ' );
select determinaigualdad( ' BDAII ' , ' BDAII ' );



# en base a las dos funciones anteriores
# recibir dos cadenas en la fncion si las dos cadenas son ifuales y ademas el length es mayor a 10
# devolver el mensaje VALIDO caso contraio devolver no valido



create or replace function  determinaigualdadv1 (cadena1 text ,cadena2 text )
returns text
begin
    declare res text default ' ' ;
    if strcmp(cadena1,cadena2) = 0 and char_length(concat(cadena1,cadena2)) > 15 then
        set res =  ' es valido ' ;
    else
        set res =  ' no es valido ' ;
    end if ;
    return res;
end;

select determinaigualdadv1( ' DBAII-2023 ' , ' DBAII-2023 ' );




select substr( ' DBAII 2023 Unifranz ' , 7 ); # le cortamos de donde queramos siepre uno despues
select substr( ' Hola ' , 3 );

select substr( ' DBAII 2023 Unifranz ' , 7 , 4 ); # la priemra coma desde donde inicia el texto que no se cortará la segunda coma es cuantos espacios tiene la letra que no cortaremos

select substr( ' DBAII 2023 Unifranz ' , 7 , 4 );
select substr( ' DBAII 2023 Unifranz ' , - 9 );
select substr( ' DBAII 2023 Unifranz ' , - 13 , 4 ); # contar desde la derecha a la izquierda

select locate ( ' 2023 ' , ' Base de Datos II, gestion 2023 Unifranz 2023 ' , 28 ); # cuenta de donde incia la cade que bsucamos donde solo encuentra el primer dato

create or replace function  localizadordefunciones  (cadena1 text, cadena2 text)
    returns text
begin
    declare res text default ' ' ;
    DECLARE LOCATE int default locate(cadena2,cadena1);
    if(LOCATE() > 0 ) then
        set res = concat( ' Si exste: ' ,LOCATE());
    ELSE
        SET res =  ' no existe ' ;
    END IF;
        RETURN res;
END;

select locate( ' 13644437LP ' , ' Lp ' );


create or replace function numeros1 (limite int )

returns text
begin
declare cont int default 1 ;
declare respuesta text default ' ' ;
declare imp int default 1 ;
declare par int default 2 ;
    while cont <= limite do
        if (cont % 2  !=  0 ) then
            set   respuesta = concat(respuesta,par, ' , ' );
            set   par = par + 2 ;
            else
            set respuesta = concat(respuesta,imp, ' , ' );
            set imp = imp + 2 ;
        end if;
        set cont = cont + 1 ;
       end while ;
return respuesta;
end;

select numeros1( 8 );





create function numerosNaturales1 (limite int )

returns text
begin
declare cont int default 2 ;
declare respuesta text default ' ' ;

    while cont <= limite do
        set respuesta = concat(respuesta,cont, ' , ' );
        set cont = cont + 2 ;
       end while;

return respuesta;
end;

select numerosNaturales1( 10 );

create or replace function cadenanumero (cadena1 text , numero integer )

returns text
begin
    declare resp text default ' ' ;
    declare cont text default 0 ;
    while (cont < numero)do
        set resp = concat(resp,cadena1, ' , ' );
        set cont = cont + 1 ;
        end while;
    return resp;
end;

select cadenanumero( ' DBAII ' , 3 );

create or replace function CuentaCaracter(cadena varchar(25), letra char)
returns text
begin
    declare respuesta text default 'La letra no hay en la cadena';
    declare cont int default 1;
    declare nVeces int default 0 ;
    declare puntero char;
    IF locate(letra, cadena) > 0 then
       while cont <= char_length(cadena) do
         set puntero = substr(cadena,cont,1);
         if puntero = letra then
         set nVeces= nVeces + 1;
         end if;
         set cont = cont + 1;
       end while;
         set respuesta = CONCAT(' la letra ', letra ,' se repite ', nVeces);
    end if;
 return respuesta;
end;

select CuentaCaracter('hola mundo','o');


create or replace function CuentaCantidadDeVocales(cadena text)
returns text
begin
    declare puntero char;
    declare x int default 1;
    declare cont int default 0 ;
    while x <= char_length(cadena) do
    set puntero = substr(cadena ,x,1);
    if puntero ='a'or puntero = 'e'or puntero = 'i'or puntero = 'o'or puntero = 'u'or puntero then
        set cont = cont +1;

    end if;
    set x = x + 1;
    end while;
    return concat('cantidad de vocales: ', cont );
    end;
select CuentaCantidadDeVocales('dba ii 2023');


create or replace function CuentaPalabras(cadena TEXT)
returns text
begin
    declare respuesta text default 'La letra no hay en la cadena';
    declare cont int default 1;
    declare nVeces int default 0 ;
    declare puntero char;
    IF locate(cadena) > 0 then
       while cont <= char_length(cadena) do
         set puntero = substr(cadena,cont,1);
         if puntero = '-' then
         set nVeces = nVeces + 1;
         end if;
         set cont = cont + 1;
       end while;
         set respuesta = CONCAT(' la letra se repite ', nVeces);
    end if;
 return respuesta;
end;
select CuentaPalabras('carlos daniel flores paucara',4);

create or replace function Obtiene_Apellidos(nombres text)
returns text
begin
    declare posicion int default locate(',',nombres);
    return substr(nombres , posicion + 1);

end;

SELECT LOCATE(',','CARLOS DANIEL ');

create or replace function Quita_Letra_1en1( cadena1 varchar(50) )
returns text
begin
    declare resp text default ' ';
    declare puntero varchar(50);
    declare cont int default char_length ( cadena1 );
    repeat
        set puntero = substr( cadena1 , -cont , cont );
        set resp = concat( resp , puntero , ',' );
        set cont = cont-1;
    until cont = 0  end repeat;
    return resp;
end;

select Quita_Letra_1en1('CARLOSXDD');

create or replace function Apellidos(Parametros varchar (50))
returns text
begin
    declare resp text default ' ';
    return resp;
end;

Drop function Apellidos;

select Apellidos('carlos');

create or replace function CONCATENADOR(cad1 varchar(50),cad2 varchar(50),cad3 varchar(50),cad4 varchar(50))
returns text
begin
    declare resp text default '';
    set resp = concat(cad1,cad2,cad3,cad4);
    return resp;
end;

select CONCATENADOR(' CARLOS ',' DANIEL ',' FLORES ',' PAUCARA ');

create or replace function utilizando_Substring(cad1 varchar(50))
returns text
begin
    declare resp text default ',';
    set resp = substr(cad1,1,6);
    return resp;

end;

select utilizando_Substring('XIMENA CONDORI MAR');

create or replace function Utilizando_Strcmp(cad1 varchar(50),cad2 varchar(50),cad3 varchar(50))
returns text
begin
    declare resp  text default  ' ';
    if(strcmp(cad1,cad2)= 0 or strcmp(cad1,cad3)= 0 or strcmp(cad2,cad3) = 0) then
        set resp = 'Si hay son iguales dos cadenas';
    else
        set resp = 'No hay igualdad entre las cadenas';
    end if;
    return resp;
end;
select Utilizando_Strcmp('CARLOS','CARLO','carlos');

create or replace function Utilizando_Locate_Charlegth(Buscar varchar(50),cad1 varchar(50))
returns text
begin
    declare resp  text default  ' , ';
    declare cont  text default  0;
    declare pos  text default  0;
    set pos = locate(Buscar,cad1);
    if(pos>0) then
        set cont = char_length(Buscar);
        set resp = concat('La palabra que buscas se encuentra en la posicion : ',pos,' y es de ', cont, ' palabras');
    end if;

    return resp;
end;
select Utilizando_Locate_Charlegth('Flores','Carlos Daniel Flores Paucara');

