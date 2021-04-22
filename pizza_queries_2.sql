-- Task 1

--4
SELECT SUM(price)
FROM menu
WHERE pizza='margherita' OR pizza='vegetarian'

--5
(SELECT MIN(price)
FROM menu) UNION
(SELECT MAX(price)
FROM menu) UNION
(SELECT AVG(price)
FROM menu)

-- Task 2

--3

--4

--5