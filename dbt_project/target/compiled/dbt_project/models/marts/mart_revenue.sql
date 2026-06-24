with orders as (
    select * from "olist"."main"."int_orders_enriched"
    where order_status = 'delivered'
),

monthly_revenue as (
    select
        date_trunc('month', purchased_at) as month,
        customer_state,
        payment_type,
        count(distinct order_id)          as total_orders,
        sum(total_price)                  as gross_revenue,
        sum(total_freight)                as total_freight,
        sum(total_payment)                as net_revenue,
        avg(total_payment)                as avg_order_value
    from orders
    group by 1, 2, 3
)

select * from monthly_revenue