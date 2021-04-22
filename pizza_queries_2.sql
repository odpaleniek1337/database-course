-- Task 1

--4
SELECT SUM(price) AS margherita_vegetarian
FROM menu
WHERE pizza='margherita' OR pizza='vegetarian';

--5
SELECT MIN(price) AS min_price, 
MAX(price) AS max_price, 
AVG(price) AS avg_price
FROM menu;

-- Task 2

--3

--4

--5