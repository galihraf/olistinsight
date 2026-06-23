
  
  create view "olist"."main"."stg_order_items__dbt_tmp" as (
    with source as (
    select * from main.order_items
),

renamed as (
    select
        order_id,
        order_item_id,
        product_id,
        seller_id,
        cast(shipping_limit_date as timestamp) as shipping_limit_at,
        cast(price as decimal(10,2)) as price,
        cast(freight_value as decimal(10,2)) as freight_value
    from source
    where order_id is not null
    and price >= 0
)

select * from renamed
  );
