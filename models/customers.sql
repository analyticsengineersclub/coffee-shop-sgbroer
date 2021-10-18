{{ config(
    materialized='table'
) }}


with customers as (

    select * from `analytics-engineers-club.coffee_shop.customers`

)

, orders as (

    select * from `analytics-engineers-club.coffee_shop.orders`

)

select 
        customers.id as customer_id,
        customers.name,
        customers.email,
        min(orders.created_at) as first_order_at,
        count(distinct(orders.id)) as number_of_orders, 
    from customers
    left join orders on customers.id = orders.customer_id
    group by 1, 2, 3
    order by first_order_at

