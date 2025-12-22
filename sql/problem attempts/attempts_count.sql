with problem_attempts as (
    select 
        cds.created_at::date as dt
    from codesubmit cds
    where true
        [[and cds.created_at::date between {{date1}} and {{date2}}]]
    union all
    select 
        cdr.created_at::date as dt
    from coderun cdr
    where true
        [[and cdr.created_at::date between {{date1}} and {{date2}}]]
)
select
    date_trunc('month', pa.dt) as month_dt,
    count(*) as attempt_cnt
from problem_attempts pa
group by month_dt
order by month_dt;