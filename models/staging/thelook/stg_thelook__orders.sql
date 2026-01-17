{{
    config(
        materialized='view'
    )
}}

with source as (

    select * from {{ source('thelook', 'orders') }}

),

renamed as (

    select
        -- IDs
        order_id,
        user_id,
        
        -- Order details
        status as order_status,
        gender as customer_gender,
        
        -- Dates
        created_at as order_created_at,
        returned_at as order_returned_at,
        shipped_at as order_shipped_at,
        delivered_at as order_delivered_at,
        
        -- Metrics
        num_of_item as number_of_items

    from source

)

select * from renamed