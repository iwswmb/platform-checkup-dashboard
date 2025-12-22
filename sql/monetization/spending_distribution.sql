select
    trt.description as "Тип списания",
    count(*) as "Кол-во покупок"
from transaction 
join transactiontype trt
    on transaction.type_id = trt.type
where true
    and trt.type = 1 or trt.type between 23 and 28
    and {{date}}
group by trt.type, trt.description
order by count(*) desc;