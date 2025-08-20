# SQL-запити (MySQL)

Цей файл містить мої основні SQL-запити  

## Зміст
- [Створення бази даних і таблиці](#створення_бази_даних_і_таблиці)
- [Клієнтські метрики](#клієнтські-метрики)
- [ABC-analysis](#ABC-analysis)
- [XYZ-analysis](#XYZ-analysis)

---
## Створення бази даних і таблиці
За допомогою графічного інтерфейсу MySQL Workbench було створено нову базу даних **superstore**. 

До бази даних **superstore** додано таблицю **orders** в яку імпортовані дані із CSV-файлу:

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
    
    profit DECIMAL(10,2));

## Перевірка таблиці

SELECT * FROM  orders;
