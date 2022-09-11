create database function_aggregation;
use function_aggregation;

CREATE TABLE estudiantes
(
 id_est INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
 nombres VARCHAR(50),
 apellidos VARCHAR(50),
 edad INTEGER,
 gestion INTEGER,
 fono INTEGER,
 email VARCHAR(100),
 direccion VARCHAR(100),
 sexo VARCHAR(10)
);

select est.*
    from estudiantes as est;

INSERT INTO estudiantes (nombres, apellidos, edad, fono, email, direccion, sexo)
  VALUES ('Miguel' ,'Gonzales Veliz', 20, 2832115, 'miguel@gmail.com', 'Av. 6 de Agosto', 'masculino')
,('Sandra' ,'Mavir Uria', 25, 2832116, 'sandra@gmail.com', 'Av. 6 de Agosto', 'femenino')
, ('Joel' ,'Adubiri Mondar', 30, 2832117, 'joel@gmail.com', 'Av. 6 de Agosto', 'masculino')
,('Andrea' ,'Arias Ballesteros', 21, 2832118, 'andrea@gmail.com', 'Av. 6 de Agosto', 'femenino')
, ('Santos' ,'Montes Valenzuela', 24, 2832119, 'santos@gmail.com', 'Av. 6 de Agosto', 'masculino');

#crear la consulrta
# que modifique
# y que asigne a todos el valor 2022
# parea cambiar un registro........------gestion
update estudiantes
set gestion= 2022
where id_est > 0 ;

CREATE TABLE materias
(
  id_mat INTEGER AUTO_INCREMENT PRIMARY KEY  NOT NULL,
  nombre_mat VARCHAR(100),
  cod_mat VARCHAR(100)
);
CREATE TABLE inscripcion
(
  id_ins INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
  id_est INT NOT NULL,

  id_mat INT NOT NULL,
  semestre VARCHAR(20),
  gestion INTEGER,
  FOREIGN KEY (id_est) REFERENCES estudiantes (id_est),
  FOREIGN KEY (id_mat) REFERENCES materias (id_mat)
);
INSERT INTO materias (nombre_mat, cod_mat) VALUES
('Introduccion a la Arquitectura','ARQ-101'),
('Urbanismo y Diseno','ARQ-102'),
('Dibujo y Pintura Arquitectonico','ARQ-103'),
('Matematica discreta','ARQ-104'),
('Fisica Basica','ARQ-105');
INSERT INTO inscripcion (id_est, id_mat, semestre, gestion) VALUES
(1, 1, '1er Semestre', 2015),
(1, 2, '2do Semestre', 2015),
(2, 4, '1er Semestre', 2016),
(2, 3, '2do Semestre', 2016);
INSERT INTO inscripcion (id_est, id_mat, semestre, gestion) VALUES
(3, 3, '2do Semestre', 2017),
(3, 1, '3er Semestre', 2017),
(4, 4, '4to Semestre', 2017),
(5, 5, '5to Semestre', 2017);

#
#mostrar los nombres y apellidos de los estudiantes inscritos en la materia
#ARQ-104, adicionalmente mostrar el nombre el nombre de la materia.

select est.nombres, est.apellidos,m.nombre_mat
    from estudiantes as est
inner join inscripcion i on est.id_est = i.id_est
inner join materias m on i.id_mat = m.id_mat
where cod_mat= 'ARQ-104';

select e.nombres, e.apellidos, m.nombre_mat
    from inscripcion as ins
inner join estudiantes e on ins.id_est = e.id_est
inner join materias m on ins.id_mat = m.id_mat
where m.cod_mat = 'ARQ-104';

select count(est.id_est) as 'cantidad de estudiantes'
from estudiantes as est;

select AVG(est.edad) as 'es el promedio de las edades'
from estudiantes as est;

select MAX(est.edad)
    from estudiantes as est;

select min(est.edad)
from estudiantes as est;
#determinar la maxima edad de los estudiantes cuyo genero sea masculino

select MAX(est.edad)
    from estudiantes as est
    where sexo =  'masculino' and edad>20;
#nos vamos a la pregunta 15....programacion -----crear una funcion
#MANEJO DE FUNCIONES
#CREAR una funcion que devuelva el maximo valos en la tabal estudiantes


create function get_max_edad()
    returns integer
    begin
       return 10;
        end;

select get_max_edad();

create or replace function get_max_edad()
returns varchar(20)
begin
    return 'kevin oscar ';
    end;
select get_max_edad();

create or replace function get_max_edad()
returns integer
begin
    return (
    select MAX(est.edad)
    from estudiantes as est
           );
    end;

select get_max_edad()as max_edad;
## 16 min
create or replace function get_min_edad()
returns integer
begin
    return (
  select min(est.edad)
from estudiantes as est
           );
    end;
select get_min_edad()as min_edad;
## 17 AVG
create or replace function get_prom_edad()
returns integer
begin
    return (
    select AVG(est.edad)
    from estudiantes as est
           );
    end;

select get_prom_edad()as prom_edad;
## 18 max edad masculino
create or replace function get_maxedadmasculino_edad()
returns integer
begin
    return (
    select MAX(est.edad)
    from estudiantes as est
    where sexo =  'masculino');
    end;

select get_maxedadmasculino_edad()as max_edad_masculino;
#####
create or replace function id_max()
returns integer
begin
    return (
    select MAX(est.id_est)
    from estudiantes as est
   );
    end;
select id_est,nombres,apellidos
from estudiantes as est
where est.id_est=id_max();

#nuestra funcion puede ir en la consulta.