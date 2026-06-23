with source as (select * from main.sellers),
renamed as (
    select
        seller_id,
        seller_city,
        upper(seller_state) as seller_state
    from source
    where seller_id is not null
)
select * from renamed