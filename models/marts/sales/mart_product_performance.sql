{{ config(materialized='table') }}

with products as (
    select * from {{ ref('stg_thelook__products') }}
),
order_items as (
    select * from {{ ref('stg_thelook__order_items') }}
),
orders as (
    select * from {{ ref('stg_thelook__orders') }}
),
product_metrics as (
    select
        p.product_id,
        p.product_name,
        p.product_category,
        p.product_brand,
        count(oi.order_item_id) as total_orders,
        sum(case when o.order_status = 'Complete' then 1 else 0 end) as completed_orders,
        round(avg(p.product_price), 2) as avg_price
    from products p
    left join order_items oi on p.product_id = oi.product_id
    left join orders o on oi.order_id = o.order_id
    group by p.product_id, p.product_name, p.product_category, p.product_brand
)
select * from product_metrics