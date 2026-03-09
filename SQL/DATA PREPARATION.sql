create table orders_full as 
select  
    o.order_id,
    o.customer_id,
    c.city,
    c.acquisition_channel,
    o.product_id,
    p.category,
    o.order_date,
    o.quantity,
    p.cost_price,
    p.selling_price,
    o.discount_pct,
    o.shipping_cost,
    o.payment_method,
    o.payment_status,
    o.return_flag
    from orders_clean o 
    left join products_clean p on o.product_id = p.product_id
    left join customers_clean c on o.customer_id = c.customer_id; --for funnel & conversion analysis

select * 
from orders_full;

CREATE TABLE orders_analytics AS
SELECT *
FROM orders_full
WHERE payment_status = 'completed'; -- for revenue/profit/customer/product analysis

select * 
from orders_analytics;

alter table orders_analytics
add column gross_revenue numeric(10,2);

update orders_analytics
set gross_revenue = selling_price*quantity;


alter table orders_analytics
add column discount_amt numeric(10,2);


update orders_analytics
set discount_amt = gross_revenue*discount_pct;


alter table orders_analytics
add column net_revenue numeric(10,2);

update orders_analytics
set net_revenue = gross_revenue - discount_amt;


alter table orders_analytics
add column profit numeric(10,2);

update orders_analytics
set profit = net_revenue - shipping_cost - (quantity * cost_price );

ALTER table orders_analytics
add column order_month DATE, 
ADD COLUMN order_year INT;

update orders_analytics
SET
order_month = DATE_TRUNC('month', order_date),
order_year = EXTRACT(YEAR FROM order_date);

select * 
from orders_analytics;

--DATA PREPARATION DONE




