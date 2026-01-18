{{
    config(
        materialized='view'
    )
}}

with source as (

    select * from {{ source('thelook', 'users') }}

),

renamed as (

    select
        -- IDs
        id as user_id,
        
        -- Personal info
        first_name,
        last_name,
        email as user_email,
        
        -- Demographics
        age as user_age,
        gender as user_gender,
        country as user_country,
        
        -- Dates
        created_at as user_created_at
        
    from source

)

select * from renamed