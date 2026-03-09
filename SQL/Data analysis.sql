select * 
from orders_analytics oa;

-- Monthly Revenue Trend
SELECT
    order_month,
    SUM(net_revenue) AS total_revenue,
    SUM(profit) AS total_profit,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(SUM(net_revenue)/COUNT(DISTINCT order_id),2) AS avg_order_value
FROM orders_analytics
GROUP BY order_month
ORDER BY order_month

--category wise revenue trend
select 
    category,
    sum(net_revenue) as total_revenue,
    sum(profit) as total_profit,
    count(distinct order_id) as total_orders,
    round(sum(net_revenue)/count(distinct order_id),2) as AOV,
    round(sum(profit)/sum(net_revenue),2) as profit_margin
from orders_analytics
group by 1
order by 3 desc;

--customer segmentation and RFM analysis

create table rfm_analysis as 
select
   customer_id,
   max(order_month) as last_order_date,
   (SELECT MAX(order_date) FROM orders_analytics) - MAX(order_date) AS recency,
   sum(net_revenue) as total_revenue,
   count(distinct order_id) as total_orders
from orders_analytics
group by 1;

ALTER TABLE rfm_analysis
ADD COLUMN r_score INT,
ADD COLUMN f_score INT,
ADD COLUMN m_score INT;

UPDATE rfm_analysis
SET r_score = score
FROM (
    SELECT
        customer_id,
        NTILE(5) OVER (ORDER BY recency ASC) AS score
    FROM rfm_analysis
) t
WHERE rfm_analysis.customer_id = t.customer_id;

UPDATE rfm_analysis
SET f_score = score
FROM (
    SELECT
        customer_id,
        NTILE(5) OVER (ORDER BY total_orders ASC) AS score
    FROM rfm_analysis
) t
WHERE rfm_analysis.customer_id = t.customer_id;

UPDATE rfm_analysis
SET m_score = score
FROM (
    SELECT
        customer_id,
        NTILE(5) OVER (ORDER BY total_revenue ASC) AS score
    FROM rfm_analysis
) t
WHERE rfm_analysis.customer_id = t.customer_id;

ALTER TABLE rfm_analysis
ADD COLUMN customer_segment TEXT;

Update rfm_analysis 
set customer_segment = 
case 
	when r_score >= 4 and f_score >=4 and m_score >=4 then 'Champions'
	when r_score >= 3 and f_score >=3 then 'Loyal Customers'
	when r_score >= 4 and f_score <=2 then 'New Customers'
	when r_score <= 2 and f_score >=3 then 'At risk customers'
	else 'others'
end;

SELECT
    customer_segment,
    COUNT(*) AS customers,
    SUM(total_revenue) AS revenue
FROM rfm_analysis
GROUP BY customer_segment
ORDER BY revenue DESC;

-- Funnel & Conversion Analysis

SELECT
    event_type,
    COUNT(DISTINCT user_id) AS users
FROM website_events_clean
GROUP BY event_type
ORDER BY users DESC;

WITH funnel AS (
    SELECT
        COUNT(DISTINCT CASE WHEN event_type = 'visit' THEN user_id END) AS visits,
        COUNT(DISTINCT CASE WHEN event_type = 'add_to_cart' THEN user_id END) AS carts,
        COUNT(DISTINCT CASE WHEN event_type = 'checkout' THEN user_id END) AS checkouts,
        COUNT(DISTINCT CASE WHEN event_type = 'payment' THEN user_id END) AS payments
    FROM website_events_clean
)

SELECT
    visits,
    carts,
    checkouts,
    payments,
    ROUND(carts * 100.0 / visits,2) AS visit_to_cart_rate,
    ROUND(checkouts
    * 100.0 / carts,2) AS cart_to_checkout_rate,
    ROUND(payments * 100.0 / checkouts,2) AS checkout_to_payment_rate
FROM funnel;