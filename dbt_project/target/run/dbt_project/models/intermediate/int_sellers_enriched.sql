
  
  create view "olist"."main"."int_sellers_enriched__dbt_tmp" as (
    with sellers as (
    select * from "olist"."main"."stg_sellers"
),

order_items as (
    select
        seller_id,
        count(distinct order_id) as total_orders,
        sum(price) as total_revenue,
        avg(price) as avg_price,
    from "olist"."main"."stg_order_items"
    group by seller_id
),

reviews as (
    select
        oi.seller_id,
        avg(r.review_score) as avg_review_score,
    from "olist"."main"."stg_reviews" r
    left join "olist"."main"."stg_order_items" oi on r.order_id = oi.order_id
    group by oi.seller_id
)

select
    s.seller_id,
    s.seller_city,
    s.seller_state,
    i.total_orders,
    i.total_revenue,
    i.avg_price,
    r.avg_review_score
from sellers s
left join order_items i on s.seller_id = i.seller_id
left join reviews r on s.seller_id = r.seller_id
  );
