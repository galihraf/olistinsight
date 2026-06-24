with sellers as (
    select * from {{ ref('int_sellers_enriched') }}
),

orders as (
    select
        oi.seller_id,
        count(distinct o.order_id) as total_orders,
        avg(date_diff('day', o.purchased_at, o.delivered_at)) as avg_delivery_days,
        sum(case when o.delivered_at <= o.estimated_delivery_at 
            then 1 else 0 end) as on_time_deliveries
    from {{ ref('int_orders_enriched') }} o
    left join {{ ref('stg_order_items') }} oi on o.order_id = oi.order_id
    where o.order_status = 'delivered'
    group by oi.seller_id
)

select
    s.seller_id,
    s.seller_city,
    s.seller_state,
    s.total_revenue,
    s.avg_review_score,
    o.total_orders,
    o.avg_delivery_days,
    o.on_time_deliveries,
    round(o.on_time_deliveries * 100.0 / nullif(o.total_orders, 0), 2) as on_time_rate
from sellers s
left join orders o on s.seller_id = o.seller_id