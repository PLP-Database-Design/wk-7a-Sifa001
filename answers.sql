-- Question 1 Achieving 1NF (First Normal Form) 
CREATE DATABASE order_management;
-- PRODUCT DETAIL TABLE
CREATE TABLE ProductDetail (
    OrderID INT,
    CustomerName VARCHAR(50),
    Products VARCHAR(255)
);

-- INSERTING DATA
INSERT INTO ProductDetail (OrderID, CustomerName, Products)
VALUES 
    (101, 'John Doe', 'Laptop, Mouse'),
    (102, 'Jane Smith', 'Tablet, Keyboard, Mouse'),
    (103, 'Emily Clark', 'Phone');

SELECT * FROM ProductDetail;

-- ACHIEVING 1NF
-- Create new normalized table
CREATE TABLE NormalizedProductDetail (
    OrderProductID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID INT,
    CustomerName VARCHAR(50),
    Product VARCHAR(50)  -- Single product per row
);

-- INSERTING DATA INTO NORMALIZED TABLE IN 1NF Format
-- Each product is inserted as a separate row
-- This ensures that each cell contains atomic values and there are no repeating groups
INSERT INTO NormalizedProductDetail (OrderID, CustomerName, Product)
VALUES 
    (101, 'John Doe', 'Laptop'),
    (101, 'John Doe', 'Mouse'),
    (102, 'Jane Smith', 'Tablet'),
    (102, 'Jane Smith', 'Keyboard'),
    (102, 'Jane Smith', 'Mouse'),
    (103, 'Emily Clark', 'Phone');


-- Question 2 Achieving 2NF (Second Normal Form)

-- ORDER DETAILS TABLE
CREATE TABLE OrderDetails (
    OrderID INT,
    CustomerName VARCHAR(50),
    Product VARCHAR(50),
    Quantity INT
);

-- INSERTING DATA
INSERT INTO OrderDetails (OrderID, CustomerName, Product, Quantity)
VALUES 
    (101, 'John Doe', 'Laptop', 2),
    (101, 'John Doe', 'Mouse', 1),
    (102, 'Jane Smith', 'Tablet', 3),
    (102, 'Jane Smith', 'Keyboard', 1),
    (102, 'Jane Smith', 'Mouse', 2),
    (103, 'Emily Clark', 'Phone', 1);

SELECT * FROM OrderDetails;

-- ACHIEVING 2NF
-- 1. Create Orders table (removes partial dependency)
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(50)
);

-- 2. Create OrderItems table (transaction details)
CREATE TABLE OrderItems (
    OrderItemID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID INT,
    Product VARCHAR(50),
    Quantity INT,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- 3. Migrate the data
INSERT INTO Orders (OrderID, CustomerName)
SELECT DISTINCT OrderID, CustomerName FROM OrderDetails;

INSERT INTO OrderItems (OrderID, Product, Quantity)
SELECT OrderID, Product, Quantity FROM OrderDetails;

-- Check Orders table
SELECT * FROM Orders;

-- Check OrderItems table
SELECT * FROM OrderItems;