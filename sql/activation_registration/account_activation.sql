select
    case when users.is_active = 0 then 'Не активировали' else 'Активировали' end as activation_type,
    count(*) as cnt
from users
where true
    and {{date}}
group by users.is_active;