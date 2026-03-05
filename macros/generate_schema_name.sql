{% macro generate_schema_name(custom_schema_name, node) -%}

  {{ log("Starting generate_schema_name macro", info=True) }}

  {%- set dafault_schema = target.schema -%}

  {{ log("Default schema from target: " ~ dafault_schema, info=True) }}

  {%- if custom_schema_name is none -%}

      {{ log("Custom schema not provided. Using default schema: " ~ dafault_schema, info=True) }}

      {{ dafault_schema }}

  {%- else -%}

      {{ log("Custom schema provided: " ~ custom_schema_name, info=True) }}

      {{ custom_schema_name }}

  {%- endif -%}

  {{ log("Completed generate_schema_name macro", info=True) }}

  {{ log("GVB Custom Printing", info=True) }}

  {{ log("GVB Custom Printing - Info false")}}
{%- endmacro %}