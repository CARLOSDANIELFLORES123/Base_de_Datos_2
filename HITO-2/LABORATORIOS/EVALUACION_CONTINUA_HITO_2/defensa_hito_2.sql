create database defensa_hito_2;
use defensa_hito_2;

CREATE TABLE autor
(
    id_autor    INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
    name        VARCHAR(100),
    nacionality VARCHAR(50)
);

CREATE TABLE book
(
    id_book   INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
    codigo    VARCHAR(25)                        NOT NULL,
    isbn      VARCHAR(50),
    title     VARCHAR(100),
    editorial VARCHAR(50),
    pages     INTEGER,
    id_autor  INTEGER,
    FOREIGN KEY (id_autor) REFERENCES autor (id_autor)
);

CREATE TABLE category
(
    id_cat  INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
    type    VARCHAR(50),
    id_book INTEGER,
    FOREIGN KEY (id_book) REFERENCES book (id_book)
);
CREATE TABLE users
(
    id_user  INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
    ci       VARCHAR(15)                        NOT NULL,
    fullname VARCHAR(100),
    lastname VARCHAR(100),
    address  VARCHAR(150),
    phone    INTEGER
);
CREATE TABLE prestamos
(
    id_prestamo    INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
    id_book        INTEGER,
    id_user        INTEGER,
    fec_prestamo   DATE,
    fec_devolucion DATE,
    FOREIGN KEY (id_book) REFERENCES book (id_book),
    FOREIGN KEY (id_user) REFERENCES users (id_user)
);

INSERT INTO autor (name, nacionality)
VALUES ('autor_name_1', 'Bolivia'),
       ('autor_name_2', 'Argentina'),
       ('autor_name_3', 'Mexico'),
       ('autor_name_4', 'Paraguay');


INSERT INTO book (codigo, isbn, title, editorial, pages, id_autor)
VALUES ('codigo_book_1', 'isbn_1', 'title_book_1', 'NOVA', 30, 1),
       ('codigo_book_2', 'isbn_2', 'title_book_2', 'NOVA II', 25, 1),
       ('codigo_book_3', 'isbn_3', 'title_book_3', 'NUEVA SENDA', 55, 2),
       ('codigo_book_4', 'isbn_4', 'title_book_4', 'IBRANI', 100, 3),
       ('codigo_book_5', 'isbn_5', 'title_book_5', 'IBRANI', 200, 4),
       ('codigo_book_6', 'isbn_6', 'title_book_6', 'IBRANI', 85, 4);

INSERT INTO category (type, id_book)
VALUES ('HISTORIA', 1),
       ('HISTORIA', 2),
       ('COMEDIA', 3),
       ('MANGA', 4),
       ('MANGA', 5),
       ('MANGA', 6);

INSERT INTO users (ci, fullname, lastname, address, phone)
VALUES ('111 cbba', 'user_1', 'lastanme_1', 'address_1', 111),
       ('222 cbba', 'user_2', 'lastanme_2', 'address_2', 222),
       ('333 cbba', 'user_3', 'lastanme_3', 'address_3', 333),
       ('444 lp', 'user_4', 'lastanme_4', 'address_4', 444),
       ('555 lp', 'user_5', 'lastanme_5', 'address_5', 555),
       ('666 sc', 'user_6', 'lastanme_6', 'address_6', 666),
       ('777 sc', 'user_7', 'lastanme_7', 'address_7', 777),
       ('888 or', 'user_8', 'lastanme_8', 'address_8', 888);

INSERT INTO prestamos (id_book, id_user, fec_prestamo, fec_devolucion)
VALUES (1, 1, '2017-10-20', '2017-10-25'),
       (2, 2, '2017-11-20', '2017-11-22'),
       (3, 3, '2018-10-22', '2018-10-27'),
       (4, 3, '2018-11-15', '2017-11-20'),
       (5, 4, '2018-12-20', '2018-12-25'),
       (6, 5, '2019-10-16', '2019-10-18');

create or replace view Libros_pestados as
select concat(us.fullname,'-',us.lastname) as Nombre_Completo, us.ci as C_User, b.title as LiBRO_PRESTADO, c.type as CATEGORA
from users us
join prestamos p on us.id_user = p.id_user
join book b on b.id_book = p.id_book
join category c on b.id_book = c.id_book where c.type = 'COMEDIA' or c.type = 'MANGA';

select  * from Libros_pestados;

create or replace view Libros_pestados as
select concat(us.fullname,'-',us.lastname) as Nombre_Completo, us.ci as C_User, b.title as LiBRO_PRESTADO, c.type as CATEGORA
from users us
join prestamos p on us.id_user = p.id_user
join book b on b.id_book = p.id_book
join category c on b.id_book = c.id_book where c.type = 'COMEDIA' and c.type = 'MANGA';

create or replace function ContarPrestados( editorialBOOk varchar(100), pageBOOk varchar(90))
returns int
begin
    declare res int;
select  count(*) as CATEGORA INTO res
from users us
join prestamos p on us.id_user = p.id_user
join book b on b.id_book = p.id_book
where b.editorial = editorialBOOk and b.pages >pageBOOk;
    return res;




end;



select ContarPrestados('IBRANI',90);





/*creacion del comprobande de par o impar */
create or replace FUNCTION identificador(paginas int)
    returns varchar(100)
    begin
        declare resp varchar(100) ;
        case
            /* aca vemos si el dato de entrada es par o impar*/
        when paginas  % 2 = 0 then set resp=concat('PAR: ', paginas);
        else  set resp=concat('IMPAR: ', paginas);
        end case;
        return resp;
    end;

/* creamos lña funcion que concatenara lso datos*/
create or replace FUNCTION concatenador(editorial varchar(100), categoria varchar(100))
    returns varchar(100)
    begin
        declare resp varchar(100) ;
        /*Solo concatenamos los datos de entrada*/
        set resp = concat('EDTORIAL: ',editorial, ',', 'CATEGORIA: ',categoria);
        return resp;
    end;


select concatenador(b.editorial,c.type) as DESCRIPTION, identificador(b.pages) as PAGINA
from users us
join prestamos p on us.id_user = p.id_user
join book b on b.id_book = p.id_book
join category c on b.id_book = c.id_book where c.type = 'MANGA' and b.editorial = 'IBRANI';



CREATE OR REPLACE FUNCTION USUARIPSGETION2017_2018()
RETURNS int
BEGIN
   DECLARE RESP int;
   select count(*) into RESP from prestamos p
    where  fec_prestamo like '%2018%' or fec_prestamo like '%2017%' ;
    return RESP;
end;

select USUARIPSGETION2017_2018();



