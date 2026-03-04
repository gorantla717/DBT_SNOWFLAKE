{% macro table_update() -%}
    {% set sql_query%}
      update DEMO_DB.STG_SCHEMA.ORDERS_EXAMPLE
      set descr = 'P'
      where ID = 1;  
    {% endset %}

{% do run_query(sql_query) %}
 
{%- endmacro %}