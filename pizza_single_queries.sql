--8
SELECT * FROM menu
WHERE pizza LIKE '%ano';

--9
SELECT pizza, price, country FROM menu
WHERE country IS NOT NULL;

--10
--na razie nie dzia�a ale powinno gdy b�d� wszystkie tabelki
SELECT amount FROM recipe
WHERE ingredient='spice'
ORDER BY amount DESC;
