with source as (select * from main.reviews),
renamed as (
    select
        review_id,
        order_id,
        cast(review_score as integer) as review_score,
        cast(review_creation_date as timestamp) as reviewed_at
    from source
    where order_id is not null
)
select * from renamed