with entries as (
	select
		'Всего заходов на платформу' as "Название",
		count(*) filter(where extract(month from ue.entry_at) = 1) as "Январь", 
		count(*) filter(where extract(month from ue.entry_at) = 2) as "Февраль", 
		count(*) filter(where extract(month from ue.entry_at) = 3) as "Март",
		count(*) filter(where extract(month from ue.entry_at) in (1, 2, 3)) as "Q1", 
		count(*) filter(where extract(month from ue.entry_at) = 4) as "Апрель", 
		count(*) filter(where extract(month from ue.entry_at) = 5) as "Май", 
		count(*) filter(where extract(month from ue.entry_at) = 6) as "Июнь",
		count(*) filter(where extract(month from ue.entry_at) in (4, 5, 6)) as "Q2",
		count(*) filter(where extract(month from ue.entry_at) = 7) as "Июль", 
		count(*) filter(where extract(month from ue.entry_at) = 8) as "Август", 
		count(*) filter(where extract(month from ue.entry_at) = 9) as "Сентябрь",
		count(*) filter(where extract(month from ue.entry_at) in (7, 8, 9)) as "Q3",
		count(*) filter(where extract(month from ue.entry_at) = 10) as "Октябрь", 
		count(*) filter(where extract(month from ue.entry_at) = 11) as "Ноябрь", 
		count(*) filter(where extract(month from ue.entry_at) = 12) as "Декабрь",
		count(*) filter(where extract(month from ue.entry_at) in (10, 11, 12)) as "Q4"
	from userentry ue
	where true 
		and to_char(ue.entry_at, 'YYYY') = {{year}}
	group by extract(month from ue.entry_at)
),
quarter_unique_users as (
    select 
        'Уникальных пользователей' as "Название",
        count(distinct ue.user_id) filter(where extract(quarter from ue.entry_at) = 1) as "Q1",
        count(distinct ue.user_id) filter(where extract(quarter from ue.entry_at) = 2) as "Q2",
        count(distinct ue.user_id) filter(where extract(quarter from ue.entry_at) = 3) as "Q3",
        count(distinct ue.user_id) filter(where extract(quarter from ue.entry_at) = 4) as "Q4"
    from userentry ue
    where true  
        and to_char(ue.entry_at, 'YYYY') = {{year}}
    group by extract(quarter from ue.entry_at)
),
unique_users as (
	select 
		'Уникальных пользователей' as "Название",
		count(distinct ue.user_id) filter(where extract(month from ue.entry_at) = 1) as "Январь", 
		count(distinct ue.user_id) filter(where extract(month from ue.entry_at) = 2) as "Февраль", 
		count(distinct ue.user_id) filter(where extract(month from ue.entry_at) = 3) as "Март", 
		0 as "Q1", 
		count(distinct ue.user_id) filter(where extract(month from ue.entry_at) = 4) as "Апрель", 
		count(distinct ue.user_id) filter(where extract(month from ue.entry_at) = 5) as "Май", 
		count(distinct ue.user_id) filter(where extract(month from ue.entry_at) = 6) as "Июнь",
		0 as "Q2", 
		count(distinct ue.user_id) filter(where extract(month from ue.entry_at) = 7) as "Июль", 
		count(distinct ue.user_id) filter(where extract(month from ue.entry_at) = 8) as "Август", 
		count(distinct ue.user_id) filter(where extract(month from ue.entry_at) = 9) as "Сентябрь",
		0 as "Q3", 
		count(distinct ue.user_id) filter(where extract(month from ue.entry_at) = 10) as "Октябрь", 
		count(distinct ue.user_id) filter(where extract(month from ue.entry_at) = 11) as "Ноябрь", 
		count(distinct ue.user_id) filter(where extract(month from ue.entry_at) = 12) as "Декабрь",
		0 as "Q4"
	from userentry ue
	where true 
		and to_char(ue.entry_at, 'YYYY') = {{year}}
	group by extract(month from ue.entry_at)
	union all
	select
	    quu."Название",
	    0, 0, 0,
	    quu."Q1",
	    0, 0, 0,
	    quu."Q2",
        0, 0, 0,
	    quu."Q3",
	    0, 0, 0,
	    quu."Q4"
	from quarter_unique_users quu
),
problem_attempts as (
	select
        cds.created_at
    from codesubmit cds
    union all
    select
        cdr.created_at
    from coderun cdr 
),
attempts as (
	select 
		'Попыток решения задач' as "Название",
		count(*) filter(where extract(month from pa.created_at) = 1) as "Январь", 
		count(*) filter(where extract(month from pa.created_at) = 2) as "Февраль", 
		count(*) filter(where extract(month from pa.created_at) = 3) as "Март",
		count(*) filter(where extract(month from pa.created_at) in (1, 2, 3)) as "Q1", 
		count(*) filter(where extract(month from pa.created_at) = 4) as "Апрель", 
		count(*) filter(where extract(month from pa.created_at) = 5) as "Май", 
		count(*) filter(where extract(month from pa.created_at) = 6) as "Июнь",
		count(*) filter(where extract(month from pa.created_at) in (4, 5, 6)) as "Q2",
		count(*) filter(where extract(month from pa.created_at) = 7) as "Июль", 
		count(*) filter(where extract(month from pa.created_at) = 8) as "Август", 
		count(*) filter(where extract(month from pa.created_at) = 9) as "Сентябрь",
		count(*) filter(where extract(month from pa.created_at) in (7, 8, 9)) as "Q3",
		count(*) filter(where extract(month from pa.created_at) = 10) as "Октябрь", 
		count(*) filter(where extract(month from pa.created_at) = 11) as "Ноябрь", 
		count(*) filter(where extract(month from pa.created_at) = 12) as "Декабрь",
		count(*) filter(where extract(month from pa.created_at) in (10, 11, 12)) as "Q4"
	from problem_attempts pa
	where true 
		and to_char(pa.created_at, 'YYYY') = {{year}}
	group by extract(month from pa.created_at)
),
successful_attempts as (
	select 
		'Успешных попыток' as "Название",
		count(*) filter(where extract(month from cds.created_at) = 1) as "Январь", 
		count(*) filter(where extract(month from cds.created_at) = 2) as "Февраль", 
		count(*) filter(where extract(month from cds.created_at) = 3) as "Март",
		count(*) filter(where extract(month from cds.created_at) in (1, 2, 3)) as "Q1", 
		count(*) filter(where extract(month from cds.created_at) = 4) as "Апрель", 
		count(*) filter(where extract(month from cds.created_at) = 5) as "Май", 
		count(*) filter(where extract(month from cds.created_at) = 6) as "Июнь",
		count(*) filter(where extract(month from cds.created_at) in (4, 5, 6)) as "Q2",
		count(*) filter(where extract(month from cds.created_at) = 7) as "Июль", 
		count(*) filter(where extract(month from cds.created_at) = 8) as "Август", 
		count(*) filter(where extract(month from cds.created_at) = 9) as "Сентябрь",
		count(*) filter(where extract(month from cds.created_at) in (7, 8, 9)) as "Q3",
		count(*) filter(where extract(month from cds.created_at) = 10) as "Октябрь", 
		count(*) filter(where extract(month from cds.created_at) = 11) as "Ноябрь", 
		count(*) filter(where extract(month from cds.created_at) = 12) as "Декабрь",
		count(*) filter(where extract(month from cds.created_at) in (10, 11, 12)) as "Q4"
	from codesubmit cds
	where true 
	    and cds.is_false = 0
		and to_char(cds.created_at, 'YYYY') = {{year}}
	group by extract(month from cds.created_at)
),
month_problems_per_user as (
    select 
        cds.user_id,
        extract(month from cds.created_at) as month_num,
        count(distinct cds.problem_id) as problem_cnt
    from codesubmit cds
    where true 
        and cds.is_false = 0
    	and to_char(cds.created_at, 'YYYY') = {{year}}
    group by month_num, cds.user_id
),
solved_problems as (
    select
        'Успешно решенных задач' as "Название",
        case when mppu.month_num = 1 then sum(mppu.problem_cnt) else 0 end as "Январь",
        case when mppu.month_num = 2 then sum(mppu.problem_cnt) else 0 end as "Февраль",
        case when mppu.month_num = 3 then sum(mppu.problem_cnt) else 0 end as "Март",
        case when mppu.month_num in (1, 2, 3) then sum(mppu.problem_cnt) else 0 end as "Q1",
        case when mppu.month_num = 4 then sum(mppu.problem_cnt) else 0 end as "Апрель",
        case when mppu.month_num = 5 then sum(mppu.problem_cnt) else 0 end as "Май",
        case when mppu.month_num = 6 then sum(mppu.problem_cnt) else 0 end as "Июнь",
        case when mppu.month_num in (4, 5, 6) then sum(mppu.problem_cnt) else 0 end as "Q2",
        case when mppu.month_num = 7 then sum(mppu.problem_cnt) else 0 end as "Июль",
        case when mppu.month_num = 8 then sum(mppu.problem_cnt) else 0 end as "Август",
        case when mppu.month_num = 9 then sum(mppu.problem_cnt) else 0 end as "Сентябрь",
        case when mppu.month_num in (7, 8, 9) then sum(mppu.problem_cnt) else 0 end as "Q3",
        case when mppu.month_num = 10 then sum(mppu.problem_cnt) else 0 end as "Октябрь",
        case when mppu.month_num = 11 then sum(mppu.problem_cnt) else 0 end as "Ноябрь",
        case when mppu.month_num = 12 then sum(mppu.problem_cnt) else 0 end as "Декабрь",
        case when mppu.month_num in (10, 11, 12) then sum(mppu.problem_cnt) else 0 end as "Q4"
    from month_problems_per_user mppu
    group by mppu.month_num
),
all_metrics as (
	select
	    e.*,
	    1 as order_num
	from entries e
	union all
	select
	    uu.*,
	    2 as order_num
	from unique_users uu
	union all
	select 
	    a.*,
	    3 as order_num
	from attempts a
	union all
	select 
	    sa.*,
	    4 as order_num
	from successful_attempts sa
	union all
	select
	    sp.*,
	    5 as order_num
	from solved_problems sp
)
select 
    am."Название", 
    max(am."Январь") as "Январь",
    max(am."Февраль") as "Февраль",
    max(am."Март") as "Март",
    sum(am."Q1") as "Q1",
    max(am."Апрель") as "Апрель",
    max(am."Май") as "Май",
    max(am."Июнь") as "Июнь",
    sum(am."Q2") as "Q2",
    max(am."Июль") as "Июль",
    max(am."Август") as "Август",
    max(am."Сентябрь") as "Сентябрь",
    sum(am."Q3") as "Q3",
    max(am."Октябрь") as "Октябрь",
    max(am."Ноябрь") as "Ноябрь",
    max(am."Декабрь") as "Декабрь",
    sum(am."Q4") as "Q4"
from all_metrics am
group by am."Название", am.order_num
order by am.order_num;