{{ config(
    materialized='table'
) }}

with first_orders as (

  select first_order_at, customer_id from {{ ref('customers') }}

)

select 
    date_trunc(first_order_at, DAY) as first_order_date
    , count(distinct(customer_id)) as customers_first_ordered
from first_orders
group by 1
order by 1 desc