with orders as (
    select * from {{ ref('stg_orders') }}
),

order_items as (
    select
        order_id,
        sum(price) as total_price,
        sum(freight_value) as total_freight,
        count(order_item_id) as total_items
    from {{ ref('stg_order_items') }}
    group by order_id
),

payments as (
    select
        order_id,
        sum(payment_value) as total_payment,
        max(payment_type) as payment_type
    from {{ ref('stg_payments') }}
    group by order_id
),

customers as (
    select * from {{ ref('stg_customers') }}
)

select
    o.order_id,
    o.customer_id,
    o.order_status,
    o.purchased_at,
    o.delivered_at,
    o.estimated_delivery_at,
    c.customer_city,
    c.customer_state,
    i.total_items,
    i.total_price,
    i.total_freight,
    p.total_payment,
    p.payment_type
from orders o
left join order_items i on o.order_id = i.order_id
left join payments p on o.order_id = p.order_id
left join customers c on o.customer_id = c.customer_id