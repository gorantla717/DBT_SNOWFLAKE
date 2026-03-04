{{ config(
    materialized='table',
    pre_hook=[
      "CREATE OR REPLACE TABLE DEMO_DB.STG_SCHEMA.EMPLOYEE (
    EMP_ID      NUMBER,
    EMP_NAME    STRING,
    SALARY      NUMBER(10,2)
    );"
    ],
    post_hook=[
      "INSERT INTO DEMO_DB.STG_SCHEMA.EMPLOYEE (EMP_ID, EMP_NAME, SALARY) VALUES
(1, 'John', 50000.00),
(2, 'Sara', 60000.00),
(3, 'Mike', 55000.00);"
    ]
) }}

select *
from {{ ref('fct_orders_incremental') }}