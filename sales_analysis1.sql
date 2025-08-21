-- Створення бази даних і таблиці

CREATE TABLE orders (
    row_id INT,
    order_id VARCHAR(20),
    order_date DATE,
    ship_date DATE,
    ship_mode VARCHAR(50),
    customer_id VARCHAR(20),
    customer_name VARCHAR(100),
    segment VARCHAR(50),
    country VARCHAR(50),
    city VARCHAR(100),
    state VARCHAR(100),
    postal_code VARCHAR(20),
    region VARCHAR(50),
    product_id VARCHAR(20),
    category VARCHAR(50),
    sub_category VARCHAR(50),
    product_name VARCHAR(200),
    sales DECIMAL(10,2),
    quantity INT,
    discount DECIMAL(4,2),
    profit DECIMAL(10,2)
);

-- Ключові завдання
-- 1. Загальний обсяг продажів і прибутку:
SELECT 
	ROUND(SUM(sales), 2) AS total_sales
    ,ROUND(SUM(profit), 2) AS total_profit
FROM orders;

-- 2. Продажі по роках:
SELECT 
	YEAR(order_date) AS year
    ,ROUND(SUM(sales), 2) AS total_sales
    ,ROUND(SUM(profit), 2) AS total_profit
FROM orders
GROUP BY YEAR(order_date)
ORDER BY 1;

-- 3. ТОП-10 продуктів за прибутком
SELECT
	product_name
    ,ROUND(SUM(sales), 2) AS total_sales
    ,ROUND(SUM(profit), 2) AS total_profit
FROM orders
GROUP BY	product_name
ORDER BY total_profit DESC
LIMIT 10;

-- 4. Середній чек на замовлення
SELECT
    ROUND(SUM(sales) / COUNT(DISTINCT order_id), 2) AS avg_order_value
FROM orders;

-- 5. Продажі за регіонами
SELECT
	region
    ,ROUND(SUM(sales), 2) AS total_sales
    ,ROUND(SUM(profit), 2) AS total_profit
FROM orders
GROUP BY region
ORDER BY total_sales DESC;

-- 6. Категорії товарів з найвищим прибутком
SELECT
	category
    ,ROUND(SUM(sales), 2) AS total_sales
    ,ROUND(SUM(profit), 2) AS total_profit
FROM orders
GROUP BY category
ORDER BY total_profit DESC;

-- 7. Сезонність: продажі по місяцях
SELECT
	YEAR(order_date) AS year
	,MONTH(order_date) AS month
    ,ROUND(SUM(sales), 2) AS total_sales
FROM orders
GROUP BY YEAR (order_date), MONTH(order_date)
ORDER BY YEAR (order_date), MONTH(order_date);

-- 8.  Клієнти з найвищим LTV (lifetime value)
SELECT
    customer_id
    ,customer_name
    ,ROUND(SUM(sales), 2) AS total_sales
    ,COUNT(DISTINCT order_id) AS total_orders
FROM orders
GROUP BY customer_id, customer_name
ORDER BY total_sales DESC
LIMIT 10;

-- Фінансова ефективність
-- 1. Маржа прибутку
SELECT
	ROUND(SUM(profit) / SUM(sales) * 100, 2) AS profit_margin_percent
FROM orders;

-- 2. Вплив знижок на прибуток
SELECT
    discount
    ,ROUND(SUM(sales), 2) AS total_sales
    ,ROUND(SUM(profit), 2) AS total_profit
FROM orders
GROUP BY discount
ORDER BY discount;

-- 3. Топ-10 збиткових товарів
SELECT
	product_name
    ,ROUND(SUM(sales), 2) AS total_sales
    ,ROUND(SUM(profit), 2) AS total_profit
FROM orders
GROUP BY product_name
HAVING total_profit < 0
ORDER BY total_profit
LIMIT 10;

-- Клієнтський аналіз
-- 1. Повторні клієнти
SELECT
	customer_id
    ,customer_name
    ,COUNT(DISTINCT order_id) AS orders_count
    ,ROUND(SUM(sales), 2) AS total_sales
FROM orders
GROUP BY customer_id, customer_name
HAVING orders_count > 1
ORDER BY orders_count DESC;

-- 2. Сегментація клієнтів
SELECT
    segment
    ,ROUND(SUM(sales), 2) AS total_sales
    ,ROUND(SUM(profit), 2) AS total_profit
FROM orders
GROUP BY segment
ORDER BY total_sales DESC;

-- Тренди
-- 1. Річний тренд продажів і прибутку
SELECT
	YEAR(order_date) AS year
    ,ROUND(SUM(sales), 2) AS total_sales
    ,ROUND(SUM(profit), 2) AS total_profit
FROM orders
GROUP BY YEAR(order_date)
ORDER BY year;

-- 2. Місячна сезонність
SELECT
	MONTH(order_date) AS month
    ,ROUND(SUM(sales), 2) AS total_sales
FROM orders
GROUP BY MONTH(order_date)
ORDER BY month;

-- 3. Регіональні тренди
SELECT
	region
    ,YEAR(order_date) AS year
    ,ROUND(SUM(sales), 2) AS total_sales
FROM orders
GROUP BY region, YEAR(order_date)
ORDER BY region, year;