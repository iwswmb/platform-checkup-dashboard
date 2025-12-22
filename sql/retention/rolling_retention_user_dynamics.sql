with cohorts as (
	select 
		ue.user_id,
		to_char(users.date_joined, 'YYYY-MM') as cohort,
		extract(day from ue.entry_at - users.date_joined) as diff_days
	from userentry ue
	join users 
		on ue.user_id = users.id
	where true
	    and ue.entry_at::date - users.date_joined::date >= 0
	    and {{date}}
),
users_retention as (
	select
		c.cohort,
		count(distinct c.user_id) as day_0,
		count(distinct c.user_id) filter(where c.diff_days >= 1) as day_1,
		count(distinct c.user_id) filter(where c.diff_days >= 3) as day_3,
		count(distinct c.user_id) filter(where c.diff_days >= 7) as day_7,
		count(distinct c.user_id) filter(where c.diff_days >= 14) as day_14,
		count(distinct c.user_id) filter(where c.diff_days >= 30) as day_30,
		count(distinct c.user_id) filter(where c.diff_days >= 60) as day_60,
		count(distinct c.user_id) filter(where c.diff_days >= 90) as day_90
	from cohorts c
	group by c.cohort
)
select 
    ur.cohort,
    0 as days,
    ur.day_0 as user_cnt
from users_retention ur
union all
select 
    ur.cohort,
    1 as days,
    ur.day_1 as user_cnt
from users_retention ur
union all
select 
    ur.cohort,
    3 as days,
    ur.day_3 as user_cnt
from users_retention ur
union all
select 
    ur.cohort,
    7 as days,
    ur.day_7 as user_cnt
from users_retention ur
union all
select 
    ur.cohort,
    14 as days,
    ur.day_14 as user_cnt
from users_retention ur
union all
select 
    ur.cohort,
    30 as days,
    ur.day_30 as user_cnt
from users_retention ur
union all
select 
    ur.cohort,
    60 as days,
    ur.day_60 as user_cnt
from users_retention ur
union all
select 
    ur.cohort,
    90 as days,
    ur.day_90 as user_cnt
from users_retention ur
order by cohort, days;