-- Task 1

--1
SELECT COUNT (pizza) 
FROM menu;

--2
SELECT COUNT (DISTINCT country) 
FROM menu;

--3
SELECT MIN(price) AS "Cheapest_Italian"
FROM menu
WHERE country='Italy'

--4
SELECT SUM(price) AS margherita_vegetarian
FROM menu
WHERE pizza='margherita' OR pizza='vegetarian';

--5
SELECT MIN(price) AS min_price, 
MAX(price) AS max_price, 
AVG(price) AS avg_price
FROM menu;

--6
SELECT COUNT(base) as 'No. of wholemeal'
FROM menu
WHERE base='wholemeal'

--7
SELECT COUNT(pizza) as 'No. of no country'
FROM menu
WHERE country IS NULL

--8
SELECT CAST(ROUND(AVG(0.3*50*price),2) as DECIMAL(5,2)) as 'Profit'
FROM menu

-- Task 2
                                                  
--1
SELECT recipe.ingredient, items.type
from recipe
INNER JOIN items ON items.ingredient= recipe.ingredient WHERE recipe.pizza='Margherita'

--2
SELECT items.ingredient, recipe.pizza
from recipe
INNER JOIN items ON items.ingredient= recipe.ingredient	WHERE items.type='fish'

--3
SELECT items.ingredient, recipe.pizza
FROM recipe
JOIN items ON recipe.ingredient = items.ingredient WHERE items.type='meat';

--4
DECLARE @c varchar
SELECT @c = country FROM menu WHERE pizza='siciliano'

SELECT pizza
FROM menu
WHERE country=@c;

--5
DECLARE @p dec(4,2)
SELECT @p = price FROM menu WHERE pizza='quattro stagioni'

SELECT pizza, price
FROM menu
WHERE price > @p;

--6
SELECT items.ingredient, menu.pizza from MENU
LEFT JOIN recipe ON menu.pizza=recipe.pizza
FULL JOIN items ON recipe.ingredient=items.ingredient
WHERE items.type='fish'
ORDER BY items.ingredient ASC;

--7
SELECT DISTINCT type from menu
LEFT JOIN recipe ON menu.pizza=recipe.pizza
LEFT JOIN items ON recipe.ingredient=items.ingredient
WHERE menu.country IN ('U.S','Mexico','Canada')

--8
SELECT menu.pizza FROM menu
LEFT JOIN recipe ON menu.pizza=recipe.pizza
LEFT JOIN items ON recipe.ingredient=items.ingredient
WHERE menu.base='wholemeal' AND items.type='fruit'
