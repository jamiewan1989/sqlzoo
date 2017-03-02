/* Q1 */
SELECT FirstName, EmailAddress, CompanyName
FROM Customer
WHERE CompanyName = 'Bike World';

/* Q2 */
SELECT CompanyName 
FROM Customer a
JOIN CustomerAddress b
  ON a.customerID = b.customerID
JOIN Address c
  ON b.AddressID = c.AddressID
WHERE city = "Dallas";

/* Q3 */
SELECT sum(OrderQty)
FROM SalesOrderHeader h
JOIN SalesOrderDetail d
  ON h.SalesOrderID = d.SalesOrderID
JOIN Product p
  ON d.productID = p.ProductID
WHERE listprice > 1000;

/* Q4 */
SELECT b.CompanyName
FROM SalesOrderHeader a
JOIN Customer b
  ON a.CustomerID = b.CustomerID
WHERE subtotal+taxamt+freight>10000;

/* Q5 */
SELECT sum(OrderQty)
FROM SalesOrderHeader a
JOIN Customer b
  ON a.CustomerID= b.CustomerID
JOIN SalesOrderDetail c
  ON a.SalesOrderID = c.SalesOrderID
JOIN Product d
  ON c.ProductID = d.ProductID
WHERE d.Name = 'Racing Socks, L'
  AND companyname = 'Riding Cycles'
  
 /* Q6 */
SELECT  a.SalesOrderID, count(*)
FROM SalesOrderHeader a
JOIN SalesOrderDetail b
  ON a.SalesOrderID = b.SalesOrderID
GROUP BY a.SalesOrderID
Having COUNT(a.SalesOrderID) =1;

/* Q7 */
SELECT d.name, companyname
FROM SalesOrderHeader a
JOIN Customer b
  ON a.CustomerID = b.CustomerID
JOIN SalesOrderDetail c
  ON a.SalesOrderID = c.SalesOrderID
JOIN Product d
  ON c.ProductID = d.ProductID
JOIN ProductModel e
  ON d.ProductModelID = e.ProductModelID 
WHERE e.name= 'Racing Socks';

/* Q10 */
SELECT sum(c.OrderQty)
FROM SalesOrderHeader a
JOIN Address b
  ON a.ShipToAddressID = b.AddressID
JOIN SalesOrderDetail c
  ON a.SalesOrderID = c.SalesOrderID
JOIN Product d
  ON c.ProductID = d.ProductID
JOIN ProductCategory e
  ON d.ProductCategoryID = e.ProductCategoryID
WHERE b.City = "London"
  AND e.Name = 'Cranksets';
