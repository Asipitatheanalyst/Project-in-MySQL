# SQL Project: ABC Orders Analysis

## Overview
This project involves analyzing an e-commerce dataset (`abc_orders`) using MySQL. The goal is to perform data cleaning, querying, and analysis to extract insights, such as top-selling products and customer trends.

## Objectives
- Clean and organize raw data.
- Execute queries to extract business insights.
- Optimize query performance for large datasets.

## Dataset Description
The project uses the following tables within the `abc_orders` database:
- **`orders`**: Contains order details, including `order_id`, `customer_id`, `order_date`, and `total`.
- **`products`**: Includes product details such as `product_id`, `product_name`, and `price`.
- **`account`**: Stores customer account information like `customer_id`, `name`, and `email`.

## Key Queries
Here are some of the queries used in the project:

### 1. Top 5 Highest Selling Products
SELECT product_id, 
       product_name, 
       ROUND(SUM(total), 2) AS Revenue
FROM orders
JOIN products USING(product_id)
GROUP BY product_id, product_name
ORDER BY Revenue DESC
LIMIT 5;

### 2. Total Revenue by Customer Type
SELECT customer_type, 
       ROUND(SUM(total), 2) AS Total_Revenue
FROM orders
GROUP BY customer_type;

### 3. Updating Order and Shipment Dates
UPDATE orders
SET order_date = STR_TO_DATE(order_date, '%d/%m/%Y'),
    ship_date = STR_TO_DATE(ship_date, '%d/%m/%Y');

## Lessons Learned
- Importance of data cleaning to avoid query errors.
- Query optimization for handling large datasets.
- Using SQL functions like ROUND and STR_TO_DATE for better accuracy
