{{ config(materialized='table') }}

with src as (
    select
        order_id,
        customer_id,
        customer_name,
        email,
        order_ts,
        country,
        state,
        amount,
        discount_pct,
        status,
        updated_at
    from DEMO_DB.RAW.CUSTOMER_ORDERS_RAW
),

cleaned as (
    select
        order_id::number(38,0)                                    as order_id,
        customer_id::number(38,0)                                 as customer_id,

        trim(customer_name)::string                               as customer_name,
        lower(trim(email))::string                                as email,

        order_ts::timestamp_ntz                                   as order_ts,
        date_trunc('day', order_ts)::date                         as order_date,

        upper(trim(country))::string                              as country,
        upper(trim(state))::string                                as state,

        amount::number(12,2)                                      as gross_amount,
        coalesce(discount_pct, 0)::number(5,2)                    as discount_pct,

        -- net_amount = gross - (gross * discount/100)
        round(amount * (1 - (coalesce(discount_pct,0) / 100)), 2) as net_amount,

        upper(trim(status))::string                               as status,

        updated_at::timestamp_ntz                                 as updated_at,

        case
          when amount >= 300 then 'HIGH'
          when amount >= 100 then 'MEDIUM'
          else 'LOW'
        end                                                       as amount_band

    from src
    where amount > 0
)

select * from cleaned