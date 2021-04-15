--1
SELECT * FROM menu
ORDER BY pizza asc

--2
SELECT * FROM menu
ORDER BY price desc, pizza asc

--3
SELECT DISTINCT price FROM menu

--4
SELECT * FROM menu
WHERE  country='Italy' AND price<7.00

--5
SELECT * FROM menu
WHERE country IS NOT NULL AND  NOT country='Italy' AND NOT  country='USA'

--6
SELECT * FROM menu
WHERE pizza='vegetarian' OR pizza='americano' OR pizza='mexicano' OR pizza='garlic' 

--7
SELECT * FROM menu 
WHERE price BETWEEN 6.00 AND 7.00

--8
SELECT * FROM menu
WHERE pizza LIKE '%ano';

--9
SELECT pizza, price, country FROM menu
WHERE country IS NOT NULL;

--10
SELECT amount FROM recipe
WHERE ingredient='spice'
ORDER BY amount DESC;
