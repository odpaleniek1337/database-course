--1
ALTER TABLE Product_T ADD QtyOnHand int, CHECK (QtyOnHand > 0 AND QtyOnHand < 100000)

--2
UPDATE Product_T SET QtyOnHand = -10 WHERE ProductID > 25; 
UPDATE Product_T SET QtyOnHand = 100000 WHERE ProductID > 25; 
UPDATE Product_T SET QtyOnHand = 10000 WHERE ProductID > 25;

--3A
INSERT INTO Order_T(OrderID, OrderDate, CustomerID, FulfillmentDate, SalespersonID, ShipAdrsID)
VALUES (78, '09/May/21', 16, '', 3, NULL);

--3B
INSERT INTO Order_T(OrderID, OrderDate, CustomerID, FulfillmentDate, SalespersonID, ShipAdrsID)
VALUES (79, '11/May/21', 17, '', 3, NULL);

--4A
SELECT COUNT(WorkCenterID)  AS 'No of Work Centers' FROM WorkCenter_T;

--4B
SELECT DISTINCT WorkCenterLocation FROM WorkCenter_T;

--5
SELECT * FROM Employee_T WHERE EmployeeName LIKE '% L%';

--6
SELECT * FROM Employee_T WHERE EmployeeDateHired LIKE '2005-%';

--7
SELECT * FROM Customer_T WHERE CustomerState IN ('CA', 'WA');

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
--chyba nie o to do ko�ca chodzi�o ale nie wiem jak wy�wietli� wszystkie CustomerID w jednym wierszu

--16
SELECT ProductID, COUNT(OrderID) as NumOrders
FROM OrderLine_T
GROUP BY ProductID
ORDER BY NumOrders DESC


--17
select paymentid, orderid, paymentamount, PaymentDate, substring(paymentcomment,1,10) as 'paymentcomment' 
from Payment_T 
where PaymentDate>= '2018-03-10';

--18
select customerid, count(order_t.OrderID) as totalorders 
from Order_T 
where CustomerID=Order_T.CustomerID and Order_T.OrderDate like '2018%' 
group by CustomerID;

--19
select salespersonid, count(order_t.OrderID) as totalorders
from Order_T 
where SalespersonID=Order_T.SalespersonID 
group by SalespersonID;

--20

select customerid, count(order_t.OrderID) as totalorders 
from Order_T
where CustomerID=Order_T.CustomerID 
group by CustomerID
having count(order_t.OrderID)>2;

--21-
select TerritoryID, count(Salesperson_T.SalespersonID) as salespeople from Salesperson_T, Territory_T
where TerritoryID=SalesTerritoryID
group by TerritoryID;

--22
select employeename, year(employeeDateHired)-year(employeebirthdate) as'age hired' 
from Employee_T 
where EmployeeState in ('TN','FL');

--23
select TerritoryID, count(Salesperson_T.SalespersonID) as NumSalesPersons 
from Salesperson_T, Territory_T
where TerritoryID=SalesTerritoryID 
group by TerritoryID
having count(Salesperson_T.SalespersonID)>1;

--24
select materialname, material, Width
from RawMaterial_T 
where Material not in ('cherry', 'oak') and width>10 ;

--25
select ProductID, ProductDescription, ProductFinish, ProductStandardPrice 
from Product_T
where (ProductFinish='oak' and ProductStandardPrice>400) or (ProductFinish='cherry' and ProductStandardPrice<300);





