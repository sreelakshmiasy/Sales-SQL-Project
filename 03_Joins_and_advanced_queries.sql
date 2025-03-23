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

#Total revenue is the highest for eggs
#Total profit is the highest for Snacks


#Brand profit
SELECT bp.brand,
SUM(bo.quantity) AS total_units_sold,
ROUND(SUM(bo.quantity * bo.unit_price), 2) AS total_revenue,
SUM(bo.quantity * (bp.margin_percentage/100) * bo.unit_price) AS  total_profit
FROM blinkit_orders bo LEFT JOIN blinkit_products bp
ON bo.product_id = bp.product_id
GROUP BY bp.brand
ORDER BY total_revenue DESC;

#highest profit and revenue: Bahl-Pau, Chahal Group
#profit and revenue: Pet Care, Diary & Breakfast

#Total company revenue
SELECT SUM(total_revenue) AS total_company_revenue
FROM (SELECT bp.product_id, bp.product_name, bp.category,
SUM(bo.quantity) AS total_units_sold,
ROUND(SUM(bo.quantity * bo.unit_price), 2) AS total_revenue,
SUM(bo.quantity * (bp.margin_percentage/100) * bo.unit_price) AS  total_profit
FROM blinkit_orders bo LEFT JOIN blinkit_products bp
ON bo.product_id = bp.product_id
GROUP BY bp.product_id, bp.product_name, bp.category
ORDER BY total_revenue DESC) AS revenue_table;

#total company revenue is 1043018.22 INR

#TOP SELLING PRODUCTS
SELECT bp.product_name, bp.category,
COUNT(bo.order_id) AS total_orders,
SUM(bo.quantity) AS total_units_sold
FROM blinkit_orders bo LEFT JOIN blinkit_products bp
ON bo.product_id = bp.product_id
GROUP BY bp.product_name, bp.category
ORDER BY total_units_sold DESC;

#The top selling products are Vitamins, Lotion, Pet treats and baby wipes


#Leading brands

SELECT bp.category, bp.brand,
COUNT(bo.order_id) AS total_orders,
SUM(bo.quantity) AS total_units_sold
FROM blinkit_orders bo LEFT JOIN blinkit_products bp
ON bo.product_id = bp.product_id
GROUP BY bp.category, bp.brand
ORDER BY total_units_sold DESC;

#Highest number of units sold from brand Raja and Sons for category pet care


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

SELECT AVG(avg_discount)
FROM (SELECT bp.brand, 
AVG(bo.unit_price) AS avg_selling_price,
AVG(bp.mrp) AS avg_mrp,
AVG(bp.mrp) - AVG(bo.unit_price) AS avg_discount
FROM blinkit_orders bo LEFT JOIN blinkit_products bp
ON bo.product_id = bp.product_id
GROUP BY bp.brand
ORDER BY avg_discount DESC) AS avg_disc;


SELECT bp.brand, 
AVG(bo.unit_price) AS avg_selling_price,
AVG(bp.mrp) AS avg_mrp,
AVG(bp.mrp) - AVG(bo.unit_price) AS avg_discount
FROM blinkit_orders bo LEFT JOIN blinkit_products bp
ON bo.product_id = bp.product_id
GROUP BY bp.brand
ORDER BY avg_discount DESC;
#The highest avg discount is provided by the brand Mammen-Hegde

SELECT bp.category, 
AVG(bo.unit_price) AS avg_selling_price,
AVG(bp.mrp) AS avg_mrp,
AVG(bp.mrp) - AVG(bo.unit_price) AS avg_discount
FROM blinkit_orders bo LEFT JOIN blinkit_products bp
ON bo.product_id = bp.product_id
GROUP BY bp.category
ORDER BY avg_discount DESC;

#Instant & Frozen food is the category with the highest average discount closely followed by Pet Care
