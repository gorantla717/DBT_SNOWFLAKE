{% snapshot customer_status_snapshot %}

{{
    config(
      target_schema='SNAPSHOTS',
      unique_key='customer_id',
      strategy='timestamp',
      updated_at='updated_at',
      invalidate_hard_deletes=True
    )
}}

select
    customer_id,
    customer_name,
    email,
    country,
    status,
    updated_at
from DEMO_DB.RAW.CUSTOMER_STATUS

{% endsnapshot %}