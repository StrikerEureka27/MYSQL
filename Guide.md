## Modos de conexión a MYSQL 

- Entorno GUI para administrar las diferentes bases de datos. 
- Por medio de la terminal. 
- Por medio de un entorno WEB.

Conexión a MYSQL en Windows

```mysql
mysql -u root -p 
```

> Para instalar el comando mysql de forma global debemos de agregar la ruta de la carpeta bin a las variables de entorno del sistema operativo. 

Conexión a MYSQL en Linux  	 	

```mysql
mysql -u root -p 
```

## Sentencias DDL 

Lenguaje de definición de datos, definido por las instrucciones  que manejan la estructura de la base de datos, mantener, configurar y producir. 

Visualizar las diferente bases de datos de nuestro servidor. 

```mysql
SHOW DATABASES;
```

Crear una base de datos. 

```mysql
CREATE DATABASES prueba;
```

Eliminar una base de datos;

```mysql
DROP DATABASES prueba;
```

### CRUD básico 

Creación de una tabla

```mysql
CREATE TABLE cursoSQL.Persona (
ID INT, 
NOMBRE VARCHAR(20),
APELLIDO VARCHAR(20),
EDAD INT
)
```

Agregar un campo a una tabla

```mysql
ALTER TABLE Persona ADD OCUPACION VARCHAR(20);
```

Para agregar múltiples campos a nuestra base de datos

```mysql
ALTER TABLE Persona ADD ESTADO VARCHAR(20), ADD CIUDAD VARCHAR(30);
```

Para poder ver la estructura de una tabla en MYSQL 

```mysql
DESCRIBE Persona; || DESC Persona;
```

Editar el nombre campo ya existente

```mysql
ALTER TABLE Persona CHANGE OCUPACION DIRECCION VARCHAR(22),
```

Editar el tipo de dato de un campo ya existente 

```mysql
ALTER TABLE Persona MODIFY DIRECCION VARCHAR(100);
```

Eliminar un campo existente

```mysql
ALTER TABLE Persona DROP DIRECCION;
```

Para mostrar las tablas actuales de una base de datos

```mysql
USE Persona;
SHOW TABLES;
```

### Manejo de NULL y NOT NULL

```mysql
CREATE TABLE Valores (ID INT);
ALTER TABLE Valor ADD NOMBRE VARCHAR(22) NOT NULL;
```

### Uso de comentarios

```mysql
/*
Codigo Realizado por Pablo Daniel Caceros Pineda
*/
# Codigo realizado por Pablo Daniel Caceros Persona
-- Coddigo realizao por Pablo Daniel Caceros Pineda
```

### Renombrar tablas existentes

```mysql
ALTER TABLE Persona RENAME People;
```

## Índices MYSQL

En un escenario donde se quieren consultar una gran cantidad de datos, se deben utilizar INDICES;

Los índices nos permiten INDEXAR información para que la búsqueda sea mas eficiente, existen diferentes tipos de índices:

- UNIQUE 
- PRIMARY
- FULLTEXT
- SPATIAL

UNIQUE

Nos permite tener en memoria cache los ID por lo tanto las búsquedas se realizan de manera mas eficiente, también evita los duplicados sobre los registros de la tabla. 

```mysql
ALTER TABLE Persona ADD UNIQUE(ID);
```

```mysql
ALTER TABLE Persona ADD INDEX(NOMBRE);
```

```mysql
CREATE TABLE datopersonal (
ID INT NOT NULL AUTO_INCREMENT, 
NOMBRE VARCHAR(50),
APELLIDO VARCHAR(50),
EDAD INT, 
DPI INT, 
PASAPORTE VARCHAR(50),
SEXO VARCHAR(1),
PRIMARY KEY (ID)
);
```

Para ver los índices generados

```mysql
SHOW INDEX FROM datopersonal;
```

Para agregar un índice y que el valor del campo no se pueda repetir. 

```mysql
ALTER TABLE datopersonal ADD UNIQUE(DPI);
```

Para agregar un índice FULLTEXT y INDEX es de la siguiente forma

```mysql
/* Para busquedas de texto vacrhar, text y char */
ALTER TABLE datopersonal ADD FULLTEXT INDEX(NOMBRE);
/* Para busquedas de texto varchar */
ALTER TABLE datopersonal ADD INDEX(APELLIDO);
/* Se pueden incluir en la creacion de la table de la siguiente manera */
CREATE TABLE datopersonal (
ID INT NOT NULL AUTO_INCREMENT, 
NOMBRE VARCHAR(20),
APELLIDO VARCHAR(20), 
EDAD INT, 
DPI INT, 
PASAPORTE VARCHAR(50),
SEXO VARCHAR(1),
    -- configuraciones
PRIMARY KEY (ID), 
UNIQUE DPI(DPI),
FULLTEXT INDEX NOMBRE(NOMBRE), 
INDEX (APELLIDO)
);
```

### Uso del if exists/if not exist

Crear una base de datos si no existe

```mysql
CREATE DATABASE IF NOT EXISTS ALMACENADORA;
```

Crear una tabla en una base de datos si no existe 

```mysql
CREATE TABLE IF NOT EXISTS CLIENTE (ID INT);
```

Eliminar una tabla si existe en una base de datos;

```mysql
DROP TABLE IF EXISTS CLIENTE;
```

## Lenguaje de manipulación de datos (DML)

- CREATE
- DELETE
- INSERT
- UPDATE
- SELECT

Insertar un dato en la tabla con *INSERT*

```mysql
INSERT INTO datopersonal (ID, NOMBRE, APELLIDO, EDAD, DPI, PASAPORTE, SEXO)
VALUES (NULL,"Pablo","Caceros",23,219831628,"888888","M");
```

> Si vamos a ingresar todos los datos existentes en la tabla podemos omitir colocar los campos y colocar directamente los valores.

```mysql
INSERT INTO datopersonal 
VALUES (NULL,"Pablo","Caceros",23,219831628,"888888","M");
```

Para realizar un INSERT múltiple

```mysql
INSERT INTO datopersonal 
VALUES (NULL,"Pablo","Caceros",23,219831628,"888888","M"),
(NULL,"Daniel","Pineda",15,987987555,"111111","M");
```

Actualizar un dato con *UPDATE*

```mysql
UPDATE datopersonal SET EDAD = 1;
```

> Si no especificamos una sentencia WHERE el update se realizara de manera general sobre todos los registros de la base de datos;

```mysql
UPDATE datopersonal SET EDAD = 1 WHERE ID = 1;
```

Seleccionar registros con la sentencia *SELECT*

```mysql
SELECT * FROM datopersonal;
SELECT ID, NOMBRE, APELLIDO FROM datopersonal;
SELECT ID, NOMBRE, APELLIDO FROM datopersonal WHERE ID = 21;
```

Eliminar un registro mediante la sentencia *DELETE*

```mysql
DELETE FROM datopersonal WHERE ID = 4;
```

> Del mismo modo si no se usa la condicional WHERE el comando se ejecuta de manera generalizada sobre todos los registros de la base de datos;

Hacer uso de la sentencia *TRUNCATE*  para limpiar una tabla.

```mysql
TRUNCATE persona;
```

## Motores de almacenamiento

Un motor de base de datos se encarga de manejar, controlar y dirigir las diferentes transacciones que realizamos a la base de datos actualmente y a partir de la versión 5.7 de MYSQL se utiliza InnoDB. 

Para ver los motores de almacenamiento. 

```mysql
SHOW ENGINES;
```

> Si la tabla no puede mostrarse en su totalidad en la terminal por el tamaño de la misma, podemos utilizar el siguiente comando, para desplegar la información en forma de lista. 

```mysql
SHOW ENGINES\G;
```

## Llaves foraneas  (Foreing Key)

Para este ejemplo se plantean dos tablas una de Departamentos y otra de clientes. 

```mysql
-- Creación de la tabla de departamento
CREATE TABLE DEPARTAMENTO (
ID INT NOT NULL AUTO_INCREMENT, 
NOMBRE VARCHAR(22) NOT NULL,
PRIMARY KEY (ID)
);

-- Creacion de la tabla cliente

CREATE TABLE CLIENTE (
ID INT NOT NULL AUTO_INCREMENT, 
NOMBRE VARCHAR(20) NOT NULL, 
APELLIDO VARCHAR(20) NOT NULL,
DEP_ID INT, 
PRIMARY KEY (ID),
FOREIGN KEY DEP_ID REFERENCES DEPARTAMENTO (ID)
);
```

Eliminar una llave foranea

```mysql
-- Para visualizar el nombre por defecto de la relacion
SHOW CREATE TABLE CLIENTE;
-- Luego para eliminarlo solo necesitamos referenciar el nombre
ALTER TABLE CLIENTE DROP FOREIGN KEY cliente_ibfk_1;
```

### Comportamientos

- RESTRICT

  Restringe la integridad de la data que esta relacionada. 

- CASCADE

  Borra los registros de la tabla dependiente. 

- SET NULL

  Convierte en null los registros que estén ligados en la relacion. 

  ```mysql
  ALTER TABLE CLIENTE ADD FOREIGN KEY (DEP_ID) REFERENCES DEPARTAMENTO (ID)
  ON DELETE CASCADE ON UPDATE CASCADE;
  ```

  ## Importar y exportar bases de datos
  
  En caso de que el archivo .sql contengan las instrucciones para crear una base de datos podemos utilizar el siguiente comando para importar una base de datos:
  
  ```mysql
  mysql -u root -p < C:\Users\striker\Documents\Database\MYSQL\world.sql
  ```
  
  Para exportar la base de datos:
  
  ```mysql
  mysqldump -u root -p <  C:\Users\striker\Documents\Database\MYSQL\nombre*
  ```
  
  Si debemos de crear la base de datos previamente utilizamos el siguiente comando:
  
  ```mysql
  CREATE DATABASE prueba;
  mysql -u root -p prueba > C:\Users\striker\Documents\Database\MYSQL\nombre*
  ```
  
  ### Forma alternativa de importar 
  
  Al estar sobre la base de datos deseada:
  
  ```
  sourceC:\Users\striker\Documents\Database\MYSQL\nombrearchivo.sql
  ```
  
  ## Select múltiple 
  
  ```mysql
  use world;
  -- City
  -- country 
  -- contrylanguage
  
  SELECT * FROM country;
  SELECT name, region FROM country;
  ```
  
  ## Select + distinct

```mysql
-- Mostrar registros unicos no duplicados
SELECT DISTINCT CountryCode FROM countrylanguage;
```

## 	  Select + Alias

```mysql
-- Colocarle un alias distinto a la busqueda
SELECT DISTINCT CountryCode AS "codigopais" FROM countrylanguage;
```

## Uso de la condicional where

```mysql
SELECT * FROM country;
SELECT Code, Name, Continent FROM country WHERE Code="ALB";
-- Para negar una condicional
SELECT Code, Name, Continent FROM country WHERE Continent<>"Europe";
-- Buscar el campo mayor
SELECT Code,Name,Continent FROM country WHERE SurfaceArea > 15000;

```

### Uso de where con <=>, !=

```mysql
SELECT Code, Name, Continent FROM country WHERE Continent!="Europe";
```

Comparación de valores incluyendo null con <=>

```mysql
SELECT Code,Name,Continent FROM country WHERE IndepYear <=> Capital;
```

### Uso de order by, and, &&, or y limit

```mysql
-- Order by
SELECT * FROM country ORDER BY Code DESC
SELECT * FROM country ORDER BY Code ASC
-- Limit: Limita el numero de tuplas
SELECT * FROM country ORDER BY Code DESC LIMIT 5
/* Podemos navegar por las diferentes paginaciones de tuplas */
SELECT * FROM country ORDER BY Code DESC LIMIT 0,5
-- And
SELECT * FROM country WHERE Continent='Asia' AND SurfaceArea > 15000 ORDER BY Code ASC;
-- Doble And
SELECT * FROM country 
WHERE Continent='Asia' 
AND SurfaceArea > 15000 
AND Population > 10000000
ORDER BY Code ASC;
-- Equivalente
SELECT * FROM country 
WHERE Continent='Asia' 
&& SurfaceArea > 15000 
&& Population > 10000000
ORDER BY Code ASC;
-- Or
SELECT Code, Name FROM country
WHERE Code = "ADW" OR Code="AGO";
-- Equivalente 
SELECT Code, Name FROM country
WHERE Code = "ADW" || Code="AGO";
```

## Uso de null y is not null

```mysql
-- Valores que no son null
SELECT * FROM country WHERE IndepYear IS NOT NULL;
-- Valores null
SELECT * FROM country WHERE IndepYear IS NULL;
```

## Uso de IN y Between

```mysql
-- IN
SELECT * FROM country WHERE Code IN ('ABW','ARG','USA');
SELECT * FROM country WHERE Code NOT IN ('ABW','ARG','USA');
-- BETWEEN
SELECT Code,Name,Region,SurfaceArea FROM country 
WHERE SurfaceArea BETWEEN 1 AND 16
ORDER BY Code ASC;
```

## Uso de LIKE

```mysql
SELECT * FROM country WHERE Name LIKE "Guatemala";
SELECT * FROM country WHERE Name LIKE "%Guatemala";
SELECT * FROM country WHERE Name LIKE "Guatemala%";
SELECT * FROM country WHERE Name LIKE "%Guatemala%";
```

### Definir el numero de caracteres

```mysql
SELECT * FROM country WHERE Name LIKE "G_____";
```

## Uso de concat y concat_ws

```mysql
-- concat
SELECT concat(code, name, Continent) FROM Country;
SELECT concat(Code," ",name," "Continent) AS "CampoCompuesto" FROM Country;
-- concat_ws
SELECT concat_ws("-",code, name, Continent) FROM Country;
```

## Uso de del min, max, count y avg. 

*Min* selecciona el valor mas bajo del campo especificado

```mysql
SELECT min(indepyear) FROM country WHERE code IN ('AFG','AGO')
```

*Count* realiza un conteo de los registros que coincidan

```mysql
SELECT Count(Code) FROM Country WHERE Population>=3703200;
```

*Max* selecciona el valor mas alto del campo especificado.

```mysql
SELECT max(indepyear) FROM country;
```

*Sum* es para sumar el valor de los campos

```mysql
SELECT sum(Population) FROM Country WHERE SurfaceArea>=78000;		
```

*Avg* nos regresa el promedio del campo seleccionado

```mysql
SELECT avg(Population) AS "Promedio" FROM Country;
```

## Creación de tablas a partir de otra

```mysql
-- Sobre la misma base de datos
CREATE TABLE Citybackup AS (SELECT * FROM City);		
-- En una base de datos diferente
CREATE TABLE basededatosnombre.citybackup2 AS (SELECT * FROM City);
```

## Uso de Union y Union all

```mysql
-- Se tiene las siguientes tablas
SELECT * FROM ConjuntoA;
+------+------+
| Col1 | Col2 |
+------+------+
| a    | a    |
| a    | b    |
| a    | c    |
| a    | d    |
| a    | e    |
+------+------+ 
SELECT * FROM ConjuntoB;
+------+------+
| Col1 | Col2 |
+------+------+
| a    | a    |
| a    | b    |
| a    | c    |
| a    | d    |
| a    | e    |
| a    | f    |
+------+------+
(SELECT * FROM ConjuntoA) UNION (SELECT * FROM ConjuntoB);
+------+------+
| Col1 | Col2 |
+------+------+
| a    | a    |
| a    | b    |
| a    | c    |
| a    | d    |
| a    | e    |
| a    | f    |
+------+------+
(SELECT * FROM ConjuntoA) UNION ALL (SELECT * FROM ConjuntoB);
```

## Uso de group BY

Se utiliza para agrupar tuplas, por lo regular el caso de uso seria un valor repetitivo que compartan diferentes registros. 

```mysql
SELECT ContryCode, count(name), max(Population), min(Population), avg(Population) 
FROM City 
GROUP BY (CountryCode)
ORDER BY CountryCode ASC LIMIT 10; 
```

## Uso de HAVING y la diferencia con WHERE

La condicional *WHERE* no funciona utilizando funciones de agrupacion tales como max(), min(), sum(), avg()

```mysql
SELECT ContryCode, count(name), max(Population), min(Population), avg(Population) 
FROM City
GROUP BY (CountryCode)
HAVING count(name) > 1
ORDER BY count(name);
```

## Uso de Inner Join

Conceptualmente un *INNER JOIN* no es mas que la intersección entre dos conjuntos 

```mysql
SELECT c.`Name`, c.`Continent`, c.`Population`, t.`Name` AS "Capitales" 
FROM country c
INNER JOIN city t
ON c.code=t.CountryCode;
```

## Para los siguientes ejemplos se utilizo la siguiente base de datos 

```mysql
CREATE TABLE departament (
	`id` INT NOT NULL AUTO_INCREMENT, 
    `name` VARCHAR(255), 
    PRIMARY KEY (id)
);

CREATE TABLE payment(
	`id` INT NOT NULL AUTO_INCREMENT, 
    `mount` VARCHAR(255), 
    `iduser` INT, 
    PRIMARY KEY (id), 
    FOREIGN KEY (`iduser`) REFERENCES users(`id`)
);

CREATE TABLE users (
	`id` INT NOT NULL AUTO_INCREMENT, 
    `name` VARCHAR(255), 
    `iddep` INT, 
    PRIMARY KEY (id), 
    FOREIGN KEY (`iddep`) REFERENCES departament(`id`)
);
```

## Uso de left join

A diferencia del INNER JOIN, podemos ver los datos coincidentes entre ambas tablas y los no coincidentes. 

```mysql
-- Si alguno de los usuario no fuera asignado a algun departamento lo podriamos ver con left join

SELECT u.`name`, d.`name`
FROM users u
LEFT JOIN departament d
ON u.iddep=d.id;

-- Si comparamos con inner join

SELECT u.`name`, d.`name`
FROM users u
INNER JOIN departament d
ON u.iddep=d.id;

```

## Uso de right join

```mysql
-- Si quiero saber los departamentos que no estan asociados a un usuario

SELECT u.name , d.name
FROM users u
RIGHT JOIN departament d
ON u.iddep=d.id;

-- comparacion con inner join

SELECT u.name , d.name
FROM users u
INNER JOIN departament d
ON u.iddep=d.id;
```

## Uso de self join

Es una manera abreviada o alternativa de realizar un inner join

```mysql
SELECT u.name, d.name
FROM users u, departament d
WHERE u.iddep=d.id;
```

## Uso del case 

```mysql
SELECT Name, IndepYear,
CASE 
WHEN IndepYear is null THEN "Es null"
WHEN IndepYear>1500 THEN "Es mayor a 1950"
ELSE "Es menor a 1500"
END AS "Resultado"
FROM Country 
```

## Funciones de tipo String,: LTRIM, RTRIM y TRIM 

- LTRIM eliminar espacios del lado izq. 

```mysql
SELECT LTRIM(Name) from Country;
```

- RTTRIM eliminar espacios del lado derecho. 

```mysql
SELECT RTRIM(Name) from Country;
```

- TRIM elimina los espacios de ambos lados. 

```mysql
SELECT TRIM(Name) from Country;
```

> ***Nota:***  Estas funciones no pueden eliminar espacios entre palabras. 

## Funciones de tipo String:  UCASE, UPPER, LCASE, LOWER

- UCASE: Pone el texto en mayuscula. 

```mysql
SELECT UCASE(Name) FROM Country;		
```

- UPPER: Alternativa a UCASE 

```mysql
SELECT UPPER(Name) FROM Country;
```

- LCASE: Pone el texto en minuscula. 

```mysql
SELECT LCASE(Name) FROM Country;
```

- LOWER: Alternativa a LCASE;

```mysql
SELECT LCASE(Name) FROM Country;
```



## Funciones de tipo String: Length, char_length y character_length

- LENGTH: Devuelve el numero de caracteres de una cadena. 

```mysql
SELECT Name, LENGTH(Name) FROM Country;
```

- CHAR_LENGTH: Es una alternativa a LENGTH;

```mysql
SELECT Name, CHAR_LENGTH(Name) FROM Country;
```

- CHARACTER_LEGTH: Es otra alternativa alas funciones LENGTH y CHAR_LENGTH;

```mysql
SELECT Name, CHARACTER_LENGTH(Name) FROM Country;
```



## Funciones de tipo String: INSTR, LOCATE y POSITION;

- INSTR: Buscar caracteres dentro de un campo y tiene como salida la posición.

```mysql
SELECT Name, INSTR(Name, "ar") FROM Country;
```

- POSITION: Alternativa a INSTR

```mysql
SELECT Name, POSITION("ar" in Name) FROM Country;
```

- LOCATE: Alternativa a INSTR y POSITION

```mysql
-- A diferencia de las otras le podemos inidcar desde quie poscision empezar a buscar
SELECT Name, LOCATE("ar", Name, 3) FROM Country;
```

## Funciones de tipo String: LPAD, RPAD, LEFT, RIGTH, SUBSTR, SUBSTRING, SUBSTRING_INDEX. 

- LPAD: Cumple la función de agregar un carácter del lado izquierdo especifico una n cantidad de veces. 

```mysql
SELECT Name, LPAD(Name, 20, "*") AS "Modificado" FROM Country;

-- Salida 
'Afghanistan', '*********Afghanistan'
'Albania', '*************Albania'

```

- RPAD: Cumple la función de agregar un carácter del lado izquierdo especifico una n cantidad de veces. 

```mysql
SELECT Name, RPAD(Name, 20, "*") AS "Modificado" FROM Country;

-- Salida 
'Aruba', 'Aruba***************'
'Afghanistan', 'Afghanistan*********'

```

- RIGTH: Nos permite recortar los caracteres de un campo del lado derecho. 

```mysql
SELECT Name, RIGHT(Name, 4) AS "Recortado" FROM Country;
```

- LEFT:   Nos permite recortar los caracteres de un campo del lado izquierdo.

```mysql
SELECT Name, LEFT(Name, 4) AS "Recortado" FROM Country;
```

- SUBSTR: Nos permite recortar desde un carácter especifico una n cantidad de caracteres. 

```mysql
--            [CAMPO] [DESDE] [CUANTOS]
SELECT Name, SUBSTR(Name, 2, 5) AS "Recortado" FROM Country;
-- Manera alternativa
SELECT Name, SUBSTRING(Name, 2, 5) AS "Recortado" FROM Country;
```

- SUBSTRING_INDEX:  Recorta el campo hasta la primera coincidencia. 

```mysql
--                                     [COINCIDENCIA]
SELECT Name, SUBSTRING_INDEX(Name, "a", 1) FROM Country;
```

## Ejemplo de uso de funciones de tipo String

El ejercicio consta de tomar la inicial de los continentes en un campo individual, posteriormente se debe concatenar de nuevo. 

```mysql
SELECT continent, 
LEFT(Name, 1) AS "Inicial", 
SUBSTR(Name, 2, LENGTH(Name)-1) AS "Complemento", 
CONCAT(LEFT(Name, 1), UCASE(SUBSTR(Name, 2, LENGTH(Name)-1))) AS "Concatenado"
FROM Country;
```



## Uso de REPEAT, REPLACE, REVERSE, STRCMP y MID

- REPEAT: Repite N cantidad de veces el valor del string

```mysql
SELECT Name, REPEAT(Name, 3) FROM Country;

-- Aruba	ArubaArubaAruba
```

- REPLACE: Remplaza los caracteres con todas las coincidencias. 

```mysql
SELECT Name, REPLACE(Name, "a", "x") FROM Country;
-- Afghanistan	Afghxnistxn
```

- REVERSE: Puede cambiar el orden de el string al reverso

```mysql
SELECT Name, REVERSE(Name) FROM Country;
-- Aruba	aburA
```

- STRCMP: Nos sirve para conectar =cadenas de texto y nos da como un 0 si el campo coincide.

```mysql
SELECT Name, STRCMP(Name, "Aruba") FROM Country;
```

- MID: Alternativa a substring

```mysql
--                    [POSICION] [CORTAR]
SELECT Name, MID(Name, 1, 3) FROM Country;
```

##  Funciones de fecha y hora

### CURDATE() , CURRENT_DATE(), CURTIME(), CURRENT_TIME(), CURRENT_TIMESTAMP() y NOW()

Fecha actual

```mysql
SELECT CURDATE(); -- Fecha actual
-- Forma alternativa
SELECT CURRENT_DATE();
```

Hora actual

```mysql
SELECT CURTIME();
-- Forma alternatica
SELECT CURRENT_TIME();
```

Fecha y hora

```mysql
SELECT CURRENT_TIMESTAMP();
-- Forma alternativa
SELECT NOW();
```

### DAYOFMONTH, DAYOFWEEK, DAYOFYEAR, MONTH, YEAR

Obtener el día de una fecha

```mysql
SELECT DAY("2022-06-03")			
-- Forma alternativa
SELECT DAYOFMONTH("2022-06-03")
```

 Obtener el día de la semana

```mysql
SELECT DAYOFWEEK("2022-06-03");	
```

Obtener el día del año

```mysql
SELECT DAYOFYEAR("2022-06-03");
```

Obtener el mes del año

```mysql
SELECT MONTH("2022-06-03");
```

Obtener el año de la fecha

```mysql
SELECT YEAR("2022-06-03");
```

### LOCALTIME, LOCALTIMESTMAP, SYSDATE(), TIME, HOUR, MINUTE, SECOND

Obtener la fecha y hora local

```mysql
SELECT LOCALTIME()
-- Forma alternativa 
SELECT LOCALTIMESTAMP()
--  Forma alternativa
SELECT SYSDATE();
```

Extraer la hora de una fecha 

```mysql
SELECT TIME(LOCALTIME);		
```

Podemos escalarlo para obtener la hora 

```mysql
SELECT HOUR(TIME(LOCALTIME));
```

Podemos escalarlo para obtener el minuto 

```mysql
SELECT MINUTE(TIME(LOCALTIME));
```

Podemos escalarlo para obtener el segundo

```mysql
SELECT SECOND(TIME(LOCALTIME));
```

Obtener el ultimo día del mes

```mysql
SELECT LAST_DAY("2022-06-03");
```

Convertir una fecha a números a partir del año cero

```mysql
SELECT TO_DAY("2022-06-03");
-- Para realizar el inverso
SELECT FROM_DAYS(TO_DAYS("2022-06-03"));
```

Para obtener el trimestre

```
SELECT QUARTER(2022-06-03");
```

Obtener la semana del año en la que estamos 

```mysql
SELECT week("2022-06-03"); -- Tomar en cuenta que empieza desde 0
-- Alternativa que empieza desde 1
SELECT weekofyear("2022-06-03");
```

### DAYNAME, MONTHNAME, Y LC_TIME_NAMES

Obtener el nombre de la semana

```mysql
SELECT DAYNAME("2020-06-03");
```

Obtener el nombre del mes

```mysql
SELECT MONTHNAME("2022-06-03");
```

Si tuviéramos la necesidad de cambiar la salida del idioma debemos de modificar la variable siguiente

```
@@lc_time_name
```

Para editar esta variable podemos hacer lo siguiente

```mysql
SET @@lc_time_names = 'es_GT'
```

### ADDDATE, ADDTIME, SUBDATE, SUBTIME

Sumar días a  una fecha 

```mysql
SELECT ADDDATE("2022-06-03", 5);
-- Alternative
SELECT ADDDATE("2022-06-03", INTERVAL 5 DAY);
SELECT ADDDATE("2022-06-03", INTERVAL 5 MONTH);
SELECT ADDDATE("2022-06-03", INTERVAL 5 YEAR);
SELECT ADDDATE("2022-06-03", INTERVAL 5 HOUR);
SELECT ADDDATE("2022-06-03", INTERVAL 5 SECOND);
```

> *subdate* tiene el mismo funcionamiento con la diferencia que subdate es indiferente a los signos que utilizamos. 

Sumar tiempo a una fecha 

```mysql
SELECT ADDTIME("2022-06-03", "01:05:03")
-- Podemos aumentarle dias
SELECT ADDTIME("2022-06-03", "5 01:05:03")
```

### DATE_ADD, DATE_SUB, DATE, DATEDIFF Y EXTRACT

Comparar dos campos de fecha y ver la diferencia

```mysql
--              [FECHA MAYOR] [FECHA MENOR]
SELECT DATEDIFF("2022-06-03", "2022-06-06");
```

Extraer una información especifica de un campo

```mysql
SELECT EXTRACT(HOUR FROM "2022-06-03");
SELECT EXTRACT(DAY FROM "2022-06-03");
SELECT EXTRACT(MONTH FROM "2022-06-03");
```

### DATE_FORMAT

```mysql
--				      [ESPECIFICADOR]
SELECT DATE_FORMAT("2022-06-03", "%a")
```



| ESPECIFICADOR | DESCRIPCION                                                  |
| ------------- | ------------------------------------------------------------ |
| %a            | Día  de semana abreviado (Sun..Sat)                          |
| %b            | Mes  abreviado (Jan..Dec)                                    |
| %c            | Mes,  numérico (0..12)                                       |
| %D            | Día  del mes con sufijo inglés (0th, 1st, 2nd, 3rd, ...)     |
| %d            | Día  del mes numérico (00..31)                               |
| %e            | Día  del mes numérico (0..31)                                |
| %f            | Microsegundos  (000000..999999)                              |
| %H            | Hora  (00..23)                                               |
| %h            | Hora  (01..12)                                               |
| %I            | Hora  (01..12)                                               |
| %i            | Minutos,  numérico (00..59)                                  |
| %j            | Día  del año (001..366)                                      |
| %k            | Hora  (0..23)                                                |
| %l            | Hora  (1..12)                                                |
| %M            | Nombre  mes (January..December)                              |
| %m            | Mes,  numérico (00..12)                                      |
| %p            | AM o PM                                                      |
| %r            | Hora,  12 horas (hh:mm:ss seguido de AM o PM)                |
| %S            | Segundos  (00..59)                                           |
| %s            | Segundos  (00..59)                                           |
| %T            | Hora,  24 horas (hh:mm:ss)                                   |
| %U            | Semana  (00..53), donde domingo es el primer día de la semana |
| %u            | Semana  (00..53), donde lunes es el primer día de la semana  |
| %V            | Semana  (01..53), donde domingo es el primer día de la semana; usado con %X |
| %v            | Semana  (01..53), donde lunes es el primer día de la semana; usado con %x |
| %W            | Nombre  día semana (Sunday..Saturday)                        |
| %w            | Día  de la semana (0=Sunday..6=Saturday)                     |
| %X            | Año  para la semana donde domingo es el primer día de la semana, numérico, cuatro  dígitos; usado con %V |
| %x            | Año  para la semana, donde lunes es el primer día de la semana, numérico, cuatro  dígitos; usado con %v |
| %Y            | Año,  numérico, cuatro dígitos                               |
| %y            | Año,  numérico (dos dígitos)                                 |
| %%            | Carácter  '%' literal                                        |



## Administración de usuarios

Obtener el usuario conectado

```mysql
SELECT CURRENT_USER();
-- Alternativa
SELECT SESSION_USER();
SELECT SYSTEM_USER();
SELECT USER();
```

Obtener la versión de MYSQL

```mysql
SELECT VERSION();
```



```
ALTER USER 'username'@'%' IDENTIFIED BY 'passworld';
FLUSH PRIVILEGES;
```

