with product as (
    select * from {{ ref('stg_products') }}
),

category as (
    select * from main.category_translation
),

order_items as (
    select
        product_id,
        count(distinct order_id) as total_orders,
        sum(price) as total_revenue,
        avg(price) as avg_price
    from {{ ref('stg_order_items') }}
    group by product_id
),

reviews as (
    select
        oi.product_id,
        avg(r.review_score) as avg_review_score
    from {{ ref('stg_reviews') }} r
    left join {{ ref('stg_order_items') }} oi on r.order_id = oi.order_id
    group by oi.product_id
)

select
    p.product_id,
    p.product_category_name,
    coalesce(c.product_category_name_english, p.product_category_name) as category_english,
    i.total_orders,
    i.total_revenue,
    i.avg_price,
    r.avg_review_score
from product p
left join category c on p.product_category_name = c.product_category_name
left join order_items i on p.product_id = i.product_id
left join reviews r on p.product_id = r.product_id