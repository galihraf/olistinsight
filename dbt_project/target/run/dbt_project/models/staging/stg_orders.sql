
  
  create view "olist"."main"."stg_orders__dbt_tmp" as (
    with source as (
    select * from main.orders
),

renamed as (
    select
        order_id,
        customer_id,
        order_status,
        cast(order_purchase_timestamp as timestamp) as purchased_at,
        cast(order_delivered_customer_date as timestamp) as delivered_at,
        cast(order_estimated_delivery_date as timestamp) as estimated_delivery_at
    from source
    where order_id is not null
)

select * from renamed
  );
