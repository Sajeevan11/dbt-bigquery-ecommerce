{{
    config(
        materialized='view'
    )
}}


with source as (

    select * from {{ source('thelook', 'order_items') }}

),

renamed as (
    
    select id as order_item_id,
           order_id,
           user_id,
           product_id,
           sale_price,
           status as order_item_status,
           created_at as order_item_created_at,
           shipped_at as order_item_shipped_at,
           delivered_at as order_item_delivered_at,
           returned_at as order_item_returned_at
    from source

)

select * from renamed