SELECT * FROM country;
SELECT * FROM city;

-- Inner join

SELECT c.`Name`, c.`Continent`, c.`Population`, t.`Name` l.language AS "Capitales" 
FROM country c
INNER JOIN city t
ON c.code=t.CountryCode
INNER JOIN countrylanguage l
ON c.code = t.`CountryCode`;

-- Left join


