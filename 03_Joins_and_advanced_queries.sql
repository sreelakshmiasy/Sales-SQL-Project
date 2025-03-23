SELECT * FROM blinkit_orders;
SELECT * FROM blinkit_products;

#JOINING THE TABLES

SELECT *
FROM blinkit_orders bo LEFT JOIN blinkit_products bp
	ON bo.product_id = bp.product_id;

# Total revenue and profit calculation

SELECT bp.product_id, bp.product_name, bp.category,
SUM(bo.quantity) AS total_units_sold,
ROUND(SUM(bo.quantity * bo.unit_price), 2) AS total_revenue,
SUM(bo.quantity * (bp.margin_percentage/100) * bo.unit_price) AS  total_profit
FROM blinkit_orders bo LEFT JOIN blinkit_products bp
ON bo.product_id = bp.product_id
GROUP BY bp.product_id, bp.product_name, bp.category
ORDER BY total_revenue DESC;

#TOP SELLING PRODUCTS
SELECT bp.product_name, bp.category,
COUNT(bo.order_id) AS total_orders,
SUM(bo.quantity) AS total_units_sold
FROM blinkit_orders bo LEFT JOIN blinkit_products bp
ON bo.product_id = bp.product_id
GROUP BY bp.product_name, bp.category
ORDER BY total_units_sold DESC;

#Leading brands

SELECT bp.category, bp.brand,
COUNT(bo.order_id) AS total_orders,
SUM(bo.quantity) AS total_units_sold
FROM blinkit_orders bo LEFT JOIN blinkit_products bp
ON bo.product_id = bp.product_id
GROUP BY bp.category, bp.brand
ORDER BY total_units_sold DESC;

#Insights on inventory management

SELECT 
bp.product_name, bp.category,
SUM(bo.quantity) AS total_units_sold,
bp.min_stock_level,
bp.max_stock_level,
CASE
	WHEN SUM(bo.quantity) > bp.max_stock_level THEN "Overstocked"
	WHEN SUM(bo.quantity) < bp.min_stock_level THEN "Understocked"
	ELSE "Optimal"
END AS stock_status
FROM blinkit_orders bo LEFT JOIN blinkit_products bp
ON bo.product_id = bp.product_id
GROUP BY bp.product_name, bp.category, bp.min_stock_level,
bp.max_stock_level
ORDER BY stock_status;

#Brands and price trends
#Discount across brands

SELECT bp.brand, 
AVG(bo.unit_price) AS avg_selling_price,
AVG(bp.mrp) AS avg_mrp,
AVG(bp.mrp) - AVG(bo.unit_price) AS avg_discount
FROM blinkit_orders bo LEFT JOIN blinkit_products bp
ON bo.product_id = bp.product_id
GROUP BY bp.brand
ORDER BY avg_discount DESC;
