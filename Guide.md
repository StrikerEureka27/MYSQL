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

Visualizar las diferente bases de datos de nuestro servidor. 

```mysql
show databases;
```

Crear una base de datos. 

```mysql
create database prueba;
```

Eliminar una base de datos;

```
drop database prueba;
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

```
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

