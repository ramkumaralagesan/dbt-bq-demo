{{ config(
    materialized='incremental',
    unique_key='emp_no',
    incremental_strategy='merge'
) }}

WITH source_data AS (
    SELECT
        emp_no,
        dno,
        name,
        sal,
        dob,
        remark
    FROM {{ source('xch', 'emp') }}
)

{% if is_incremental() %}
, existing_data AS (
    SELECT * FROM {{ this }}
)
{% endif %}

SELECT
    s.emp_no,
    s.dno,
    s.name,
    s.sal,
    s.dob,
    s.remark,

    {% if is_incremental() %}
        CASE
            WHEN e.name IS NOT NULL AND e.name != s.name THEN e.name
            ELSE e.previous_name
        END AS previous_name
    {% else %}
        NULL AS previous_name
    {% endif %}

FROM source_data s
{% if is_incremental() %}
LEFT JOIN existing_data e ON s.emp_no = e.emp_no
{% endif %}
