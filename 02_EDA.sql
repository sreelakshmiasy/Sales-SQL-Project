# EDA
#View the blinkit_products table:

SELECT * FROM blinkit_products;

#checking for null values 

SELECT * FROM blinkit_products
WHERE price IS NULL;

# identifying the number of products in the company
SELECT COUNT(*) FROM blinkit_products;

# Least and most expensive product
SELECT * FROM blinkit_products
ORDER BY price;

SELECT * FROM blinkit_products
ORDER BY price DESC;

# Different product categories in the table
SELECT DISTINCT category FROM blinkit_products;

SELECT category, AVG(price) AS avg_price
FROM blinkit_products
GROUP BY category
ORDER BY avg_price;

SELECT category, SUM(price) AS total_price
FROM blinkit_products
GROUP BY category
ORDER BY total_price;

# how many products in each category
SELECT category, COUNT(product_id) AS num_products
FROM blinkit_products
GROUP BY category
ORDER BY num_products;

# avg price for products from each brand
SELECT brand, AVG(price) AS avg_price
FROM blinkit_products
GROUP BY brand
ORDER BY avg_price;

SELECT brand, category, AVG(price) AS avg_price
FROM blinkit_products
GROUP BY brand, category
ORDER BY avg_price;

# Stock and inventory

SELECT category, AVG(min_stock_level) AS avg_min_stock, 
AVG(max_stock_level) AS avg_max_stock
FROM blinkit_products
GROUP BY category;

# shelf life
SELECT category, ROUND(AVG(shelf_life_days),2) AS avg_shelf_life_days
FROM blinkit_products
GROUP BY category;


#EDA of second table- blinkit_orders
#Viewing the dataset
SELECT * FROM blinkit_orders;

#checking for duplicates
SELECT order_id, COUNT(*)
FROM blinkit_orders
GROUP BY order_id
HAVING COUNT(*) > 1;

#The most and least spent orders;

SELECT * FROM blinkit_orders
ORDER BY unit_price DESC, quantity DESC;
