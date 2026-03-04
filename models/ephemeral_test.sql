{{ config(materialized='ephemeral') }}
select
    * 
    from {{ref('fct_orders_incremental')}} 