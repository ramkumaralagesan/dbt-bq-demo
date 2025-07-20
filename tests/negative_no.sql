SELECT  sal 
FROM {{ ref('emp') }}
where sal<0
