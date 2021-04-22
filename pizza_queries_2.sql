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

--6
SELECT COUNT(base) as 'No. of wholemeal'
FROM menu
WHERE base='wholemeal'

--7
SELECT COUNT(1) as 'No. of no country'
FROM menu
WHERE country IS NULL

--8
SELECT CAST(ROUND(AVG(0.3*50*price),2) as DECIMAL(5,2)) as 'Profit'
FROM menu

-- Task 2

--3

--4

--5

--6
SELECT recipe.ingredient, menu.pizza from MENU
LEFT JOIN recipe ON menu.pizza=recipe.pizza
LEFT JOIN items ON recipe.ingredient=items.ingredient
WHERE items.type='fish'
ORDER BY recipe.ingredient ASC;

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