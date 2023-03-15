create database Libreria;
use Libreria;

create table categories
(
    category_id integer auto_increment primary key not null ,
    name varchar(100)
);

create table publishers
(
    publisher_id integer auto_increment primary key not null ,
    name varchar (100)
);

create table books
(
    book_id integer auto_increment primary key not null ,
    title varchar(20) not null ,
    isbn varchar (30) not null ,
    published_date date not null ,
    description varchar(100)not null ,
    category_id integer,
    publisher_id integer,
    foreign key (category_id) references categories(category_id),
    foreign key (publisher_id) references publishers(publisher_id)

);