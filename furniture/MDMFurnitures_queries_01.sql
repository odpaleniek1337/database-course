--8
SELECT * FROM RawMaterial_T
WHERE Material='Cherry' AND Thickness='12' AND Width='12'

--9
SELECT MaterialID, MaterialName, Material, MaterialStandardPrice, Thickness
FROM RawMaterial_T
WHERE Material IN ('Cherry', 'Pine', 'Walnut')
ORDER BY Material, MaterialStandardPrice, Thickness

--10
SELECT ProductLineID, AVG(ProductStandardPrice) AS 'avg prize'
FROM Product_T
GROUP BY ProductLineID

--11
SELECT ProductLineID, AVG(ProductStandardPrice) AS 'avg prize'
FROM Product_T
WHERE ProductStandardPrice > 200
GROUP BY ProductLineID
HAVING AVG(ProductStandardPrice) > 500

--12
SELECT ProductID, OrderedQuantity as TotalOrdered
FROM OrderLine_T o
WHERE OrderedQuantity=
(SELECT SUM(OrderedQuantity) FROM OrderLine_T 
WHERE ProductID = o.ProductID)
ORDER BY OrderedQuantity DESC

--13
SELECT OrderID, COUNT(ProductID) as ProductNumber, SUM(OrderedQuantity) as ProductSum
FROM OrderLine_T
GROUP BY OrderID

--14
SELECT CustomerID, COUNT(OrderID) as TotalOrders
FROM Order_T
GROUP BY CustomerID

--15
SELECT DISTINCT SalespersonID, CustomerID
FROM Order_T
ORDER BY SalespersonID
--chyba nie o to do koñca chodzi³o ale nie wiem jak wyœwietliæ wszystkie CustomerID w jednym wierszu

--16
SELECT ProductID, COUNT(OrderID) as NumOrders
FROM OrderLine_T
GROUP BY ProductID
ORDER BY NumOrders DESC

