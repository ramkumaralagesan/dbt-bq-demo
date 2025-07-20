-- snapshots/emp2.sql

{% snapshot emp_snapshot2 %}
{{
    config(
        target_schema='dbt_schema',
        unique_key='emp_no',
        strategy='timestamp',
        updated_at='last_updated'        
    )
}}

select
    emp_no,
    dno,
    name,
    sal,
    dob,
    remark,
    last_updated
from xch.dev.emp


{% endsnapshot %}
