with user_purchases as (
    select
        transaction.user_id,
        count(*) as purchase_cnt
    from transaction 
    where true
        and transaction.type_id = 1 or transaction.type_id between 23 and 28
        and {{date}}
    group by transaction.user_id
)
select
    case when up.purchase_cnt > 1 then 'Повторная покупка' else 'Первая покупка' end as purchase_type,
    count(*) as user_cnt
from user_purchases up
group by purchase_type
order by user_cnt desc;