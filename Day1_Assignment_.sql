CREATE DATABASE ECOMMERCEDB;
GO
USE ECOMMERCEDB;
GO

CREATE TABLE Customer( 
    CustomerId INT PRIMARY KEY IDENTITY(1,1),
    CustomerName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    MobileNo VARCHAR(15),
    City VARCHAR(50),
    Address VARCHAR(200),
    IsActive BIT DEFAULT 1,
    CreatedDate DATETIME DEFAULT GETDATE()
);

CREATE TABLE Seller(
    SellerId INT PRIMARY KEY IDENTITY(1,1),
    SellerName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    MobileNo VARCHAR(15),
    City VARCHAR(50),
    Rating DECIMAL(3,2),
    IsActive BIT DEFAULT 1
);

CREATE TABLE Product(
    ProductId INT PRIMARY KEY IDENTITY(1,1),
    ProductName VARCHAR(100) NOT NULL,
    Category VARCHAR(50),
    Price DECIMAL(10,2) CHECK (Price > 0),
    StockQuantity INT CHECK (StockQuantity >= 0),
    SellerId INT FOREIGN KEY REFERENCES Seller(SellerId),
    CreatedDate DATETIME DEFAULT GETDATE()
);

CREATE TABLE Orders(
    OrderId INT PRIMARY KEY IDENTITY(1,1),
    CustomerId INT FOREIGN KEY REFERENCES Customer(CustomerId),
    OrderDate DATETIME DEFAULT GETDATE(),
    OrderStatus VARCHAR(20) DEFAULT 'Pending',
    PaymentMode VARCHAR(20),
    DeliveryCity VARCHAR(50)
);

CREATE TABLE OrderItem(
    OrderItemId INT PRIMARY KEY IDENTITY(1,1),
    OrderId INT FOREIGN KEY REFERENCES Orders(OrderId),
    ProductId INT FOREIGN KEY REFERENCES Product(ProductId),
    Quantity INT CHECK (Quantity > 0),
    UnitPrice DECIMAL(10,2)
);

INSERT INTO Customer (CustomerName, Email, MobileNo, City, Address) VALUES
('Janani', 'janani@gmail.com', '1234567890', 'Kanchipuram', 'ABCD'),
('Naga', 'naga@gmail.com', '2345678912', 'Chennai', 'Tnagar'),
('Hari', 'hari@gmail.com', '3456789123', 'Vellore', 'VIT'),
('Ananya', 'ananya@gmail.com', '9876543210', 'Chennai', 'Anna Nagar'),
('Arvind', 'arvind@gmail.com', '8765432109', 'Bangalore', 'Koramangala'),
('Deepika', 'deepika@gmail.com', '7654321098', 'Hyderabad', 'Banjara Hills');

INSERT INTO Seller (SellerName, Email, MobileNo, City, Rating) VALUES
('Gadgetz', 'gadgetz@gmail.com', '1928374650', 'Chennai', 4.50),
('FashionFest', 'fashionfest@gmail.com', '9876543210', 'Kanchipuram', 4.20),
('Home Things', 'homethings@gmail.com', '8889997771', 'Vellore', 4.80),
('TechWorld', 'techworld@gmail.com', '7776665554', 'Bangalore', 4.60),
('SuperMart', 'supermart@gmail.com', '6665554443', 'Hyderabad', 4.10);

INSERT INTO Product (ProductName, Category, Price, StockQuantity, SellerId) VALUES
('Samsung Galaxy S23', 'Mobile', 65000.00, 50, 1),
('iPhone 14', 'Mobile', 80000.00, 30, 4),
('Dell Laptop', 'Laptop', 55000.00, 20, 4),
('HP Laptop', 'Laptop', 45000.00, 15, 1),
('Nike Shoes', 'Fashion', 4999.00, 100, 2),
('Levis Jeans', 'Fashion', 2999.00, 80, 2),
('Mixer Grinder', 'Home', 2499.00, 30, 3),
('Air Purifier', 'Home', 12000.00, 8, 3),
('OnePlus Nord', 'Mobile', 25000.00, 40, 5);

INSERT INTO Orders (CustomerId, OrderStatus, PaymentMode, DeliveryCity) VALUES
(1, 'Delivered', 'UPI', 'Kanchipuram'),
(2, 'Shipped', 'Credit Card', 'Chennai'),
(3, 'Pending', 'COD', 'Vellore'),
(4, 'Delivered', 'Debit Card', 'Chennai'),
(5, 'Cancelled', 'UPI', 'Bangalore'),
(6, 'Shipped', 'Net Banking', 'Hyderabad');

INSERT INTO OrderItem (OrderId, ProductId, Quantity, UnitPrice) VALUES
(1, 1, 1, 65000.00),
(1, 7, 2, 2499.00),
(2, 5, 1, 4999.00),
(2, 6, 1, 2999.00),
(3, 7, 1, 2499.00),
(3, 8, 1, 12000.00),
(4, 3, 1, 55000.00),
(4, 4, 1, 45000.00),
(5, 2, 1, 80000.00),
(6, 9, 2, 25000.00),
(6, 8, 1, 12000.00);

UPDATE Customer SET City = 'Madurai' WHERE CustomerId = 3;
UPDATE Product SET Price = 60000.00 WHERE ProductId = 3;
UPDATE Orders SET OrderStatus = 'Delivered' WHERE OrderId = 2;

INSERT INTO Product (ProductName, Category, Price, StockQuantity, SellerId)
VALUES ('Old Stock Item', 'Fashion', 199.00, 0, 2);

DELETE FROM Product WHERE ProductName = 'Old Stock Item';
SELECT * FROM Customer;
SELECT * FROM Seller;
SELECT * FROM Product;
SELECT * FROM Orders;
SELECT * FROM OrderItem;
SELECT * FROM Customer WHERE City = 'Chennai';
SELECT * FROM Customer WHERE City != 'Chennai';
SELECT * FROM Product WHERE Price > 50000;
SELECT * FROM Product WHERE Price BETWEEN 10000 AND 60000;
SELECT * FROM Product WHERE Category IN ('Mobile', 'Laptop');
SELECT * FROM Customer WHERE CustomerName LIKE 'A%';
SELECT * FROM Customer WHERE Email LIKE '%gmail%';
SELECT * FROM Product WHERE ProductName LIKE '%Phone%';
SELECT * FROM Orders WHERE OrderStatus = 'Delivered';
SELECT * FROM Product WHERE StockQuantity < 10;
SELECT * FROM Customer WHERE MobileNo IS NOT NULL;
SELECT * FROM Product WHERE Price NOT BETWEEN 10000 AND 50000;
SELECT * FROM Customer WHERE City IN ('Chennai', 'Bangalore');
SELECT * FROM Customer WHERE City = 'Chennai' AND IsActive = 1;
SELECT * FROM Customer WHERE City != 'Hyderabad';
SELECT City, COUNT(*) AS TotalCustomers FROM Customer GROUP BY City;
SELECT Category, COUNT(*) AS TotalProducts FROM Product GROUP BY Category;
SELECT Category, SUM(StockQuantity) AS TotalStock FROM Product GROUP BY Category;
SELECT Category, MAX(Price) AS MaxPrice FROM Product GROUP BY Category;
SELECT Category, MIN(Price) AS MinPrice FROM Product GROUP BY Category;
SELECT Category, AVG(Price) AS AvgPrice FROM Product GROUP BY Category;

SELECT o.CustomerId, c.CustomerName,
       SUM(oi.Quantity * oi.UnitPrice) AS TotalOrderAmount
FROM Orders o
JOIN OrderItem oi ON o.OrderId = oi.OrderId
JOIN Customer c ON o.CustomerId = c.CustomerId
GROUP BY o.CustomerId, c.CustomerName;

SELECT p.ProductId, p.ProductName,
       SUM(oi.Quantity * oi.UnitPrice) AS TotalSales
FROM OrderItem oi
JOIN Product p ON oi.ProductId = p.ProductId
GROUP BY p.ProductId, p.ProductName;

SELECT p.ProductId, p.ProductName,
       SUM(oi.Quantity) AS TotalQuantitySold
FROM OrderItem oi
JOIN Product p ON oi.ProductId = p.ProductId
GROUP BY p.ProductId, p.ProductName;

SELECT Category, COUNT(*) AS TotalProducts
FROM Product
GROUP BY Category
HAVING COUNT(*) > 1;

SELECT o.CustomerId, c.CustomerName,
SUM(oi.Quantity * oi.UnitPrice) AS TotalOrderAmount
FROM Orders o
JOIN OrderItem oi ON o.OrderId = oi.OrderId
JOIN Customer c ON o.CustomerId = c.CustomerId
GROUP BY o.CustomerId, c.CustomerName
HAVING SUM(oi.Quantity * oi.UnitPrice) > 50000;

SELECT s.SellerId, s.SellerName, COUNT(p.ProductId) AS TotalProducts
FROM Seller s
JOIN Product p ON s.SellerId = p.SellerId
GROUP BY s.SellerId, s.SellerName;
SELECT s.SellerId, s.SellerName,
SUM(oi.Quantity * oi.UnitPrice) AS TotalSales
FROM Seller s
JOIN Product p ON s.SellerId = p.SellerId
JOIN OrderItem oi ON p.ProductId = oi.ProductId
GROUP BY s.SellerId, s.SellerName;

SELECT OrderStatus, COUNT(*) AS OrderCount FROM Orders GROUP BY OrderStatus;

SELECT City, COUNT(*) AS CustomerCount
FROM Customer
GROUP BY City
ORDER BY CustomerCount DESC;

SELECT * FROM Product ORDER BY Price ASC;
SELECT * FROM Product ORDER BY Price DESC;
SELECT * FROM Customer ORDER BY City ASC, CustomerName ASC;
SELECT * FROM Orders ORDER BY OrderDate DESC;
SELECT * FROM Product ORDER BY Category ASC, Price DESC;
SELECT TOP 3 * FROM Product ORDER BY Price DESC;
SELECT TOP 5 * FROM Orders ORDER BY OrderDate DESC;
SELECT * FROM Customer ORDER BY IsActive DESC, CustomerName ASC;

SELECT o.OrderId, c.CustomerName, c.City,
o.OrderDate, o.OrderStatus, o.PaymentMode
FROM Orders o
INNER JOIN Customer c ON o.CustomerId = c.CustomerId;

SELECT p.ProductId, p.ProductName, p.Category, p.Price,
s.SellerName, s.City AS SellerCity
FROM Product p
INNER JOIN Seller s ON p.SellerId = s.SellerId;

SELECT oi.OrderItemId, oi.OrderId, p.ProductName,
oi.Quantity, oi.UnitPrice,
(oi.Quantity * oi.UnitPrice) AS TotalAmount
FROM OrderItem oi
INNER JOIN Product p ON oi.ProductId = p.ProductId;

SELECT c.CustomerName, o.OrderId, o.OrderDate, o.OrderStatus,
p.ProductName, p.Category, s.SellerName,
oi.Quantity, oi.UnitPrice,
(oi.Quantity * oi.UnitPrice) AS TotalAmount
FROM Orders o
INNER JOIN Customer c ON o.CustomerId = c.CustomerId
INNER JOIN OrderItem oi ON o.OrderId = oi.OrderId
INNER JOIN Product p ON oi.ProductId = p.ProductId
INNER JOIN Seller s ON p.SellerId = s.SellerId;

SELECT c.CustomerName, c.City,
o.OrderId, o.OrderStatus, o.OrderDate
FROM Customer c
LEFT JOIN Orders o ON c.CustomerId = o.CustomerId;

SELECT c.CustomerName, c.City,
o.OrderId, o.OrderStatus, o.OrderDate
FROM Customer c
RIGHT JOIN Orders o ON c.CustomerId = o.CustomerId;

SELECT c.CustomerName, c.City,
o.OrderId, o.OrderStatus
FROM Customer c
FULL OUTER JOIN Orders o ON c.CustomerId = o.CustomerId;

SELECT c.CustomerName, p.ProductName, p.Price
FROM Customer c
CROSS JOIN Product p;

SELECT * FROM Customer
WHERE CustomerId NOT IN (SELECT DISTINCT CustomerId FROM Orders);

SELECT * FROM Product
WHERE ProductId NOT IN (SELECT DISTINCT ProductId FROM OrderItem);
SELECT s.SellerName, p.ProductName, p.Category, p.Price
FROM Seller s
INNER JOIN Product p ON s.SellerId = p.SellerId
ORDER BY s.SellerName;

SELECT c.CustomerName, p.ProductName, oi.Quantity, oi.UnitPrice
FROM Customer c
INNER JOIN Orders o ON c.CustomerId = o.CustomerId
INNER JOIN OrderItem oi ON o.OrderId = oi.OrderId
INNER JOIN Product p ON oi.ProductId = p.ProductId
ORDER BY c.CustomerName;

SELECT o.OrderId, c.CustomerName,
SUM(oi.Quantity * oi.UnitPrice) AS TotalAmount
FROM Orders o
JOIN OrderItem oi ON o.OrderId = oi.OrderId
JOIN Customer c ON o.CustomerId = c.CustomerId
GROUP BY o.OrderId, c.CustomerName;

SELECT s.SellerName,
SUM(oi.Quantity * oi.UnitPrice) AS TotalSales
FROM Seller s
JOIN Product p ON s.SellerId = p.SellerId
JOIN OrderItem oi ON p.ProductId = oi.ProductId
GROUP BY s.SellerName;

SELECT p.ProductName,
SUM(oi.Quantity) AS TotalQuantitySold
FROM Product p
JOIN OrderItem oi ON p.ProductId = oi.ProductId
GROUP BY p.ProductName;