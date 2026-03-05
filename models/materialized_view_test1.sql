{{ config(materialized='materialized_view') }}

select
    * 
    from {{ref('fct_orders_incremental')}} 
    where order_id < 6