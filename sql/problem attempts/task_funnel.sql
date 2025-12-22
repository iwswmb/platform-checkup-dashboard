with problem_attempts as (
    select 
        cds.user_id
    from codesubmit cds
    where true
        [[and cds.created_at::date between {{date1}} and {{date2}}]]
    union 
    select 
        cdr.user_id
    from coderun cdr
    where true
        [[and cdr.created_at::date between {{date1}} and {{date2}}]]
)
select
    'Попытались решить' as type,
    count(*) as cnt
from problem_attempts pa
union all
select
    'Решили верно' as type,
    count(distinct cds.user_id) filter(where cds.is_false = 0) as cnt
from codesubmit cds
where true
    [[and cds.created_at::date between {{date1}} and {{date2}}]]
union all
select
    'Пополнили кошелек' as type,
    count(distinct t.user_id) filter(where t.type_id = 2) as cnt
from transaction t
where true
    [[and t.created_at::date between {{date1}} and {{date2}}]]
order by cnt desc;