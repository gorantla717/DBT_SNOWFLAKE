{% snapshot customer_status_snapshot_check %}

{{
    config(
        target_schema='SNAPSHOTS',
        unique_key='customer_id',
        strategy='check',
        check_cols=['customer_name', 'email', 'country', 'status'],
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
from {{ source('raw', 'CUSTOMER_STATUS') }}

{% endsnapshot %}