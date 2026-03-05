{{ config(
    materialized='incremental',
    unique_key='order_id',
    incremental_strategy='merge'

) }}

with src as (
    select
        order_id::number(38,0)        as order_id,
        customer_id::number(38,0)     as customer_id,
        order_ts::timestamp_ntz       as order_ts,
        amount::number(12,2)          as amount,
        upper(trim(status))           as status,
        updated_at::timestamp_ntz     as updated_at
    from DEMO_DB.RAW.ORDERS_RAW

    {% if is_incremental() %}
      -- Only bring rows newer than what has already been loaded
      where updated_at > (select coalesce(max(updated_at), '1900-01-01'::timestamp_ntz) from {{ this }})
    {% endif %}
)

select
    order_id,
    customer_id,
    order_ts,
    date_trunc('day', order_ts)::date as order_date,
    amount,
    status,
    updated_at,

    case
      when amount >= 300 then 'HIGH'
      when amount >= 100 then 'MEDIUM'
      else 'LOW'
    end as amount_band,
    current_date as insert_date,
    current_time() as insert_timestamp
from src