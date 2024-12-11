CREATE DATABASE abc_orders;

USE abc_orders;

SELECT *
FROM orders
LIMIT 10;

DESCRIBE orders;
DESCRIBE products;
DESCRIBE account;

SET SQL_SAFE_UPDATES = 0;


UPDATE orders
SET order_date = STR_TO_DATE(order_date,'%m/%d/%Y'),
 ship_date = STR_TO_DATE(ship_date,'%m/%d/%Y');
 
 ALTER TABLE orders
 MODIFY COLUMN order_date date,
 MODIFY COLUMN ship_date date;
 
 SELECT COUNT(*)
 FROM orders
 WHERE order_no IS NULL;
 
 -- Checking for duplicates
 SELECT order_no, COUNT(order_no)
 FROM orders
 GROUP BY order_no
 HAVING COUNT(order_no)>1;
 
 SELECT *
 FROM orders
 WHERE order_no = '5768-2' OR order_no = '6159-2'; 
 
 SET SQL_SAFE_UPDATES = 1;
 

-- What is the total revenue generated each product category?
SELECT product_category,
		ROUND(SUM(total),2) AS Revenue
 FROM orders
 JOIN products
 ON orders.product_id = products.product_id
 GROUP BY product_category;
 
 -- How many unique products have been ordered?
 SELECT DISTINCT(COUNT(product_name)) AS Unique_products
 FROM products;
 
 -- What is the total revenue generated each year?
 SELECT EXTRACT(YEAR from order_date) Year,
		FORMAT(SUM(total),2) AS Revenue
FROM orders
GROUP BY Year;

-- What is the date of the largest and earliest order?
SELECT MIN(order_date) 'Earliest Date',
		MAX(order_date) Latest_date
FROM orders;

-- What product category has the lowest average price of products?
SElECT product_category,
		ROUND(AVG(retail_price),2) AS Average_price
FROM orders
JOIN products
USING(product_id)
GROUP BY product_category
ORDER BY Average_price
LIMIT 1;

-- What are the top ten highest performing products?
SELECT product_name,
		ROUND(SUM(total),2) AS Revenue
FROM orders
JOIN products
USING(product_id)
GROUP BY product_name
ORDER by Revenue DESC
LIMIT 10;

-- Show the total revenue and profits generated by each account_manager?
SELECT account_manager,
		ROUND(SUM(total),2) AS Revenue,
        ROUND(SUM(total) - SUM(cost_price),2) AS Profit
FROM orders
JOIN account
USING(account_id)
GROUP BY account_manager
ORDER BY Revenue DESC;

-- What is the name, city and account manager of the highest selling product in 2017?
SELECT product_name,
		city,
        account_manager,
        ROUND(SUM(total)) AS Revenue
FROM orders
JOIN products
USING(product_id)
JOIN account
USING(account_id)
WHERE EXTRACT(year from order_date) = 2017
GROUP BY product_name, city, account_manager
ORDER BY Revenue DESC
LIMIT 1;

-- Find the mean amount spent by order by each Customer type?
SELECT customer_type,
		AVG(total) Average_amount
FROM orders
GROUP BY customer_type;

-- What is the 5th Highest selling product?
SELECT product_id,
		product_name,
        ROUND(SUM(total),2) AS Revenue
FROM orders
JOIN products
USING(product_id)
GROUP BY product_id, product_name
ORDER by Revenue DESC
LIMIT 1 OFFSET 4;
        

        