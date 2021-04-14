--1
SELECT * FROM menu
ORDER BY pizza asc

--2
SELECT * FROM menu
ORDER BY price desc

--3
SELECT DISTINCT price FROM menu

--4
SELECT * FROM menu
WHERE country LIKE 'Italy';

--8
SELECT * FROM menu
WHERE pizza LIKE '%ano';

--9
SELECT pizza, price, country FROM menu
WHERE country IS NOT NULL;

--10
--na razie nie dzia³a ale powinno gdy bêd¹ wszystkie tabelki
SELECT amount FROM recipe
WHERE ingredient='spice'
ORDER BY amount DESC;
