# SQL-запити (MySQL)

Цей файл містить мої основні SQL-запити  

## Зміст
- [Створення бази даних і таблиці](#створення-бази-даних-і-таблиці)
- [Ключові завдання](#ключові-завдання)
- [Фінансова ефективність](#фінансова-ефективність)
- [Клієнтський аналіз](#клієнтський-аналіз)
- [Тренди](#тренди)

---

## Створення бази даних і таблиці
За допомогою графічного інтерфейсу MySQL Workbench було створено нову базу даних **superstore**. 

До бази даних **superstore** додано таблицю **orders** в яку імпортовані дані із CSV-файлу:
<details>
  <summary>Створення таблиці</summary>
  <pre><code>CREATE TABLE orders (
    row_id INT
    ,order_id VARCHAR(20)
    ,order_date DATE
    ,ship_date DATE
    ,ship_mode VARCHAR(50)
    ,customer_id VARCHAR(20)
    ,customer_name VARCHAR(100)
    ,segment VARCHAR(50)
    ,country VARCHAR(50)
    ,city VARCHAR(100)
    ,state VARCHAR(100)
    ,postal_code VARCHAR(20)
    ,region VARCHAR(50)
    ,product_id VARCHAR(20)
    ,category VARCHAR(50)
    ,sub_category VARCHAR(50)
    ,product_name VARCHAR(200)
    ,sales DECIMAL(10,2)
    ,quantity INT
    ,discount DECIMAL(4,2)
    ,profit DECIMAL(10,2));
</code></pre></details>

---

## Ключові завдання
<details>
  <summary>Загальний обсяг продажів і прибутку</summary>
  <pre><code>SELECT 
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit
FROM orders;</code></pre>
</code></pre></details>

<details>
  <summary>Продажі по роках</summary>
  <pre><code>
SELECT 
	YEAR(order_date) AS year
    ,ROUND(SUM(sales), 2) AS total_sales
    ,ROUND(SUM(profit), 2) AS total_profit
FROM orders
GROUP BY YEAR(order_date)
ORDER BY 1;
</code></pre></details>

<details>
  <summary>ТОП-10 продуктів за прибутком</summary>
  <pre><code>SELECT
	product_name
    ,ROUND(SUM(sales), 2) AS total_sales
    ,ROUND(SUM(profit), 2) AS total_profit
FROM orders
GROUP BY	product_name
ORDER BY total_profit DESC
LIMIT 10;
</code></pre></details>

<details>
  <summary>Середній чек за замовлення</summary>
  <pre><code>
SELECT
   ROUND(SUM(sales) / COUNT(DISTINCT order_id), 2) AS avg_order_value
FROM orders;
</code></pre></details>

<details> <summary>Продажі за регіонами</summary>
<pre><code>SELECT
	region
	,ROUND(SUM(sales), 2) AS total_sales
	,ROUND(SUM(profit), 2) AS total_profit
FROM orders
GROUP BY region
ORDER BY total_sales DESC;
</code></pre></details>

<details> <summary>Категорії товарів з найвищим прибутком</summary>
<pre><code>SELECT
	category
   ,ROUND(SUM(sales), 2) AS total_sales
   ,ROUND(SUM(profit), 2) AS total_profit
FROM orders
GROUP BY category
ORDER BY total_profit DESC;
</code></pre></details>

<details> <summary>Сезонність: продажі по місяцях</summary>
<pre><code>SELECT
	YEAR(order_date) AS year
	,MONTH(order_date) AS month
   	,ROUND(SUM(sales), 2) AS total_sales
FROM orders
GROUP BY YEAR (order_date), MONTH(order_date)
ORDER BY YEAR (order_date), MONTH(order_date);
</code></pre></details>

<details> <summary>Клієнти з найвищим LTV (lifetime value)</summary>
<pre><code>SELECT
    customer_id
    ,customer_name
    ,ROUND(SUM(sales), 2) AS total_sales
   	,COUNT(DISTINCT order_id) AS total_orders
FROM orders
GROUP BY customer_id, customer_name
ORDER BY total_sales DESC
LIMIT 10;
</code></pre></details>

---

## Фінансова ефективність
<details> <summary>Маржа прибутку</summary>
<pre><code>SELECT
	ROUND(SUM(profit) / SUM(sales) * 100, 2) AS profit_margin_percent
FROM orders;
</code></pre></details>

<details> <summary>Вплив знижок на прибуток</summary>
<pre><code>SELECT
    discount
    ,ROUND(SUM(sales), 2) AS total_sales
    ,ROUND(SUM(profit), 2) AS total_profit
FROM orders
GROUP BY discount
ORDER BY discount;
</code></pre></details>

<details> <summary>Топ-10 збиткових товарів</summary>
<pre><code>SELECT
	product_name
    ,ROUND(SUM(sales), 2) AS total_sales
    ,ROUND(SUM(profit), 2) AS total_profit
FROM orders
GROUP BY product_name
HAVING total_profit < 0
ORDER BY total_profit
LIMIT 10;
</code></pre></details>

---

## Клієнтський аналіз
<details> <summary>Повторні клієнти</summary>
<pre><code>SELECT
	customer_id
    ,customer_name
    ,COUNT(DISTINCT order_id) AS orders_count
    ,ROUND(SUM(sales), 2) AS total_sales
FROM orders
GROUP BY customer_id, customer_name
HAVING orders_count > 1
ORDER BY orders_count DESC;
</code></pre></details>

<details> <summary>Сегментація клієнтів</summary>
<pre><code>SELECT
    segment
    ,ROUND(SUM(sales), 2) AS total_sales
    ,ROUND(SUM(profit), 2) AS total_profit
FROM orders
GROUP BY segment
ORDER BY total_sales DESC;
</code></pre></details>

---

## Тренди
<details> <summary>Річний тренд продажів і прибутку</summary>
<pre><code>SELECT
	YEAR(order_date) AS year
    ,ROUND(SUM(sales), 2) AS total_sales
    ,ROUND(SUM(profit), 2) AS total_profit
FROM orders
GROUP BY YEAR(order_date)
ORDER BY year;
</code></pre></details>

<details> <summary>Місячна сезонність</summary>
<pre><code>SELECT
	MONTH(order_date) AS month
    ,ROUND(SUM(sales), 2) AS total_sales
FROM orders
GROUP BY MONTH(order_date)
ORDER BY month;
</code></pre></details>

<details> <summary>Регіональні тренди</summary>
<pre><code>SELECT
	region
    ,YEAR(order_date) AS year
    ,ROUND(SUM(sales), 2) AS total_sales
FROM orders
GROUP BY region, YEAR(order_date)
ORDER BY region, year;
</code></pre></details>
