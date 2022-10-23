create database practica3;
use practica3;
create table estudiantes
(
    id_est    int auto_increment primary key not null,
    nombres   varchar(50),
    apellidos varchar(50),
    edad      int(11),
    gestion   int(11),
    fono      int(11),
    email     varchar(100),
    direccion varchar(100),
    sexo      varchar(10)
);
create table materias
(
    id_mat     int auto_increment primary key not null,
    nombre_mat varchar(100),
    cod_mat    varchar(100)
);

create table inscripcion
(
    id_ins   int auto_increment primary key not null,
    semestre varchar(20),
    gestion  int(11),

    id_est   int                            not null,
    id_mat   int                            not null,

    foreign key (id_est) references estudiantes (id_est),
    foreign key (id_mat) references materias (id_mat)
);

INSERT INTO estudiantes (nombres, apellidos, edad, fono, email, direccion, sexo)
VALUES ('Miguel', 'Gonzales Veliz', 20, 2832115, 'miguel@gmail.com', 'Av. 6 de Agosto', 'masculino'),
       ('Sandra', 'Mavir Uria', 25, 2832116, 'sandra@gmail.com', 'Av. 6 de Agosto', 'femenino'),
       ('Joel', 'Adubiri Mondar', 30, 2832117, 'joel@gmail.com', 'Av. 6 de Agosto', 'masculino'),
       ('Andrea', 'Arias Ballesteros', 21, 2832118, 'andrea@gmail.com', 'Av. 6 de Agosto', 'femenino'),
       ('Santos', 'Montes Valenzuela', 24, 2832119, 'santos@gmail.com', 'Av. 6 de Agosto', 'masculino');

INSERT INTO materias (nombre_mat, cod_mat)
VALUES ('Introduccion a la Arquitectura', 'ARQ-101'),
       ('Urbanismo y Diseno', 'ARQ-102'),
       ('Dibujo y Pintura Arquitectonico', 'ARQ-103'),
       ('Matematica discreta', 'ARQ-104'),
       ('Fisica Basica', 'ARQ-105');

INSERT INTO inscripcion (semestre, gestion, id_est, id_mat)
values ('1er Semestre', 2018, 1, 1),
       ('2do Semestre', 2018, 1, 2),
       ('1er Semestre', 2019, 2, 4),
       ('2do Semestre', 2019, 2, 3),
       ('2do Semestre', 2020, 3, 3),
       ('3er Semestre', 2020, 3, 1),
       ('4to Semestre', 2021, 4, 4),
       ('5to Semestre', 2021, 5, 5);


#12.Crear una función que genere la serie Fibonacci.
#○ La función recibe un límite(number)
#○ La función debe de retornar una cadena.
#○ Ejemplo para n=7. OUTPUT: 0, 1, 1, 2, 3, 5, 8,
#○ Adjuntar el código SQL generado y una imagen de su correcto funcionamiento.

CREATE OR REPLACE FUNCTION fibonacci(limite INT)
RETURNS TEXT
DETERMINISTIC
BEGIN
    DECLARE fib1 INT DEFAULT 0;
    DECLARE fib2 INT DEFAULT 1;
    DECLARE fib3 INT DEFAULT 0;
    DECLARE str VARCHAR(255) DEFAULT '0,1,';

    IF limite = 1 THEN
        RETURN fib1;
    ELSEIF limite = 2 THEN
        RETURN CONCAT(fib1, fib2);
    ELSE
        WHILE limite > 2 DO
            SET fib3 = fib1 + fib2;
            SET fib1 = fib2;
            SET fib2 = fib3;
            SET limite = limite - 1;
            SET str = CONCAT(str, fib3,',');
        END WHILE;
        RETURN str;
    END IF;
END;

select fibonacci(7);



#13.Crear una variable global a nivel BASE DE DATOS.
#○ Crear una función cualquiera.
#○ La función debe retornar la variable global.
#○ Adjuntar el código SQL generado y una imagen de su correcto funcionamiento.

set @limit=7;  # set  @nombre de la variable   = asignacion valor(int o varchar)
CREATE OR REPLACE FUNCTION fibonacci1()
RETURNS text          #text nos permite adimitir numeros y textos
DETERMINISTIC
BEGIN
    DECLARE fib1 INT DEFAULT 0;
    DECLARE fib2 INT DEFAULT 1;
    DECLARE fib3 INT DEFAULT 0;
    DECLARE str VARCHAR(255) DEFAULT '0,1,';    # valor por defecto 0,1,

    IF @limit = 1 THEN
        RETURN fib1;
    ELSEIF @limit = 2 THEN
        RETURN CONCAT(fib1, fib2);
    ELSE
        WHILE @limit > 2 DO
            SET fib3 = fib1 + fib2;
            SET fib1 = fib2;
            SET fib2 = fib3;
            SET @limit = @limit - 1;
            SET str = CONCAT(str, fib3,','); #llama str
        END WHILE;
        RETURN str;
    END IF;
END;

select fibonacci1();

set @admin='JOEL';
set @admin='HEITAN';

# no olvidar de la s
# IF(CONDICON)  THEN  SET (CONDICION) ELSE (NO RECIBE CONDICION, no pongas THEN) END IF, NO OLVIDEN DE LA S
create OR REPLACE function verificarAdmin()
RETURNS text # AQUI NO OLVIDARSE S
begin
DECLARE RESPUESTA TEXT DEFAULT '';
if @admin = 'JOEL'then set respuesta= 'Usuario Admin';
else set respuesta='Usuario invitado';
end if;
RETURN RESPUESTA; #AQUI NO AFECTA QUE FALTA LA S
end;

SELECT verificarAdmin();

#14.Crear una función que no recibe parámetros (Utilizar WHILE, REPEAT o LOOP).
#○ Previamente deberá de crear una función que obtenga la edad mínima de los estudiantes
#La función no recibe ningún parámetro.
#La función debe de retornar un número.(LA EDAD MÍNIMA)

select min(est.edad)
from estudiantes as est;

create or replace function example2()
returns text
begin
    declare respuesta text;

    select min(est.edad) into respuesta
    from estudiantes as est;

    return respuesta;
end;

select example2();

#14.Crear una función que no recibe parámetros (Utilizar WHILE, REPEAT o LOOP).
#○ Previamente deberá de crear una función que obtenga la edad mínima de los estudiantes
#La función no recibe ningún parámetro.
#La función debe de retornar un número.(LA EDAD MÍNIMA)

#Si la edad mínima es PAR mostrar todos los pares empezando desde 0 a este
#ese valor de la edad mínima.
# Si la edad mínima es IMPAR mostrar descendentemente todos los impares
#hasta el valor 0.

create or replace function example2_1()
returns text
begin
    declare respuesta text default '';
    declare limite int;
    declare x int;


    select min(est.edad) into limite             # limite vale 20
    from estudiantes as est;

    # para saber si es par  variable%2=0
    if limite%2=0 then set x=2;
    while x<=limite do          # X es variable que tiene la funcion de contar
       set respuesta= concat(respuesta,x,',');
       set x=x+2;
end while;
    else
    set x=1;
    while x<=limite do
        set x=x+2;
        set respuesta= concat(respuesta,x,',');
        end while;
     end if;
    return respuesta;
end;
#WHILE (CONDICION)  DO  SET (CONDICION) SET (CONDICION)     END WHILE;

select example2_1();

#15.Crear una función que determina cuantas veces se repite las vocales.
# La función recibe una cadena y retorna un TEXT.
# Retornar todas las vocales ordenadas e indicando la cantidad de veces que
#se repite en la cadena.

create or replace function vowel_count(textoAIngresar varchar(50))
returns text
begin  # dentro de un concat que retornamos directo
    return  concat(
        #concatenamos longitud del textoAIngresar (-) y la longitud reemplazando dentro del textoAIngresar la palabra 'A' que divida la misma longitud para obtener un numero y asi sucsivamente
       concat (' a: ', (LENGTH(textoAIngresar) - LENGTH(REPLACE(textoAIngresar, 'a', '')))/LENGTH('a')) ,
       concat (' e: ', (LENGTH(textoAIngresar) - LENGTH(REPLACE(textoAIngresar, 'e', '')))/LENGTH('e')) ,
       concat (' i: ', (LENGTH(textoAIngresar) - LENGTH(REPLACE(textoAIngresar, 'i', '')))/LENGTH('i')) ,
       concat (' o: ', (LENGTH(textoAIngresar) - LENGTH(REPLACE(textoAIngresar, 'o', '')))/LENGTH('o')) ,
       concat (' u: ', (LENGTH(textoAIngresar) - LENGTH(REPLACE(textoAIngresar, 'u', '')))/LENGTH('u'))
     );
end;

select vowel_count('bendito sea diabloooo');

select vowel_count(est.apellidos), est.apellidos
from estudiantes as est;

#16.Crear una función que recibe un parámetro INTEGER.
# La función debe de retornar un texto(TEXT) como respuesta.
# El parámetro es un valor numérico credit_number.
# Si es mayor a 50000 es PLATINIUM.
#Si es mayor igual a 10000 y menor igual a 50000 es GOLD.
#○ Si es menor a 10000 es SILVER
#○ La función debe retornar indicando si ese cliente es PLATINUM, GOLD o
#SILVER en base al valor del credit_number.

create or replace function creditoNumber(credit_number int)
RETURNS text
begin
    declare respuesta text default '';          # Y = AND     O = OR
    case
        when credit_number>50000 then set respuesta='PLATINUM'; # Si es mayor a 50000 es PLATINIUM.
        when  credit_number>=10000 AND credit_number <= 50000  THEN SET respuesta='GOLD';      #Si es mayor igual a 10000 y menor igual a 50000 es GOLD.
        when credit_number<10000 then set respuesta='SILVER';                     #○ Si es menor a 10000 es SILVER
        else set respuesta='CASO DESCONOCIDO';  #CASO POR DEFECTO
    end case;
    return respuesta;
end;


#crear una funcion que reciba un parametro TEXT
#en donde este parametro debera de recibir una cadena cualquiera y retorna en text de respuesta
#concatenar N veces la misma cadena reduciendo en uno iteracion hasta llegar a una sola letra
#utiliza REPEAT y retornar la nueva cadena conacatena

create or replace function cadena(palabra text)
    returns text
    begin
        declare respuesta text default'';
        declare contador int default char_length(palabra);
        declare aux int default 1;
        declare aux2 int default char_length(palabra);

        repeat
            set respuesta = concat(respuesta,',', substring(palabra,aux,aux2));
            set contador = contador-1;
            set aux = aux + 1;
        until contador <=0 end repeat;
        return respuesta;
    end;

select cadena('DBAII');
















create or replace function sumar (a int,b int)
returns int

begin

    declare numero int default 0;
    set numero = a+b;

    return numero;
end;

SELECT sumar(5,5);



create or replace function CONCAT(A varchar(20),B varchar(20),C varchar (20))
returns text
begin
    declare nombres text default'';
    set nombres = concat(A, ' ' ,B, ' ' ,C);
    return nombres;
end;

select CONCAT('mi','nombre','es','joel');



create or replace function pop(nombre varchar(50),posicion int,longuitud int)
returns text
begin
    declare cadena text default'';
    set cadena = substring(nombre,posicion,longuitud);
    return cadena;
end;

select pop('XIMENA CONDORI MAR',1,6);





create or replace function igualar( a varchar(20),b varchar(20),c varchar (20))
returns text
    begin
        declare respuesta text default'';
        if strcmp (a,b) = 0 then set respuesta ='dos son de ellas son iguales';
        elseif strcmp (c,a) = 0 then set respuesta = 'dos son de ellas son iguales';
        elseif strcmp (c,b) = 0 then set respuesta = 'dos son de ellas son iguales';

        else
            set respuesta = 'tres de ellos son iguales';
            end if;
        return respuesta;
    end;

select igualar('perro','perro','gato');


create or replace function lenght(a varchar (20))
returns text
begin
    declare respuesta text default'';
    set respuesta = char_length(a);
    return respuesta;
end;

select lenght('joel');

create or replace function loc(subcadena varchar (20), cadena varchar(20))
returns text
begin
    declare respuesta text default 0;
    set respuesta = locate(subcadena,cadena);
    return respuesta;
end;

select loc('hola','mundo_hola');