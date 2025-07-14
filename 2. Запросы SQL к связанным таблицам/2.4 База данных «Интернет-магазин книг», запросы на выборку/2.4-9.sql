SELECT buy_id, name_client, SUM(bb.amount * b.price) AS Стоимость
FROM client
JOIN buy USING(client_id)
JOIN buy_book bb USING(buy_id)
JOIN book b USING(book_id)
GROUP BY buy_id, name_client
ORDER BY buy_id;


-- с сайта
