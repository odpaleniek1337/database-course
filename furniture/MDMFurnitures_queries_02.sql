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
--nie mam pojecia skad wziac manager's birth, name i tak dalej :/ bo w tej tabeli employee_T nie ma nic o menagerze

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
select workcenterid, count( worksin_t.employeeid)
from WorksIn_T
where workcenterid=worksin_t.WorkCenterID
group by workcenterid
--tylko nie ma tego trzecieko centerid nie wiem czemu

--9
select workcenterid from WorksIn_T
inner join EmployeeSkills_T on worksin_t.EmployeeID= EmployeeSkills_T.EmployeeID 
where EmployeeSkills_T.SkillID='QC1'

--10

select sum(Product_T.ProductStandardPrice) as totalcost
from Product_T
where productid in (select productid from orderline_t where orderid=1)

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
