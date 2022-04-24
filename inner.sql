USE world;

-- INNER JOIN

SELECT c.`Name`, c.`Continent`, c.`Population`, t.`Name` AS "Capitales" 
FROM country c
INNER JOIN city t
ON c.code=t.CountryCode;

-- LEFT JOIN

-- CREATE DATABASE empresa;
USE empresa;

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
	id INT NOT NULL AUTO_INCREMENT, 
    nombre VARCHAR(255), 
    iddep INT, 
    PRIMARY KEY (id), 
    FOREIGN KEY (`iddep`) REFERENCES departament(`id`)
);

INSERT INTO departament VALUES (null, "IT");
INSERT INTO departament VALUES (null, "Contabilidad");
INSERT INTO departament VALUES (null, "Auditoria");
INSERT INTO departament VALUES (null, "Riesgos ");


INSERT INTO users VALUES (null, "Pablo", 1);
INSERT INTO users VALUES (null, "Elder", 2);
INSERT INTO users VALUES (null, "Maria", 3);
INSERT INTO users VALUES (null, "Pedro", 3);
INSERT INTO users VALUES (null, "Joselyne", null);


INSERT INTO payment VALUES (null, 1500, 1);
INSERT INTO payment VALUES (null, 3500, 3);
INSERT INTO payment VALUES (null, 2500, 2);
INSERT INTO payment VALUES (null, 500, 2);
INSERT INTO payment VALUES (null, 500, 10);

SELECT * FROM users;
SELECT * FROM departament;
SELECT * FROM payment;


ALTER TABLE users CHANGE nombre name VARCHAR(255);

SELECT u.`name`, d.`name`
FROM users u
LEFT JOIN departament d
ON u.iddep=d.id;

-- Si comparamos con inner join

SELECT u.`name`, d.`name`
FROM users u
INNER JOIN departament d
ON u.iddep=d.id;

-- RIGHT JOIN 

SELECT u.name , d.name
FROM users u
RIGHT JOIN departament d
ON u.iddep=d.id;

-- comparacion con inner join

SELECT u.name , d.name
FROM users u
INNER JOIN departament d
ON u.iddep=d.id;

-- self join

SELECT u.name, d.name
FROM users u, departament d
WHERE u.iddep=d.id;


-- USO DEL CASE 


SELECT * FROM Country;

SELECT Name, IndepYear,
CASE 
WHEN IndepYear is null THEN "Es null"
WHEN IndepYear>1500 THEN "Es mayor a 1950"
ELSE "Es menor a 1500"
END AS "Resultado"
FROM Country;



SELECT 
    UCASE(Name)
FROM
    Country;		
    
SELECT LOWER(Name) FROM Country;


SELECT Name, LENGTH(Name) FROM Country;
SELECT Name, CHARACTER_LENGTH(Name) FROM Country;

SELECT Name, INSTR(Name, "ar") FROM Country;
SELECT Name, POSITION("ar" in Name) FROM Country;


SELECT LTRIM(Name) from Country;
SELECT Name, LOCATE("ar", Name, 3) FROM Country;

SELECT Name, RPAD(Name, 20, "*") AS "Modificado" FROM Country;

SELECT Name, RIGHT(Name, 4) AS "Recortado" FROM Country;
SELECT Name, LEFT(Name, 4) AS "Recortado" FROM Country;

SELECT Name, SUBSTRING(Name, 2, 5) AS "Recortado" FROM Country;
USE world;
SELECT Name, SUBSTRING_INDEX(Name, "a", 1) FROM Country;

-- EJEMPLOM DE USO DE STRING 

SELECT continent, 
LEFT(Name, 1) AS "Inicial", 
SUBSTR(Name, 2, LENGTH(Name)-1) AS "Complemento", 
CONCAT(LEFT(Name, 1), UCASE(SUBSTR(Name, 2, LENGTH(Name)-1))) AS "Concatenado"
FROM Country;


SELECT Name, REPEAT(Name, 3) FROM Country;
SELECT Name, REPLACE(Name, "a", "x") FROM Country;
SELECT Name, REVERSE(Name) FROM Country;


SELECT Name, STRCMP(Name, "Aruba") FROM Country;







