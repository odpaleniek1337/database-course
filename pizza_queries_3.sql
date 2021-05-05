--Task 1 
USE pizza;

--1
SELECT country, CAST(AVG(price) as DECIMAL(3,2)) as 'Average price' FROM menu
WHERE country IS NOT NULL
GROUP BY country;

--2
SELECT country, MAX(price) as 'Highest price' FROM menu
WHERE country IS NOT NULL
GROUP BY country;

--3
SELECT country, MIN(price) as 'min price' FROM menu
WHERE country IS NOT NULL
GROUP BY country;

--4
SELECT country, AVG(price) as 'avg price' FROM menu
WHERE country IS NOT NULL 
group by country
having count(pizza)>1 

--5
SELECT country, CAST(AVG(price) as DECIMAL(3,2)) as 'Average price' FROM menu
WHERE country LIKE '%i%'
GROUP BY country;

--6
SELECT country, MIN(price) FROM menu
WHERE country IS NOT NULL
GROUP BY country
HAVING min(price) < 7.50;

--Task 2

--1
SELECT pizza, price FROM menu
WHERE price >
(SELECT MAX(price) FROM menu WHERE country='Italy')


--2
SELECT DISTINCT pizza FROM recipe
WHERE ingredient IN
(SELECT ingredient FROM items WHERE type='meat')

--3
SELECT recipe.ingredient, recipe.pizza, recipe.amount FROM recipe
INNER JOIN (SELECT ingredient, max(amount) amt FROM recipe GROUP BY ingredient) rcp
ON recipe.ingredient = rcp.ingredient and recipe.amount = rcp.amt
ORDER BY recipe.ingredient DESC

--SELECT ingredient, pizza, amount FROM recipe r WHERE amount = (SELECT MAX(amount) FROM recipe WHERE ingredient=r.ingredient);

--4
SELECT ingredient FROM recipe rec
WHERE (SELECT count(pizza) FROM recipe WHERE ingredient = rec.ingredient) > 1
GROUP BY ingredient

--5
SELECT pizza FROM recipe
WHERE ingredient IN(SELECT ingredient FROM items WHERE type='meat')
GROUP BY pizza

--6
SELECT ingredient FROM items
WHERE ingredient NOT IN (SELECT ingredient FROM recipe)

--7
SELECT ingredient FROM recipe rec
WHERE (SELECT count(pizza) FROM recipe WHERE ingredient = rec.ingredient) > 1
GROUP BY ingredient

--8
SELECT pizza, price from menu
WHERE price < (SELECT price from menu WHERE pizza = 'napoletana')
AND price > (SELECT price from menu WHERE pizza = 'garlic')

--9
SELECT pizza FROM recipe rec
GROUP BY pizza
HAVING count(rec.ingredient) = (SELECT MAX(ing) FROM (SELECT pizza, count(ingredient) ing FROM recipe GROUP BY pizza) as aa)

--10
SELECT DISTINCT type FROM items it
WHERE it.ingredient IN (SELECT ingredient FROM recipe rec
WHERE rec.pizza = (SELECT pizza FROM menu m
WHERE (SELECT max(price) FROM menu) = m.price))
