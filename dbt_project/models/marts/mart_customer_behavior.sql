with orders as (
    select * from {{ ref('int_orders_enriched') }}
    where order_status = 'delivered'
),

customer_orders as (
    select
        customer_id,
        customer_state,
        customer_city,
        count(distinct order_id)            as total_orders,
        sum(total_payment)                  as total_spent,
        avg(total_payment)                  as avg_order_value,
        min(purchased_at)                   as first_order_at,
        max(purchased_at)                   as last_order_at
    from orders
    group by 1, 2, 3
)

select
    customer_id,
    customer_state,
    customer_city,
    total_orders,
    total_spent,
    avg_order_value,
    first_order_at,
    last_order_at,
    case
        when total_orders = 1 then 'new'
        when total_orders between 2 and 4 then 'returning'
        else 'loyal'
    end as customer_segment
from customer_orders