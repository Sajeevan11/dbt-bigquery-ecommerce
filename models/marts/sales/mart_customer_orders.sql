{{
    config(
        materialized='table'
    )
}}

with orders as (

    select * from {{ ref('stg_thelook__orders') }}

),

customer_metrics as (

    select
        user_id,
        
        -- Compteurs par statut
        count(*) as total_orders,
        count(case when order_status = 'Complete' then 1 end) as completed_orders,
        count(case when order_status = 'Cancelled' then 1 end) as cancelled_orders,
        count(case when order_status = 'Returned' then 1 end) as returned_orders,
        count(case when order_status = 'Processing' then 1 end) as processing_orders,
        count(case when order_status = 'Shipped' then 1 end) as shipped_orders,
        
        -- Taux calculés (%)
        round(
            count(case when order_status = 'Complete' then 1 end) * 100.0 / count(*),
            2
        ) as completion_rate,
        
        round(
            count(case when order_status = 'Cancelled' then 1 end) * 100.0 / count(*),
            2
        ) as cancellation_rate,
        
        round(
            count(case when order_status = 'Returned' then 1 end) * 100.0 / count(*),
            2
        ) as return_rate,
        
        -- Nombre total d'items commandés
        sum(number_of_items) as total_items_ordered,
        
        -- Dates importantes
        min(order_created_at) as first_order_date,
        max(order_created_at) as last_order_date,
        
        -- Statut dominant
        case
            when count(case when order_status = 'Complete' then 1 end) >= count(*) * 0.5 
                then 'Mostly Complete'
            when count(case when order_status = 'Cancelled' then 1 end) >= count(*) * 0.3 
                then 'High Cancellation'
            when count(case when order_status = 'Returned' then 1 end) >= count(*) * 0.2 
                then 'High Returns'
            else 'Mixed'
        end as customer_behavior

    from orders
    group by user_id

)

select * from customer_metrics