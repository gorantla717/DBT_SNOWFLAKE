{{ 
  config(
    materialized='table',
    schema=generate_schema_name('STG_SCHEMA', this)
  ) 
}}

select
  1 as id,
  'sample' as descr,
  current_timestamp() as loaded_at