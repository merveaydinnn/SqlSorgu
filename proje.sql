
SELECT * FROM Orders;
SELECT * FROM [Order Details];
SELECT OrderDate,ShipCountry FROM Orders WHERE OrderDate BETWEEN '1997/05/01' AND '1997/05/31'

SELECT COUNT(CustomerID), Country FROM Customers
GROUP BY Country HAVING COUNT(CustomerID) > 5;
select ShipCountry FROM Orders GROUP BY ShipCountry
SELECT Count(OrderID) AS Sipari�Adedi, ShipCountry, OrderDate FROM Orders   WHERE OrderDate BETWEEN '1997/05/01' AND '1997/05/31'   GROUP BY ShipCountry

--birinci sorgu
 select Count(OrderID) AS Sipari�Adedi ,ShipCountry FROM  Orders  
 WHERE OrderDate BETWEEN '1997/05/01' AND '1997/05/31'  
 GROUP BY  ShipCountry  order by Sipari�Adedi desc 


Select * from Employees where (Select Year(GETDATE( ) ) -Year( BirthDate ) as Yas from Employees ) <60


--ikinci sorgu

Select FirstName,LastName,Title ,  Year(GETDATE( ) ) -Year( BirthDate )  as yas from Employees 
where Year(GETDATE( ) ) -Year( BirthDate )  <60 






--Year(GETDATE)( ) : Bug�n�n tarihini al�r. 
--Year(DogumTarihi) : Tabloda olusturdu�umuz Do�um Tarihi al�r. 

-- sorgu 3

SELECT  c.Country FROM Customers as c
inner join Orders as o on c.CustomerID= o.CustomerID Group by c.Country order by c.Country asc

-- sorgu 4

Select * from [Order Details]
Select * from Products
Select * from Region
select * from Categories


Select c.CategoryName ,Sum(od.Quantity*od.UnitPrice ) gelir from [Order Details] as od
inner join Products as p on p.ProductID=od.ProductID
inner join Categories as c on c.CategoryID=p.ProductID group by c.CategoryName

-- sorgu 5
select * from Orders
select * from Customers
select * from Products
select * from Categories
select * from Suppliers
select * from [Order Details]
select * from  Employees
select sum(Quantity) as adet from [Order Details] 
select (Quantity) as adet from [Order Details]
select Sum(Quantity*UnitPrice) as adet from [Order Details] order by SUM(Quantity*UnitPrice) desc


--sorgu 5 

select * from  Employees where FirstName like 'Nancy' 
select * from Orders
select * from Products
select * from [Order Details]
select * from Customers

select e.FirstName,o.OrderID, o.EmployeeID, p.ProductName from Products as p 
inner join  [Order Details] as od on p.ProductID =od.ProductID
inner join  Orders as o  on  od.OrderID=o.OrderID
inner join Employees as e on o.EmployeeID=e.EmployeeID where e.FirstName like 'Nancy' 

-- sorgu5
Select (e.FirstName +e.LastName)as �ali�an , p.ProductName , SUM(od.Quantity) as Adet  , SUM(od.Quantity*od.UnitPrice) as ToplamTutar from Products   as p 
inner join  [Order Details] as od on p.ProductID =od.ProductID
inner join  Orders as o  on  od.OrderID=o.OrderID
inner join Employees as e on o.EmployeeID=e.EmployeeID where e.FirstName like 'Nancy' 
group by e.FirstName+e.LastName ,p.ProductName 
order by SUM(od.Quantity*od.UnitPrice) desc

-- sorgu6 

select ShippedDate,RequiredDate, datediff(DAY,ShippedDate,RequiredDate) as dt  from Orders 

select CustomerID,ShipName,ShipAddress,ShipCity,datediff(DAY,ShippedDate,RequiredDate) as dt
from Orders where datediff(DAY,ShippedDate,RequiredDate) > 0

--DATEF�FF VER�LEN �K� TAR�H ARASINDAK� FARKI ALIR

---sorgu 7
select count(OrderId) as Sipari�Adeti from Orders 
select count(OrderId) as Sipari�Adeti, ShipCity from Orders group by ShipCity order by COUNT(OrderID) desc


---sorgu 8

 select * from Products
 select AVG(UnitPrice) as ortalamaFiyat  from Products
 

 select ProductName , UnitPrice from Products
 where UnitPrice > (select AVG(UnitPrice) from Products )

 --sorgu 9 
select * from Customers
 select * from Orders

  -- m��teri tablosuna veri ekliyorum
 insert into Customers (CustomerID,CompanyName)
 Values  ('MrvA','Ayd�n Fac')

  -- ekledi�im veriyle sipari� vermiyorum
select  o.OrderID,c.CustomerID , c.CustomerID  ,c.CompanyName from Customers as c
left join Orders as o on c.CustomerID=o.CustomerID

 --  left join de customer ekli olmas�na ra�men bu m��teri hi� sipari� vermemi�se kar��s�na null yaz�yor. m��teri var ama sipari� yok



-- sipari� tablosuna m��terinin bilgileri olmadan ekleme yap�yorum 

 insert into Orders(ShipName,ShipAddress)
  Values ('Merve ayd�n','Kayseri')

--rigth join 
select  o.OrderID,o.CustomerID, c.CustomerID ,c.CompanyName from Customers as c
right join Orders as o on c.CustomerID=o.CustomerID

 --  right join de sipari� verilmi� ama m��terinin bilgileri yok kar��s�na null getiriyor 


 --inner join 
select  o.OrderID, o.CustomerID , c.CustomerID ,c.CompanyName from Customers as c
inner join Orders as o on c.CustomerID=o.CustomerID
order BY o.OrderID;




-- inner joinde ise her ikisinde olan veriyi getiriyor null de�i�kenleri g�stermiyor �rn hi� sipari� vermemi� m��teri g�z�km�yor , 
--yada sipari� veren m��terinn ad� soy ad� yoksa custemer tablosuna eklemmemi�se g�stermiyor.

select * from Orders
select * from Customers

-- order tablosunda 831 sat�r var
-- custemer tablosunda ise 92 sat�r var 
--cross join ile 831*92 =76452 sat�r getiriyor 
-- order tablosundaki t�m sat�rlar� customer tablosunda ki her sat�rla ili�kilendirdi. Kartezyenini ald�
SELECT  o.OrderID, o.CustomerID , c.CustomerID ,c.CompanyName ,o.ShipAddress
FROM Orders as o, Customers as c