create database ecommerce_sales;
use ecommerce_sales;
select * from ecommerce_sales;
use ecommerce_sales ;

-- use select keyword 
SELECT * 
FROM ecommerce_sales
LIMIT 10;

-- filter rows(having vs where)
-- Orders above ₹5000
SELECT order_id, customer_id, total_amount
FROM ecommerce_sales
WHERE total_amount > 5000;

-- Customers with total spend > ₹50,000
SELECT customer_id, SUM(total_amount) AS total_spent
FROM ecommerce_sales
GROUP BY customer_id
HAVING SUM(total_amount) > 50000;

-- Aggregate functins
-- Average revenue per user
SELECT AVG(user_revenue) 
FROM (
    SELECT customer_id, SUM(total_amount) AS user_revenue
    FROM ecommerce_sales
    GROUP BY customer_id
) AS sub;

SELECT o.order_id, o.total_amount, 
       c.customer_id, c.customer_age, c.customer_gender
FROM ecommerce_sales o
INNER JOIN (
    SELECT DISTINCT customer_id, customer_age, customer_gender, region
    FROM ecommerce_sales
) c ON o.customer_id = c.customer_id;

SELECT o.order_id, o.total_amount, 
       c.customer_id, c.customer_age, c.customer_gender
FROM ecommerce_sales o
LEFT JOIN (
    SELECT DISTINCT customer_id, customer_age, customer_gender, region
    FROM ecommerce_sales
) c ON o.customer_id = c.customer_id;

SELECT o.order_id, o.total_amount, 
       c.customer_id, c.customer_age, c.customer_gender
FROM ecommerce_sales o
RIGHT JOIN (
    SELECT DISTINCT customer_id, customer_age, customer_gender, region
    FROM ecommerce_sales
) c ON o.customer_id = c.customer_id;


-- subquery
-- Find customers who spent above average
SELECT customer_id, SUM(total_amount) AS total_spent
FROM ecommerce_sales
GROUP BY customer_id
HAVING SUM(total_amount) > (
    SELECT AVG(total_amount) 
    FROM ecommerce_sales
);


-- create view
CREATE VIEW customer_summary AS
SELECT customer_id, COUNT(order_id) AS total_orders,
       SUM(total_amount) AS total_spent,
       AVG(total_amount) AS avg_order_value
FROM ecommerce_sales
GROUP BY customer_id;








