with mau as (
    select
        date_trunc('month', userentry.entry_at)::date as year_month,
        count(distinct userentry.user_id) as user_month_cnt
    from userentry 
    where true
        and {{date}}
    group by year_month
)
select
    'Среднее' as "Cпопсоб расчета",
    round(avg(mau.user_month_cnt)) as "MAU"
from mau
union all
select
    'Медиана' as "Cпопсоб расчета",
    percentile_disc(0.5) within group(order by mau.user_month_cnt) as "MAU"
from mau;