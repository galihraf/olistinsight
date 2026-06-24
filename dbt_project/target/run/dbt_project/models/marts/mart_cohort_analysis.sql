
  
    
    

    create  table
      "olist"."main"."mart_cohort_analysis__dbt_tmp"
  
    as (
      with orders as (
    select * from "olist"."main"."int_orders_enriched"
    where order_status = 'delivered'
),

cohort as (
    select
        customer_id,
        date_trunc('month', min(purchased_at)) as cohort_month
    from orders
    group by 1
),

orders_with_cohort as (
    select
        o.customer_id,
        c.cohort_month,
        date_trunc('month', o.purchased_at) as order_month,
        date_diff('month', c.cohort_month, date_trunc('month', o.purchased_at)) as month_number
    from orders o
    left join cohort c on o.customer_id = c.customer_id
)

select
    cohort_month,
    month_number,
    count(distinct customer_id) as total_customers
from orders_with_cohort
group by 1, 2
order by 1, 2
    );
  
  