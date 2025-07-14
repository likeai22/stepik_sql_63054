SELECT bb.buy_id, bk.title, bk.price, bb.amount
FROM 
    client c
    JOIN buy b USING(client_id)
    JOIN buy_book bb USING(buy_id)
    JOIN book bk USING(book_id)
WHERE c.name_client LIKE '%Баранов П%'
ORDER BY bb.buy_id, bk.title; 


-- с сайта
-- Найти Баранова Павла, а затем подтянуть для него инфу из других таблиц по идее оптимальнее чем сначала соединить таблицы, а затем искать

select buy.buy_id, title, price, buy_book.amount
from (select * from client where name_client='Баранов Павел') as q1
    inner join buy on q1.client_id=buy.client_id
    inner join buy_book on buy.buy_id=buy_book.buy_id
    inner join book on buy_book.book_id=book.book_id
order by buy.buy_id, title