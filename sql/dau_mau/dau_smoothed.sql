with active_user_counts as (
    select
        ue.entry_at::date as dt,
        count(distinct ue.user_id) as user_cnt
    from userentry ue
    group by dt
),
dau as (
    select
        auc.dt,
        round(sum(auc.user_cnt) over w / 30) as avg_dau
    from active_user_counts auc
    window w as (
        order by auc.dt
        range between interval '29 days' preceding and current row
    )
)
select 
    dau.dt,
    dau.avg_dau
from dau
where true
    [[and dau.dt between {{date1}} and {{date2}}]]
order by dau.dt;