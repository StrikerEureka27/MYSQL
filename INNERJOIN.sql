SELECT * FROM country;
SELECT * FROM city;

-- Inner join

SELECT c.`Code`, c.`Name`, c.`Continent`, c.`Population`, t.`Name` ,l.language 
FROM country c
INNER JOIN city t
ON c.`Code`=t.CountryCode
INNER JOIN countrylanguage l
ON c.code = t.`CountryCode`;

SELECT c.Name, COUNT(t.Name) AS "Ciudades"
FROM country c

INNER JOIN city t
ON t.CountryCode=c.Code

INNER JOIN countrylanguage l
ON l.CountryCode=c.Code

GROUP BY c.Code;

SELECT * FROM country WHERE CODE="AFG";
SELECT * FROM countrylanguage WHERE Countrycode="AFG";
SELECT * FROM city WHERE Countrycode="AFG";



-- Left join


