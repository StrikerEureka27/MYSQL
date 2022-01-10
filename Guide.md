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













## Manejo de usuarios - Actualizar contraseña

```
ALTER USER 'testgrafana'@'%' IDENTIFIED BY 'p_B''GZ2*Bwr.-Q=-';
FLUSH PRIVILEGES;
```

