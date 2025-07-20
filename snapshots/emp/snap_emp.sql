-- snapshots/emp.sql

{% snapshot emp_snapshot %}
{{
    config(
        target_schema='dbt_schema',
        unique_key='emp_no',
        strategy='check',
        check_cols=['name']
    )
}}

select
    emp_no,
    dno,
    name,
    sal,
    dob,
    remark
from xch.dev.emp


{% endsnapshot %}
