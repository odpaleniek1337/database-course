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
SELECT ingredient, pizza, amount FROM recipe
Where amount = (SELECT MAX(amount) FROM recipe)
GROUP BY ingredient
HAVING amount = (SELECT MAX(amount) FROM recipe)
Ÿle jest ale nie wiem jak zrobiæ tbh

SELECT ingredient, pizza, amount FROM recipe
SELECT MAX(amount) FROM recipe GROUP BY ingredient
SELECT ingredient FROM recipe GROUP BY ingredient

--3
select recipe.ingredient, recipe.pizza, recipe.amount
from recipe
inner join
(select  ingredient, max(amount) amt
from recipe
group by ingredient) rcp
on recipe.ingredient = rcp.ingredient and recipe.amount = rcp.amt
order by recipe.ingredient desc

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
