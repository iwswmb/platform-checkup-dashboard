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
)
select
	c.cohort as "Когорта",
	round(100.0 * count(distinct c.user_id) / count(distinct c.user_id), 2) as "День 0 (%)",
	round(100.0 * count(distinct c.user_id) filter(where c.diff_days >= 1) / count(distinct c.user_id), 2) as "День 1 (%)",
	round(100.0 * count(distinct c.user_id) filter(where c.diff_days >= 3) / count(distinct c.user_id), 2) as "День 3 (%)",
	round(100.0 * count(distinct c.user_id) filter(where c.diff_days >= 7) / count(distinct c.user_id), 2) as "День 7 (%)",
	round(100.0 * count(distinct c.user_id) filter(where c.diff_days >= 14) / count(distinct c.user_id), 2) as "День 14 (%)",
	round(100.0 * count(distinct c.user_id) filter(where c.diff_days >= 30) / count(distinct c.user_id), 2) as "День 30 (%)",
	round(100.0 * count(distinct c.user_id) filter(where c.diff_days >= 60) / count(distinct c.user_id), 2) as "День 60 (%)",
	round(100.0 * count(distinct c.user_id) filter(where c.diff_days >= 90) / count(distinct c.user_id), 2) as "День 90 (%)"
from cohorts c
group by c.cohort
order by c.cohort;