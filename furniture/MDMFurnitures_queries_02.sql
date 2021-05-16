USE PVFC

--1
select CustomerName from customer_t
where customerid not in (select CustomerID from Order_T)

--2
select ProductLineID, count(product_t.productid) as numberofproducts , avg( Product_T.ProductStandardPrice) as avgproductprice
from  Product_T
where productid= Product_T.ProductID 
group by ProductlineID;

--3
select ProductLineID, count(product_t.productid) as numberofproducts , avg( Product_T.ProductStandardPrice) as avgproductprice
from  Product_T
where productid= Product_T.ProductID 
group by ProductlineID
having avg( Product_T.ProductStandardPrice)>200;

--4
select employeesupervisor, count(employeename) as headcount
from Employee_T 
group by EmployeeSupervisor
having count(employeename)>2 ;

--5
SELECT em.EmployeeName, em.EmployeeBirthDate, man.EmployeeName AS Manager, man.EmployeeBirthDate AS ManagerBirth FROM Employee_T em
INNER JOIN (SELECT * FROM Employee_T) man
ON em.EmployeeSupervisor = man.EmployeeID
WHERE em.EmployeeBirthDate < man.EmployeeBirthDate
GROUP BY em.EmployeeName, em.EmployeeBirthDate, man.EmployeeName, man.EmployeeBirthDate

--6

select order_t.orderid, order_t.CustomerID, order_t.OrderDate, Product_T.ProductDescription
from ((Order_T 
inner join OrderLine_T on order_t.OrderID= OrderLine_T.OrderID)
inner join Product_T on OrderLine_T.ProductID= Product_T.ProductID)
where Order_T.CustomerID=3;

--7
select Product_T.ProductID, Product_T.ProductStandardPrice, sum(Product_T.ProductStandardPrice * orderline_t.orderedquantity) as totalprice
from product_T
inner join OrderLine_T on Product_T.ProductID=OrderLine_T.ProductID
where orderline_t.OrderID=1 group by Product_T.ProductID, Product_T.ProductStandardPrice


--8
SELECT wc.WorkCenterID, count(wi.employeeid) FROM WorksIn_T wi
Right JOIN (SELECT * FROM WorkCenter_T) wc
ON wc.WorkCenterID = wi.WorkCenterID
GROUP BY wc.WorkCenterID

--9
select workcenterid from WorksIn_T
inner join EmployeeSkills_T on worksin_t.EmployeeID= EmployeeSkills_T.EmployeeID 
where EmployeeSkills_T.SkillID='QC1'

--10

select sum(Product_T.ProductStandardPrice) as totalcost
from Product_T
where productid in (select productid from orderline_t where orderid=1)

--11
SELECT VendorID, MaterialID, SupplyUnitPrice FROM Supplies_T sup
WHERE SupplyUnitPrice >= 4 * (SELECT MaterialStandardPrice FROM RawMaterial_T WHERE sup.MaterialID = MaterialID)

--12
SELECT pr.ProductDescription, pr.ProductStandardPrice, SUM(raw.MaterialStandardPrice * us.QuantityRequired) AS TotCost FROM Product_T pr
INNER JOIN (SELECT * FROM Uses_T) us
ON pr.ProductID = us.ProductID
INNER JOIN (SELECT * FROM RawMaterial_T) raw
ON us.MaterialID = raw.MaterialID
GROUP BY pr.ProductDescription, pr.ProductStandardPrice
--13
SELECT ord.OrderID, SUM(ordl.OrderedQuantity * pr.ProductStandardPrice ) AS TotalDue, pay.PaymentAmount FROM Order_T ord
INNER JOIN (SELECT * FROM OrderLine_T) ordl
ON ord.OrderID = ordl.OrderID
INNER JOIN (SELECT * FROM Product_T) pr
ON ordl.ProductID = pr.ProductID
INNER JOIN (SELECT * FROM Payment_T) pay
ON ord.OrderID = pay.OrderID
GROUP BY ord.OrderID, pay.PaymentAmount

--14
SELECT cus.CustomerID, cus.CustomerName, ordl.OrderedQuantity, prd.ProductDescription FROM Customer_T cus
INNER JOIN (SELECT OrderID, CustomerID FROM Order_T) ord
ON cus.CustomerID = ord.CustomerID
INNER JOIN (SELECT OrderID, ProductID, OrderedQuantity FROM OrderLine_T) ordl
ON ord.OrderID = ordl.OrderID
INNER JOIN (SELECT ProductID, ProductDescription FROM Product_T) prd
ON ordl.ProductID = prd.ProductID
WHERE ProductDescription LIKE '%Computer Desk%' AND ordl.OrderedQuantity > 0;

--15
SELECT DISTINCT CustomerName FROM Customer_T cst
INNER JOIN (SELECT OrderID, CustomerID FROM Order_T  WHERE OrderDate BETWEEN '2018-03-01' AND '2018-03-31') ord
ON cst.CustomerID = ord.CustomerID
INNER JOIN (SELECT OrderID, ProductID FROM OrderLine_T) ordl
ON ord.OrderID = ordl.OrderID
INNER JOIN (SELECT ProductID, ProductLineID FROM Product_T) pr
ON ordl.ProductID = pr.ProductID
WHERE pr.ProductLineID = (SELECT ProductLineID FROM ProductLine_T WHERE ProductLineName = 'Basic')

--16
SELECT cst.CustomerName, sum(ordl.OrderedQuantity) AS 'No. of products' FROM Customer_T cst
INNER JOIN (SELECT OrderID, CustomerID FROM Order_T  WHERE OrderDate BETWEEN '2018-03-01' AND '2018-03-31') ord
ON cst.CustomerID = ord.CustomerID
INNER JOIN (SELECT OrderID, ProductID, OrderedQuantity FROM OrderLine_T) ordl
ON ord.OrderID = ordl.OrderID
INNER JOIN (SELECT ProductID, ProductLineID FROM Product_T) pr
ON ordl.ProductID = pr.ProductID
WHERE pr.ProductLineID = (SELECT ProductLineID FROM ProductLine_T WHERE ProductLineName = 'Basic') 
GROUP BY cst.CustomerName

--17
SELECT f.EmployeeName FROM Employee_T f
INNER JOIN (
SELECT DISTINCT emp.EmployeeSupervisor FROM Employee_T emp
INNER JOIN (SELECT EmployeeID, SkillID FROM EmployeeSkills_T WHERE SkillID = 'BS12') sk
ON emp.EmployeeID = sk.EmployeeID) z
ON f.employeeID = z.EmployeeSupervisor
ORDER BY f.EmployeeName DESC

--18
SELECT sls.SalespersonName, pr.ProductFinish, SUM(OrderedQuantity) AS TotSales FROM Salesperson_T sls
INNER JOIN (SELECT * FROM Order_T) ord
ON sls.SalespersonID = ord.SalespersonID
INNER JOIN (SELECT * FROM OrderLine_T) ordl
ON ord.OrderID = ordl.OrderID
INNER JOIN (SELECT * FROM Product_T) pr
ON ordl.ProductID = pr.ProductID
GROUP BY sls.SalespersonName, pr.ProductFinish

--19
SELECT wc.WorkCenterLocation, COUNT(pi.ProductID) as TotalProducts FROM WorkCenter_T wc
LEFT OUTER JOIN (SELECT * FROM ProducedIn_T) pi
ON wc.WorkCenterID = pi.WorkCenterID
GROUP BY wc.WorkCenterLocation

--20
SELECT CustomerName, COUNT(v.VendorID) as NumVendors FROM Customer_T cs
LEFT JOIN(SELECT * FROM Vendor_T) v
ON cs.CustomerState = v.VendorState
GROUP BY CustomerName

--21
select OrderID from Order_T
except select OrderID from Payment_T

--22
select CustomerState
from Customer_T
where CustomerState not in (
select SalespersonState
from Salesperson_T)

--23
select p.ProductDescription, sum(o.OrderedQuantity) as NumOrders
from OrderLine_T o
right outer join Product_T p on o.ProductID = p.ProductID
group by p.ProductDescription

--24
select c.CustomerID, c.CustomerName, o.OrderID
from Order_T o 
right outer join Customer_T c on o.CustomerID = c.CustomerID

--25
select distinct e.EmployeeID, e.EmployeeName
from Employee_T e 
join EmployeeSkills_T es on e.EmployeeID = es.EmployeeID
join Skill_T s on s.SkillID = es.SkillID
where s.SkillDescription != 'Router'
order by EmployeeName

--26
SELECT O.OrderID, O.OrderedQuantity
FROM Product_T P, OrderLine_T O 
WHERE P.ProductID = O.ProductID AND O.OrderedQuantity > (
SELECT AVG(OrderedQuantity) FROM OrderLine_T OL 
WHERE OL.ProductID = O.ProductID);

--27
select * from Employee_T
where EmployeeDateHired not in (
select max(EmployeeDateHired) from Employee_T
group by EmployeeState)

--28
SELECT P.ProductID, ProductDescription, C.CustomerID, CustomerName, SUM(OL.OrderedQuantity) as TotalOrdered 
FROM Customer_T C, Product_T P, OrderLine_T OL, Order_T O 
WHERE C.CustomerID = O.CustomerID and O.OrderID = OL.OrderID and OL.ProductID = P.ProductID 
GROUP BY P.ProductID, ProductDescription, C.CustomerID, CustomerName 
HAVING SUM(OL.OrderedQuantity) >= ALL (
SELECT SUM(OL2.OrderedQuantity) 
FROM OrderLine_T as OL2, Order_T as O2 
WHERE OL2.ProductID = P.ProductID AND OL2.OrderID = O2.OrderID AND O2.CustomerID <> C.CustomerID 
GROUP BY O2.CustomerID) 
ORDER BY P.ProductID;

--29
select ProductID from OrderLine_T
where OrderedQuantity = (
select top 1 sum(OrderedQuantity) from OrderLine_T
group by ProductID)
