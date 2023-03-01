create database library;
use   library;
drop table categoria
CREATE TABLE categoria
(
    category_id integer auto_increment primary key not null,
    bane varchar(100)not null
);

drop table publisher
create table publisher
(
    publisher_id integer auto_increment primary key not null,
    name varchar (100) not null
);
create table boocks
(
    boock_id       integer auto_increment primary key not null,
    title          varchar(100) not null,
    isbn           varchar(100) not null,
    published_date date         not null,
    descripcion    varchar(100) not null,
    category_id    integer      not null,
    publisher_id   integer      not null,
    foreign key (publisher_id) references publisher (publisher_id),
    foreign key (category_id) references categoria (category_id)
);