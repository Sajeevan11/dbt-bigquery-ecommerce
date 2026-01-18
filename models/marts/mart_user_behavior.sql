{{
    config(
        materialized='table'
    )
}}

with users as (

    select * from {{ ref('stg_thelook__users') }}

),

customer_orders as (

    select * from {{ ref('mart_customer_orders') }}

),

user_behavior as (

    select
        -- User info
        u.user_id,
        u.first_name,
        u.last_name,
        u.user_email,
        u.user_created_at,
        
        -- Demographics
        u.user_age,
        u.user_gender,
        u.user_country,
        
        -- Age segmentation
        case 
            when u.user_age < 25 then 'Young (< 25)'
            when u.user_age < 35 then 'Adult (25-34)'
            when u.user_age < 50 then 'Middle Age (35-49)'
            when u.user_age < 65 then 'Senior (50-64)'
            else 'Elder (65+)'
        end as age_group,
        
        -- Order metrics (from mart_customer_orders)
        coalesce(co.total_orders, 0) as total_orders,
        coalesce(co.completed_orders, 0) as completed_orders,
        coalesce(co.cancelled_orders, 0) as cancelled_orders,
        coalesce(co.returned_orders, 0) as returned_orders,
        coalesce(co.completion_rate, 0) as completion_rate,
        coalesce(co.cancellation_rate, 0) as cancellation_rate,
        coalesce(co.return_rate, 0) as return_rate,
        co.first_order_date,
        co.last_order_date,
        co.customer_behavior,
        
        -- User classification
        case
            when co.total_orders is null then 'Never Ordered'
            when co.total_orders = 1 then 'One-Time Buyer'
            when co.total_orders between 2 and 5 then 'Occasional Buyer'
            when co.total_orders > 5 then 'Frequent Buyer'
        end as user_classification

    from users u
    left join customer_orders co on u.user_id = co.user_id

)

select * from user_behavior