{{ config(materialized='table') }}

SELECT 
    t1.emp_no, 
    t1.dno, 
    t2.dname,
    t1.name, 
    t1.sal, 
    t1.dob, 
    t1.remark
FROM 
    {{ source('xch', 'emp') }} AS t1
JOIN 
    {{ ref('dept') }} AS t2
ON 
    t1.dno = t2.dno
