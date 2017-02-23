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
