-- ============================================
-- ECOMMERCE DATA CLEANING PROJECT
-- Author: Ishika Gupta
-- Database: PostgreSQL
-- Description:
-- Cleans orders, customers, products, and website events tables
-- ============================================

-- Reviewing data 

select * 
from customers 
limit 10;

select * 
from orders  
limit 10;

select * 
from products
limit 10;

select *
from website_events we 
limit 10;

--CREATE CLEAN TABLES (REMOVE EXACT DUPLICATES)

create table orders_clean as
select distinct * 
from orders;

create table customers_clean as
select distinct * 
from customers;

create table products_clean as
select distinct * 
from products;

create table website_events_clean as
select distinct * 
from website_events;

--checking for duplicates
select order_id, count(order_id)
from orders_clean
group by order_id
having count(order_id) > 1; -- no duplicate order_ids

select customer_id, count(customer_id)
from customers_clean
group by customer_id
having count(customer_id) > 1; -- no duplicate customer_id

select product_id, count(product_id)
from products_clean pc 
group by product_id
having count(product_id) > 1; -- no duplicate product_id

select user_id, count(user_id)
from website_events_clean wec 
group by wec.user_id 
having count(user_id) >1; -- duplicate user_id because a customer may have many website events

--HANDLE MISSING VALUES

select * 
from orders_clean 
where customer_id is null
or product_id is null 
or order_date is null
or quantity is null
or discount_pct is null
or payment_method is null
or payment_status is null
or shipping_cost is null
or return_flag is null; -- null values identified in columns shipping cost and discount_pct


UPDATE orders_clean
SET discount_pct = 0
WHERE discount_pct IS NULL; -- null discounts may mean that no discounts were offered


SELECT payment_status, COUNT(*) AS missing_shipping
FROM orders_clean
WHERE shipping_cost IS NULL
GROUP BY payment_status; -- identified payment status for missing shipping cost

UPDATE orders_clean
SET shipping_cost = 0
WHERE shipping_cost is NULL
and payment_status != 'Completed'; -- shipping cost set to 0 for orders that are rejected or not shipped

UPDATE orders_clean
SET shipping_cost = 
(
select avg(shipping_cost)
from orders_clean
where shipping_cost is not null
)
WHERE shipping_cost IS NULL
and payment_status = 'Completed'; -- shipping cost set to average for orders that are shipped

select * 
from customers_clean cc  
where customer_id is null
or signup_date is null
or city is null 
or acquisition_channel  is null; -- No null values Found

select * 
from products_clean
where product_id is null 
or category is null 
or cost_price is null 
or selling_price is null; -- No null values Found

select * 
from website_events_clean 
where user_id is null 
or event_type is null 
or timestamp is null;  -- No null values Found

-- FIX DATA TYPES

ALTER TABLE orders_clean
ALTER COLUMN order_date TYPE DATE
USING order_date::DATE; -- converting data type to date

UPDATE orders_clean
SET discount_pct = discount_pct/100.0; -- discount percentage to percent

ALTER TABLE customers_clean
ALTER COLUMN signup_date TYPE DATE
using signup_date::date; -- converting data type to date

--STANDARDIZE TEXT FIELDS

UPDATE orders_clean
SET payment_method = LOWER(TRIM(payment_method)),
    payment_status = LOWER(TRIM(payment_status));

UPDATE customers_clean
SET city = INITCAP(TRIM(city));

UPDATE products_clean
SET category = lower(TRIM(category));

UPDATE website_events_clean
SET event_type = lower(TRIM(event_type));

--DATA VALIDATION CHECKS

SELECT *
FROM orders_clean
WHERE quantity <= 0
   OR discount_pct < 0
   OR shipping_cost < 0; 

select * 
from products_clean
where cost_price  < 0 
or selling_price < 0;

--Referential integrity checks

SELECT o.*
FROM orders_clean o
LEFT JOIN customers_clean c
ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

SELECT o.*
FROM orders_clean o
LEFT JOIN products_clean p
ON o.product_id = p.product_id
WHERE p.product_id IS NULL;

--ADD CONSTRAINTS

ALTER TABLE customers_clean ADD PRIMARY KEY (customer_id);
ALTER TABLE products_clean ADD PRIMARY KEY (product_id);
ALTER TABLE orders_clean ADD PRIMARY KEY (order_id);

ALTER TABLE orders_clean
ADD CONSTRAINT fk_customer
FOREIGN KEY (customer_id)
REFERENCES customers_clean(customer_id);

ALTER TABLE orders_clean
ADD CONSTRAINT fk_product
FOREIGN KEY (product_id)
REFERENCES products_clean(product_id);


ALTER TABLE website_events_clean
ADD CONSTRAINT chk_event
CHECK (event_type IN ('visit','add_to_cart','checkout','payment'));


ALTER TABLE orders_clean
ADD CONSTRAINT chk_quantity CHECK (quantity > 0);

ALTER TABLE products_clean
ADD CONSTRAINT chk_price CHECK (selling_price >= cost_price);



