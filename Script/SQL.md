# SQL-запити (MySQL)

Цей файл містить мої основні SQL-запити  

## Зміст
- [Створення бази даних і таблиці](#створення_бази_даних_і_таблиці)
- [Ключові завдання](#ключові_завдання)
- [ABC-analysis](#ABC-analysis)
- [XYZ-analysis](#XYZ-analysis)

---
## Створення бази даних і таблиці
За допомогою графічного інтерфейсу MySQL Workbench було створено нову базу даних **superstore**. 

До бази даних **superstore** додано таблицю **orders** в яку імпортовані дані із CSV-файлу:

## Створення таблиці
<details> <summary>CREATE TABLE</summary>
CREATE TABLE orders (
    
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

SELECT * FROM orders;

</details>

## Ключові завдання
<details> <summary>Загальний обсяг продажів і прибутку</summary>

SELECT 

	ROUND(SUM(sales), 2) AS total_sales
	,ROUND(SUM(profit), 2) AS total_profit
FROM orders;

</details>

<details> <summary>Продажі по роках</summary>

SELECT 
	
 	YEAR(order_date) AS year
    
	,ROUND(SUM(sales), 2) AS total_sales
    
	,ROUND(SUM(profit), 2) AS total_profit

FROM orders

GROUP BY YEAR(order_date)

ORDER BY 1;

</details>

<details> <summary>ТОП-10 продуктів за прибутком</summary>
	SELECT
	
	product_name
    
	,ROUND(SUM(sales), 2) AS total_sales
    
	,ROUND(SUM(profit), 2) AS total_profit

FROM orders

GROUP BY	product_name

ORDER BY total_profit DESC

LIMIT 10;
</details>

<details> <summary>Середній чек на замовлення</summary>
SELECT
   
	ROUND(SUM(sales) / COUNT(DISTINCT order_id), 2) AS avg_order_value

FROM orders;
</details>

<details> <summary>Продажі за регіонами</summary>
SELECT
	
	region
   
	,ROUND(SUM(sales), 2) AS total_sales
    
	,ROUND(SUM(profit), 2) AS total_profit

FROM orders

GROUP BY region

ORDER BY total_sales DESC;
</details>

<details> <summary>Категорії товарів з найвищим прибутком</summary>
SELECT
	
	category
   
	,ROUND(SUM(sales), 2) AS total_sales
   
	,ROUND(SUM(profit), 2) AS total_profit

FROM orders

GROUP BY category

ORDER BY total_profit DESC;
</details>

<details> <summary>Сезонність: продажі по місяцях</summary>
SELECT
	
	YEAR(order_date) AS year
	
 	,MONTH(order_date) AS month
   
	,ROUND(SUM(sales), 2) AS total_sales

FROM orders

GROUP BY YEAR (order_date), MONTH(order_date)

ORDER BY YEAR (order_date), MONTH(order_date);
</details>


<details> <summary>Клієнти з найвищим LTV (lifetime value)</summary>
SELECT
    
	customer_id
    
	,customer_name
    
	,ROUND(SUM(sales), 2) AS total_sales
   
	,COUNT(DISTINCT order_id) AS total_orders

FROM orders

GROUP BY customer_id, customer_name

ORDER BY total_sales DESC

LIMIT 10;

</details>
