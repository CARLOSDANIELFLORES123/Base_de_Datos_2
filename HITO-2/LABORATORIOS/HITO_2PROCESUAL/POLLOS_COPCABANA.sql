CREATE DATABASE POLLOS_COPA;
USE POLLOS_COPA;

CREATE TABLE cliente(
    id_cliente integer auto_increment primary key not null ,
    fullname varchar(30)not null,
    lastname varchar(30)not null ,
    edad integer not null ,
    domicilio varchar(50) not null
);
CREATE TABLE pedido(
    id_pedido integer auto_increment primary key not null ,
    articulo varchar(40)not null,
    costo integer not null,
    fecha datetime not null
);
CREATE TABLE detallr_pedido(
    id_detalle_pedido integer auto_increment primary key not null ,
    id_cliente integer not null ,
    id_pedido integer not null ,

    foreign key (id_cliente)references cliente(id_cliente),
    foreign key (id_pedido)references pedido(id_pedido)
);
insert into  cliente(fullname, lastname, edad, domicilio)
values ('Carlos Daniel','Flores Paucara',20,'El Alto-villa Bolivar D Calle Illimani'),
       ('Melanny','Boyan Quispe',21,'Achocalla-Yarihuaya-calle Duran');
insert into
pedido (articulo, costo, fecha)
values ('pollo broaster',18,22/05/2022),
       ('pollo Spiedo',20,31/03/2022);
insert into
detallr_pedido(id_cliente, id_pedido)
values (1,2),
       (2,1);

select c.fullname,c.lastname,c.domicilio,p.articulo,p.costo
from detallr_pedido dp
inner join cliente c on dp.id_cliente = c.id_cliente
inner join pedido p on dp.id_pedido = p.id_pedido
