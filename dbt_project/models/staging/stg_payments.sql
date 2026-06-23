with source as (select * from main.payments),
renamed as (
    select
        order_id,
        payment_sequential,
        payment_type,
        payment_installments,
        cast(payment_value as decimal(10,2)) as payment_value
    from source
    where order_id is not null
)
select * from renamed