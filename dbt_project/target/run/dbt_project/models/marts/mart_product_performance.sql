
  
    
    

    create  table
      "olist"."main"."mart_product_performance__dbt_tmp"
  
    as (
      with products as (
    select * from "olist"."main"."int_products_enriched"
),

monthly as (
    select
        oi.product_id,
        date_trunc('month', o.purchased_at) as month,
        count(distinct o.order_id)          as total_orders,
        sum(oi.price)                       as total_revenue
    from "olist"."main"."stg_order_items" oi
    left join "olist"."main"."int_orders_enriched" o on oi.order_id = o.order_id
    where o.order_status = 'delivered'
    group by 1, 2
)

select
    p.product_id,
    p.product_category_name,
    p.category_english,
    p.avg_review_score,
    m.month,
    m.total_orders,
    m.total_revenue
from products p
left join monthly m on p.product_id = m.product_id
    );
  
  