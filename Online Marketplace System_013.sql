# module 1 

CREATE DATABASE EasyKart_013;
show databases;

USE EasyKart_013;
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    city VARCHAR(50),
    registration_date DATE
);

DESC Customers;


CREATE TABLE Sellers (
    seller_id INT PRIMARY KEY AUTO_INCREMENT,
    seller_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    city VARCHAR(50),
    registration_date DATE
);
DESC Sellers;
CREATE TABLE Categories (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(100) UNIQUE NOT NULL
);
DESC Categories;

CREATE TABLE Products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(150) NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL,
    stock INT DEFAULT 0,
    category_id INT,
    seller_id INT,

    FOREIGN KEY (category_id)
    REFERENCES Categories(category_id),

    FOREIGN KEY (seller_id)
    REFERENCES Sellers(seller_id)
);
DESC Products;


CREATE TABLE Orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    order_date DATE NOT NULL,
    order_status VARCHAR(30) DEFAULT 'Pending',

    FOREIGN KEY (customer_id)
    REFERENCES Customers(customer_id)
);
DESC Orders;


CREATE TABLE Order_Items (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    quantity INT NOT NULL,
    price_at_purchase DECIMAL(10,2) NOT NULL,

    FOREIGN KEY (order_id)
    REFERENCES Orders(order_id),

    FOREIGN KEY (product_id)
    REFERENCES Products(product_id)
);
DESC Order_Items;

CREATE TABLE Reviews (
    review_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    product_id INT,
    rating INT,
    review_text TEXT,
    review_date DATE,

    FOREIGN KEY (customer_id)
    REFERENCES Customers(customer_id),

    FOREIGN KEY (product_id)
    REFERENCES Products(product_id)
);
DESC Reviews;

ALTER TABLE Reviews
ADD CONSTRAINT CHECK (rating BETWEEN 1 AND 5);


CREATE TABLE Returns (
    return_id INT PRIMARY KEY AUTO_INCREMENT,
    order_item_id INT,
    return_date DATE,
    return_status VARCHAR(30),

    FOREIGN KEY (order_item_id)
    REFERENCES Order_Items(order_item_id)
);
DESC Returns;
SHOW tables;

INSERT INTO Customers
(customer_name, email, city, registration_date)
VALUES
('Aarav', 'aarav@gmail.com', 'Delhi', '2026-01-05'),
('Priya', 'priya@gmail.com', 'Gurugram', '2026-01-10'),
('Rohan', 'rohan@gmail.com', 'Noida', '2026-02-05'),
('Simran', 'simran@gmail.com', 'Delhi', '2026-02-15'),
('Kabir', 'kabir@gmail.com', 'Jaipur', '2026-03-01'),
('Ananya', 'ananya@gmail.com', 'Delhi', '2026-03-10');


INSERT INTO Sellers
(seller_name, email, city, registration_date)
VALUES
('TechWorld', 'tech@gmail.com', 'Delhi', '2026-01-01'),
('FashionHub', 'fashion@gmail.com', 'Noida', '2026-01-05'),
('HomeStyle', 'home@gmail.com', 'Gurugram', '2026-01-10');

INSERT INTO Categories (category_name)
VALUES
('Electronics'),
('Fashion'),
('Home Appliances');

INSERT INTO Products
(product_name, description, price, stock, category_id, seller_id)
VALUES
('Laptop', 'High performance laptop', 55000, 20, 1, 1),
('Mobile', 'Smartphone with good camera', 25000, 30, 1, 1),
('Headphones', 'Wireless headphones', 2000, 50, 1, 1),
('T Shirt', 'Cotton casual t shirt', 800, 100, 2, 2),
('Jeans', 'Denim jeans', 1500, 60, 2, 2),
('Mixer', 'Kitchen mixer grinder', 3000, 25, 3, 3),
('Sofa', 'Comfortable living room sofa', 18000, 10, 3, 3);

INSERT INTO Orders
(customer_id, order_date, order_status)
VALUES
(1, '2026-01-15', 'Delivered'),
(2, '2026-01-20', 'Delivered'),
(1, '2026-02-10', 'Delivered'),
(3, '2026-02-15', 'Delivered'),
(4, '2026-02-20', 'Delivered'),
(2, '2026-03-05', 'Delivered'),
(5, '2026-03-10', 'Delivered'),
(1, '2026-03-15', 'Delivered'),
(3, '2026-03-20', 'Shipped'),
(6, '2026-04-05', 'Delivered'),
(4, '2026-04-10', 'Delivered'),
(5, '2026-04-15', 'Delivered');


INSERT INTO Order_Items
(order_id, product_id, quantity, price_at_purchase)
VALUES
(1, 1, 1, 55000),
(1, 3, 2, 2000),
(2, 4, 2, 800),
(3, 2, 1, 25000),
(3, 3, 1, 2000),
(4, 5, 1, 1500),
(5, 6, 1, 3000),
(6, 4, 3, 800),
(7, 7, 1, 18000),
(8, 1, 1, 55000),
(9, 2, 1, 25000),
(10, 3, 2, 2000),
(11, 5, 2, 1500),
(12, 6, 1, 3000);

INSERT INTO Reviews
(customer_id, product_id, rating, review_text, review_date)
VALUES
(1, 1, 5, 'Excellent laptop', '2026-01-20'),
(2, 4, 4, 'Good quality', '2026-01-25'),
(1, 3, 5, 'Great sound', '2026-02-12'),
(3, 5, 3, 'Average product', '2026-02-18'),
(4, 6, 4, 'Works well', '2026-02-25'),
(5, 7, 5, 'Very comfortable', '2026-03-15');


INSERT INTO Returns
(order_item_id, return_date, return_status)
VALUES
(4, '2026-02-15', 'Accepted'),
(7, '2026-02-25', 'Requested');

SELECT * FROM Products;
SELECT * FROM Orders;
SELECT * FROM Order_Items;
SELECT * FROM Reviews;
SELECT * FROM Returns;

# module 2 


# CALCULATE TOTAL SALES

SELECT
    SUM(order_items.quantity * order_items.price_at_purchase) AS Total_Sales
FROM Orders 
JOIN Order_Items 
    ON orders.order_id = order_items.order_id
WHERE orders.order_status = 'Delivered';

# Finding top 5 best-selling products

SELECT
    p.product_name,
    SUM(oi.quantity) AS Total_Quantity_Sold
FROM Products p
JOIN Order_Items oi
    ON p.product_id = oi.product_id
JOIN Orders o
    ON oi.order_id = o.order_id
WHERE o.order_status = 'Delivered'
GROUP BY p.product_id, p.product_name
ORDER BY Total_Quantity_Sold DESC
LIMIT 5;


# Analysing category-wise sales

SELECT
    c.category_name,
    SUM(oi.quantity * oi.price_at_purchase) AS Total_Revenue
FROM Categories c
JOIN Products p
    ON c.category_id = p.category_id
JOIN Order_Items oi
    ON p.product_id = oi.product_id
JOIN Orders o
    ON oi.order_id = o.order_id
WHERE o.order_status = 'Delivered'
GROUP BY c.category_id, c.category_name
ORDER BY Total_Revenue DESC;



# Calculating average product ratings

SELECT p.product_name, ROUND(AVG(r.rating), 2) AS Average_Rating
FROM Products p
JOIN Reviews r
    ON p.product_id = r.product_id
GROUP BY p.product_id, p.product_name
ORDER BY Average_Rating DESC;

# Analysing seller performance

SELECT
    s.seller_name,
    SUM(oi.quantity * oi.price_at_purchase) AS Total_Revenue
FROM Sellers s
JOIN Products p
    ON s.seller_id = p.seller_id
JOIN Order_Items oi
    ON p.product_id = oi.product_id
JOIN Orders o
    ON oi.order_id = o.order_id
WHERE o.order_status = 'Delivered'
GROUP BY s.seller_id, s.seller_name
ORDER BY Total_Revenue DESC;



# Calculating Month-wise Total Sales Revenue

SELECT MONTH(order_date) AS Sales_Month, SUM(quantity * price_at_purchase) AS Monthly_Sales
FROM Orders
JOIN Order_Items USING (order_id)
WHERE order_status = 'Delivered'
GROUP BY MONTH(order_date)
ORDER BY Sales_Month;


# Calculating Overall Customer Satisfaction Score

SELECT ROUND(AVG(rating), 2) AS Overall_Satisfaction_Score
FROM Reviews;



# module 3 :


# Query 1: Finding each customers first purchase date

SELECT customer_id, MIN(order_date) AS First_Purchase_Date 
FROM Orders
GROUP BY customer_id;

# Query 2: Grouping customers according to their first purchase month

SELECT customer_id, DATE_FORMAT(MIN(order_date), '%Y-%m') AS Cohort_Month
FROM Orders
GROUP BY customer_id;

# NOTE: Query 1 extracts the complete date while Query 2 extracts only the year and month from that date

# Query 3: Finding Monthly Active Customers

SELECT DATE_FORMAT(orders.order_date, '%Y-%m') AS Activity_Month, COUNT(DISTINCT orders.customer_id) AS Active_Customers
FROM Orders 
WHERE orders.order_status = 'Delivered'
GROUP BY DATE_FORMAT(orders.order_date, '%Y-%m')
ORDER BY Activity_Month;


# Query 4: Calculate Customer Retention Percentage ( basically , calculating how many customers from a particular cohort continue purchasing in later months)

WITH FirstPurchase AS (
    SELECT customer_id, MIN(order_date) AS First_Date
    FROM Orders
    WHERE order_status = 'Delivered'
    GROUP BY customer_id
),
CohortSize AS (
    SELECT
        DATE_FORMAT(First_Date, '%Y-%m') AS Cohort_Month,
        COUNT(*) AS Total_Customers
    FROM FirstPurchase
    GROUP BY Cohort_Month
),
Activity AS (
    SELECT
        DATE_FORMAT(fp.First_Date, '%Y-%m') AS Cohort_Month,
        DATE_FORMAT(o.order_date, '%Y-%m') AS Activity_Month,
        COUNT(DISTINCT o.customer_id) AS Active_Customers
    FROM FirstPurchase fp
    JOIN Orders o ON fp.customer_id = o.customer_id
    WHERE o.order_status = 'Delivered'
    GROUP BY Cohort_Month, Activity_Month
)
SELECT
    a.Cohort_Month,
    a.Activity_Month,
    a.Active_Customers,
    c.Total_Customers,
    ROUND(a.Active_Customers * 100 / c.Total_Customers, 2)
        AS Retention_Percentage
FROM Activity a
JOIN CohortSize c ON a.Cohort_Month = c.Cohort_Month
ORDER BY a.Cohort_Month, a.Activity_Month;




# module 4

# Composite index on Orders

CREATE INDEX idx_orders_customer_date
ON Orders(customer_id, order_date);


# Composite index on Products

CREATE INDEX idx_category_price
ON Products(category_id, price);


# Creating FULLTEXT index

CREATE FULLTEXT INDEX idx_product_search
ON Products(product_name, description);

# Testing FULLTEXT search

SELECT product_name, description
FROM Products
WHERE MATCH(product_name, description)
AGAINST ('laptop');


## Compare execution plans using EXPLAIN

#Execution Plan Before Composite Indexing

EXPLAIN
SELECT *FROM Orders
WHERE customer_id = 1 AND order_date >= '2026-02-01';

#Execution Plan After Composite Indexing
# CREATE COMPOSITE INDEX FIRST 

EXPLAIN
SELECT * FROM Orders
WHERE customer_id = 1 AND order_date >= '2026-02-01';


## Demonstrate low-selectivity index


# identifying the number of orders under each status

SELECT order_status, COUNT(*) AS Total_Orders 
FROM Orders
GROUP BY order_status;

# Checking execution plan before indexing order status

EXPLAIN
SELECT * FROM Orders
WHERE order_status = 'Delivered';



# create an index on the low-selectivity column (order status) for comparison

CREATE INDEX idx_order_status
ON Orders(order_status);


# Checking execution plan after indexing order status

EXPLAIN
SELECT * FROM Orders
WHERE order_status = 'Delivered';


# module 5


# Query 1 : Create Seller Performance View

CREATE VIEW Seller_Performance_View AS

SELECT
    s.seller_id,
    s.seller_name,
    sales.total_sales AS Total_Sales,
    ratings.average_rating AS Average_Rating,
    returns_data.return_rate AS Return_Rate_Percentage

FROM Sellers s

LEFT JOIN (
    SELECT p.seller_id,
           SUM(oi.quantity * oi.price_at_purchase) AS total_sales
    FROM Products p
    JOIN Order_Items oi ON p.product_id = oi.product_id
    JOIN Orders o ON oi.order_id = o.order_id
    WHERE o.order_status = 'Delivered'
    GROUP BY p.seller_id
) sales ON s.seller_id = sales.seller_id

LEFT JOIN (
    SELECT p.seller_id,
           ROUND(AVG(r.rating), 2) AS average_rating
    FROM Products p
    JOIN Reviews r ON p.product_id = r.product_id
    GROUP BY p.seller_id
) ratings ON s.seller_id = ratings.seller_id

LEFT JOIN (
    SELECT p.seller_id,
           ROUND(COUNT(DISTINCT r.return_id) * 100.0 /
           COUNT(DISTINCT oi.order_item_id), 2) AS return_rate
    FROM Products p
    JOIN Order_Items oi ON p.product_id = oi.product_id
    JOIN Orders o ON oi.order_id = o.order_id
    LEFT JOIN Returns r ON oi.order_item_id = r.order_item_id
    WHERE o.order_status = 'Delivered'
    GROUP BY p.seller_id
) returns_data ON s.seller_id = returns_data.seller_id;


# Query 2: Display Seller Performance View

SELECT * FROM Seller_Performance_View;


# Query 3: Create Customer Lifetime Value View

CREATE VIEW Customer_Lifetime_Value_View AS

SELECT c.customer_id, c.customer_name, COUNT(DISTINCT o.order_id) AS Total_Orders, 
        SUM(oi.quantity * oi.price_at_purchase) AS Lifetime_Value

FROM Customers c

LEFT JOIN Orders o
    ON c.customer_id = o.customer_id
    AND o.order_status = 'Delivered'

LEFT JOIN Order_Items oi
    ON o.order_id = oi.order_id

GROUP BY
    c.customer_id,
    c.customer_name;
    
    
    
# Query 4: Display Customer Lifetime Value

SELECT * FROM Customer_Lifetime_Value_View
ORDER BY Lifetime_Value DESC;

# Query 5: Create Summary Table (Materialized View)

CREATE TABLE Customer_Lifetime_Summary (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    total_orders INT,
    lifetime_value DECIMAL(12,2)
);

# Query 6: Create Stored Procedure to Refresh Summary Table

DELIMITER //

CREATE PROCEDURE Refresh_Customer_Lifetime_Summary()
BEGIN

    TRUNCATE TABLE Customer_Lifetime_Summary;

    INSERT INTO Customer_Lifetime_Summary
    (
        customer_id,
        customer_name,
        total_orders,
        lifetime_value
    )

    SELECT
        c.customer_id,
        c.customer_name,
        COUNT(DISTINCT o.order_id),
        COALESCE(SUM(oi.quantity * oi.price_at_purchase), 0)

    FROM Customers c

    LEFT JOIN Orders o
        ON c.customer_id = o.customer_id
        AND o.order_status = 'Delivered'

    LEFT JOIN Order_Items oi
        ON o.order_id = oi.order_id

    GROUP BY c.customer_id, c.customer_name;

END //

DELIMITER ;


# Query 7: Executing Stored Procedure

CALL Refresh_Customer_Lifetime_Summary();

# Query 8: Display the summary table

SELECT * FROM Customer_Lifetime_Summary
ORDER BY lifetime_value DESC;



## module 6


# Query 1: Rank Top 3 Products in Each Category

WITH Product_Revenue AS (
    SELECT
        c.category_name,
        p.product_name,
        SUM(oi.quantity * oi.price_at_purchase) AS Revenue

    FROM Products p
    JOIN Categories c
        ON p.category_id = c.category_id
    JOIN Order_Items oi
        ON p.product_id = oi.product_id
    JOIN Orders o
        ON oi.order_id = o.order_id

    WHERE o.order_status = 'Delivered'

    GROUP BY
        c.category_name,
        p.product_id,
        p.product_name
),

Ranked_Products AS (
    SELECT
        category_name,
        product_name,
        Revenue,

        RANK() OVER (
            PARTITION BY category_name
            ORDER BY Revenue DESC
        ) AS Product_Rank

    FROM Product_Revenue
)

SELECT *
FROM Ranked_Products
WHERE Product_Rank <= 3
ORDER BY category_name, Product_Rank;

# Query 2: Month-over-Month Sales Growth using LAG()

WITH Monthly_Sales AS (
    SELECT
        MONTH(order_date) AS Sales_Month,
        SUM(quantity * price_at_purchase) AS Monthly_Revenue
    FROM Orders
    JOIN Order_Items USING (order_id)
    WHERE order_status = 'Delivered'
    GROUP BY MONTH(order_date)
)

SELECT
    Sales_Month,
    Monthly_Revenue,

    LAG(Monthly_Revenue) OVER (
        ORDER BY Sales_Month
    ) AS Previous_Month_Revenue,

    ROUND(
        (Monthly_Revenue - LAG(Monthly_Revenue) OVER (
            ORDER BY Sales_Month
        )) * 100.0 /
        NULLIF(LAG(Monthly_Revenue) OVER (
            ORDER BY Sales_Month
        ), 0),
        2
    ) AS Growth_Percentage

FROM Monthly_Sales
ORDER BY Sales_Month;



# Query 3: Calculate 3-Month Moving Average of Revenue

SELECT
    Sales_Month,
    Monthly_Revenue,

    ROUND(
        AVG(Monthly_Revenue) OVER (
            ORDER BY Sales_Month
            ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
        ), 2
    ) AS Moving_Average

FROM (
    SELECT
        MONTH(order_date) AS Sales_Month,
        SUM(quantity * price_at_purchase) AS Monthly_Revenue
    FROM Orders
    JOIN Order_Items USING (order_id)
    WHERE order_status = 'Delivered'
    GROUP BY MONTH(order_date)
) AS Monthly_Sales

ORDER BY Sales_Month;


# Query 4: Find the first purchase date of each customer using the MIN() window function

SELECT DISTINCT
    customer_id, 
    MIN(order_date) OVER (
        PARTITION BY customer_id
    ) AS First_Purchase_Date

FROM Orders
WHERE order_status = 'Delivered'
ORDER BY customer_id;


# Query 5: Divide Customers into Spending Quartiles using NTILE(4)

SELECT customer_id, SUM(oi.quantity * oi.price_at_purchase) AS Total_Spending,
	NTILE(4) OVER (
        ORDER BY SUM(oi.quantity * oi.price_at_purchase) DESC
    ) AS Spending_Quartile

FROM Orders o
JOIN Order_Items oi ON o.order_id = oi.order_id
WHERE o.order_status = 'Delivered'
GROUP BY customer_id
ORDER BY Total_Spending DESC;











































































































































   

































