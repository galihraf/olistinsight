with orders as (
    select * from "olist"."main"."int_orders_enriched"
    where order_status = 'delivered'
)

select
    customer_state,
    customer_city,
    count(distinct order_id)    as total_orders,
    sum(total_payment)          as total_revenue,
    avg(total_payment)          as avg_order_value,
    count(distinct customer_id) as total_customers
from orders
group by 1, 2