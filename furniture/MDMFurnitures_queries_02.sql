USE PVFC

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