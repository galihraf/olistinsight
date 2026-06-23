
  
  create view "olist"."main"."stg_customers__dbt_tmp" as (
    with source as (select * from main.customers),
renamed as (
    select
        customer_id,
        customer_unique_id,
        customer_city,
        upper(customer_state) as customer_state
    from source
    where customer_id is not null
)
select * from renamed
  );
