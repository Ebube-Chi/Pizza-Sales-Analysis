CREATE TABLE pizza_sales (
    pizza_id            INT,
    order_id            INT,
    pizza_name_id       VARCHAR,
    quantity            INT,
    order_date          DATE,
    order_time          TIME,
    unit_price          DECIMAL(10,2),
    total_price         DECIMAL(10,2),
    pizza_size          VARCHAR,
    pizza_category      VARCHAR,
    pizza_ingredients   VARCHAR,
    pizza_name          VARCHAR
);

SELECT * FROM pizza_sales;


--Total Revenue (ie Total price if all the pizza sold)
SELECT SUM(total_price) AS Total_Revenue
FROM pizza_sales;


--Average Order Value
SELECT (SUM(total_price) / COUNT(DISTINCT order_id)) AS Avg_order_Value 
FROM pizza_sales;


--Total Pizzas Sold
SELECT SUM(quantity) AS Total_pizza_sold 
FROM pizza_sales;


--Total Orders
SELECT COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales;


--Average Pizzas Per Order
SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) / 
	   CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS DECIMAL(10,2))
	   AS Avg_Pizza_per_order
FROM pizza_sales;


--Daily Trend for Total Orders
SELECT TO_CHAR(order_date, 'Day') AS order_day, COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY TO_CHAR(order_date, 'Day');


 --Monthly Trend for Orders
SELECT TRIM(TO_CHAR(order_date, 'Month')) AS month_name,COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY TRIM(TO_CHAR(order_date, 'Month'))
ORDER BY total_orders DESC;


--Percentage of Sales by Pizza Category
SELECT pizza_category, CAST(SUM(total_price) AS DECIMAL(10,2)) as total_revenue,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales) AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
GROUP BY pizza_category;


--Percentage of Sales by Pizza Size
SELECT pizza_size, CAST(SUM(total_price) AS DECIMAL(10,2)) as total_revenue,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales) AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
GROUP BY pizza_size
ORDER BY pizza_size;

--Total Pizzas Sold by Pizza Category
SELECT pizza_category,  SUM(quantity) AS total_quantity_sold
FROM pizza_sales
WHERE EXTRACT(MONTH FROM order_date) = 2
GROUP BY pizza_category
ORDER BY total_quantity_sold DESC;

--Top 5 Pizza by Revenue
SELECT pizza_name, SUM(total_price) AS total_revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_revenue DESC
LIMIT 5;


--Bottom 5 Pizzas by Revenue
SELECT pizza_name, SUM(total_price) AS total_revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_revenue ASC
LIMIT 5;


--Top 5 Pizza by Quantity
SELECT pizza_name, SUM(quantity) AS total_pizza_sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_pizza_sold DESC
LIMIT 5;


--Bottom 5 Pizza by Quantity
SELECT pizza_name, SUM(quantity) AS total_pizza_sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_pizza_sold ASC
LIMIT 5;


--Top 5 Pizza by Total Orders
SELECT pizza_name, COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_orders DESC
LIMIT 5;


--Bottom 5 Pizza by Total Orders
SELECT pizza_name, COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_orders ASC
LIMIT 5;

