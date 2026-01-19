{{ config(materialized='view') }}

with source as (
    select * from {{ source('thelook', 'products') }}
),
renamed as (
    select 
    id as product_id, 
    coalesce(name, 'Unknown Product') as product_name, 
    category as product_category,
    brand as product_brand,
    retail_price as product_price

    from source

)
select * from renamed