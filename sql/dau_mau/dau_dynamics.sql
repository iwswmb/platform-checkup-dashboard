select 
    userentry.entry_at::date as dt,
    count(distinct userentry.user_id) as user_cnt
from userentry
where true 
    and {{date}}
group by dt 
order by dt;