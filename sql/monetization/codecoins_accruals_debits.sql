select
    'Начисление' as "Тип транзакции",
    sum(
        case
            when transaction.type_id = 29 or transaction.type_id between 2 and 22
            then transaction.value
        end
    ) as "Сумма CodeCoins"
from  transaction 
where true 
    and {{date}}
union all
select 
    'Списание' as "Тип транзакции",
	sum(
	    case 
	        when transaction.type_id = 1 or transaction.type_id between 23 and 28
	        then transaction.value 
	    end
    ) as "Сумма CodeCoins"
from  transaction 
where true 
    and {{date}};