
  
  create view "olist"."main"."stg_products__dbt_tmp" as (
    with source as (select * from main.products),
renamed as (
    select
        product_id,
        coalesce(product_category_name, 'unknown') as product_category_name,
        cast(product_weight_g as decimal(10,2)) as product_weight_g,
        cast(product_length_cm as decimal(10,2)) as product_length_cm
    from source
    where product_id is not null
)
select * from renamed
  );
