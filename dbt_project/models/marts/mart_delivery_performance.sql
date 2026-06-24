with orders as (
    select * from {{ ref('int_orders_enriched') }}
    where order_status = 'delivered'
    and delivered_at is not null
),

delivery as (
    select
        customer_state,
        date_trunc('month', purchased_at)   as month,
        count(distinct order_id)            as total_orders,
        avg(date_diff('day', purchased_at, delivered_at))           as avg_delivery_days,
        avg(date_diff('day', purchased_at, estimated_delivery_at))  as avg_estimated_days,
        sum(case when delivered_at <= estimated_delivery_at
            then 1 else 0 end)              as on_time_count,
        count(distinct order_id)            as total_delivered
    from orders
    group by 1, 2
)

select
    customer_state,
    month,
    total_orders,
    avg_delivery_days,
    avg_estimated_days,
    on_time_count,
    round(on_time_count * 100.0 / nullif(total_delivered, 0), 2) as on_time_rate
from delivery