create database diagnostico;
use diagnostico;
create table estudent
(
    id_estudiante int primary key not null,
    nombre        varchar(20),
    apellidos     varchar(20),
    edad          int
);

insert into estudent (id_estudiante, nombre, apellidos, edad)
values (1, 'joel', 'condori', 21);
insert into estudent (id_estudiante, nombre, apellidos, edad)
values (2, 'maria', 'condori', 21);

select *
from (estudent);

create database universidad;
use universidad;

create table estudiantes
(
    id_est    int auto_increment primary key not null,
    nombres   varchar(100),
    apellidos varchar(100),
    edad      int,
    fono      int,
    email     varchar(50)
);

INSERT INTO estudiantes (nombres, apellidos, edad, fono, email)
VALUES ('nombre1', 'apellidos1', 12, 123456, 'nombre1@gmail.com');

INSERT INTO estudiantes (nombres, apellidos, edad, fono, email)
VALUES ('nombre2', 'apellidos2', 15, 123456, 'nombre2@gmail.com');

INSERT INTO estudiantes
    (nombres, apellidos, edad, fono, email)
VALUES ('nombre3', 'apellidos3', 19, 123456, 'nombre3@gmail.com');

SELECT est.*
from estudiantes AS est;
# sirve para ver cual es el ultimo ID insertado
SELECT last_insert_id();
# agregando un nuevo campo a la tabla estudiantes
alter table estudiantes
    ADD COLUMN DIRECCION varchar(100);
#para agregar un valor por defecto usamos DEFAULT y el valor
alter table estudiantes
    add column fax    varchar(10) default 'fax-123',
    add column genero varchar(10);

alter table estudiantes
    drop column genero;

select est.id_est,nombres,apellidos,edad
from estudiantes as est
where est.edad > 18;

select est.nombres, est.edad, est.apellidos
from estudiantes as est
where est.id_est % 2 = 0;



CREATE TABLE estudiantes
(
  id_est INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
  nombres VARCHAR(100),
  apellidos VARCHAR(100),
  edad INTEGER,
  fono INTEGER,
  email VARCHAR(50)
);
CREATE TABLE materias
(
 id_mat INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
 nombre_mat VARCHAR(100),
 cod_mat VARCHAR(100)
);
CREATE TABLE inscripcion
(
  id_ins INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
  id_est INT NOT NULL,
  id_mat INT NOT NULL,
  FOREIGN KEY (id_est) REFERENCES estudiantes (id_est),
  FOREIGN KEY (id_mat) REFERENCES materias (id_mat)
);





create database libreria;
    use libreria;

create table categories
(
    category_id integer auto_increment primary key not null,
    name varchar (20)
);

create table publishers
(
    publishers_id int auto_increment primary key not null,
    name varchar(20)
);

create table books
(
    book_id int auto_increment primary key not null,
    title varchar (20),
    isbn varchar (20),
    publisher_date date,
    description varchar (20),
    category_id int,
    publisher_id int,


    foreign key (category_id)references categories(category_id),
    foreign key (publisher_id)references publishers(publishers_id)
);



