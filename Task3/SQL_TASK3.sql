create database ecommercesystem;
use ecommercesystem;
drop database ecommercesystem;


-- Creating Tables
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    city VARCHAR(100)
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(100),
    price DECIMAL(10,2)
);

CREATE TABLE Order_Items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    subtotal DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

CREATE TABLE Sellers (
    seller_id INT PRIMARY KEY,
    seller_name VARCHAR(100),
    city VARCHAR(100)
);

-- Sample Data Insertion
INSERT INTO Customers VALUES (1, 'John Doe', 'john@example.com', 'New York');
INSERT INTO Customers VALUES (2, 'Jane Smith', 'jane@example.com', 'Los Angeles');
INSERT INTO Customers VALUES (3, 'Alice Brown', 'alice@example.com', 'Chicago');

INSERT INTO Orders VALUES (101, 1, '2024-02-15', 500.00);
INSERT INTO Orders VALUES (102, 2, '2024-03-10', 300.00);

INSERT INTO Products VALUES (201, 'Laptop', 'Electronics', 1000.00);
INSERT INTO Products VALUES (202, 'Phone', 'Electronics', 500.00);

INSERT INTO Order_Items VALUES (301, 101, 201, 1, 1000.00);
INSERT INTO Order_Items VALUES (302, 102, 202, 1, 500.00);

INSERT INTO Sellers VALUES (401, 'Best Buy', 'New York');
INSERT INTO Sellers VALUES (402, 'Amazon', 'Los Angeles');

-- Queries Execution

-- 1. Retrieve all customers along with their corresponding orders (including those who haven't ordered)
SELECT c.*, o.order_id, o.order_date, o.total_amount 
FROM Customers c 
LEFT JOIN Orders o ON c.customer_id = o.customer_id;

-- 2. List all orders along with product names and their quantities
SELECT o.order_id, p.product_name, oi.quantity
FROM Orders o
JOIN Order_Items oi ON o.order_id = oi.order_id
JOIN Products p ON oi.product_id = p.product_id; 

-- 3. Find the total number of orders placed by each customer
SELECT customer_id, count(order_id) as total_orders
from Orders
group by customer_id;

-- 4. Find the total number of products available in each category
select category, count(product_id) as total_products
from Products
group by category;

-- 5. Retrieve order details for last 30 days
select c.name, o.order_id, o.total_amount
from Orders o 
join Customers c on o.customer_id = c.customer_id
where o.order_date >= curdate() - interval 30 day;


-- 6. Retrieve seller names who sell a specific product (e.g., 'Laptop')
select s.seller_name from Sellers s
join Products p on p.product_name = 'Laptop';

-- 7. Show all customers who have never placed an order
select * from Customers
where customer_id not in (select distinct customer_id from Orders);

-- 8. Retrieve orders where total amount is greater than average order total
select * from Orders
where total_amount > (select avg(total_amount) from Orders);

-- 9. Find customers who have placed at least two orders
select customer_id from Orders
group by customer_id
having count(order_id) >= 2;

-- 10. Find the top 3 most ordered products based on quantity sold
select product_id, sum(quantity) as total_quantity
from Order_Items
group by product_id
order by total_quantity desc
limit 3;

-- 11. Display product names that are sold by multiple sellers
select product_name
from Products
group by product_name
having count(distinct seller_id) > 1;

-- 12. Retrieve sellers who have never sold any product
select * from Sellers
where seller_id not in (select distinct seller_id from Products);

-- 13. Find all products that have never been ordered
SELECT * FROM Products 
WHERE product_id NOT IN (SELECT DISTINCT product_id FROM Order_Items);

-- 14. Retrieve names of customers who have placed the highest number of orders
SELECT c.name 
FROM Customers c 
JOIN Orders o ON c.customer_id = o.customer_id 
GROUP BY c.customer_id 
ORDER BY COUNT(o.order_id) DESC 
LIMIT 1;

-- 15. Find all customers who have ordered more than 5 different products
SELECT customer_id 
FROM Order_Items 
GROUP BY customer_id 
HAVING COUNT(DISTINCT product_id) > 5;

-- 16. Find products sold by at least two different sellers but never ordered
SELECT product_id 
FROM Products 
GROUP BY product_id 
HAVING COUNT(DISTINCT seller_id) > 1 AND NOT EXISTS (SELECT * FROM Order_Items WHERE Order_Items.product_id = Products.product_id);

-- 17. Find the customer who has spent the most money overall
SELECT customer_id, SUM(total_amount) AS total_spent 
FROM Orders 
GROUP BY customer_id 
ORDER BY total_spent DESC 
LIMIT 1;


-- 18. Find customers who have either placed an order or live in the same city as a seller
SELECT * FROM Customers 
WHERE customer_id IN (SELECT DISTINCT customer_id FROM Orders) 
UNION 
SELECT * FROM Customers 
WHERE city IN (SELECT DISTINCT city FROM Sellers);

-- 19. Retrieve all products in stock or ordered at least once
SELECT product_id FROM Products 
WHERE product_id IN (SELECT DISTINCT product_id FROM Order_Items) 
UNION 
SELECT product_id FROM Products;

-- 20. Retrieve products that have been both ordered and are currently in stock
SELECT product_id FROM Order_Items 
INTERSECT 
SELECT product_id FROM Products;

-- 21. Find customers who have both placed an order and live in a seller’s city
SELECT customer_id FROM Orders 
INTERSECT 
SELECT customer_id FROM Customers WHERE city IN (SELECT city FROM Sellers);

-- 22. Retrieve customers who placed at least one order in each available year
SELECT customer_id FROM Orders 
GROUP BY customer_id, YEAR(order_date) 
HAVING COUNT(DISTINCT YEAR(order_date)) = (SELECT COUNT(DISTINCT YEAR(order_date)) FROM Orders);
