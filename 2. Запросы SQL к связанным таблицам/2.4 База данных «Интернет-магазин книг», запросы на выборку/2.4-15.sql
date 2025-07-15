SELECT title,
    SUM(Количество) AS Количество,
    SUM(Сумма) AS Сумма
FROM (
        SELECT b.title,
            SUM(ba.amount) Количество,
            SUM(ba.price * ba.amount) Сумма
        FROM buy_archive ba
            INNER JOIN book b USING(book_id)
        GROUP BY 1
        UNION
        SELECT title,
            SUM(bb.amount) Количество,
            SUM(price * bb.amount) Сумма
        FROM book
            INNER JOIN buy_book bb USING(book_id)
            INNER JOIN buy USING(buy_id)
            INNER JOIN buy_step USING(buy_id)
            INNER JOIN step USING(step_id)
        WHERE date_step_end
            AND name_step = "Оплата"
        GROUP BY 1
    ) AS combined_data
GROUP BY title
ORDER BY 3 DESC;