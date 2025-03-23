DROP SCHEMA IF EXISTS blinkit_db;
CREATE SCHEMA blinkit_db;
USE blinkit_db;

CREATE TABLE blinkit_products(
product_id INT PRIMARY KEY NOT NULL,
product_name VARCHAR(20),
category VARCHAR(60),
brand VARCHAR(60),
price FLOAT,
mrp FLOAT,
margin_percentage INT,
shelf_life_days INT,
min_stock_level INT,
max_stock_level INT
);

# Orders table

CREATE TABLE blinkit_orders(
order_id INT PRIMARY KEY,
product_id INT,
quantity INT,
unit_price FLOAT,
FOREIGN KEY (product_id) REFERENCES blinkit_products(product_id)
);