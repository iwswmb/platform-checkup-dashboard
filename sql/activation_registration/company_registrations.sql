select
    coalesce(c.name, 'Без компании') as "Название компании",
    count(*) as "Кол-во регистраций"
from users
left join company c 
    on users.company_id = c.id
where true 
    and {{date}}
group by c.id, c.name
order by count(*) desc;