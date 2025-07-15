SELECT YEAR(date_payment) Год, MONTHNAME(date_payment) Месяц, SUM(price * amount) Сумма
FROM 
    buy_archive
GROUP BY 1, 2

UNION

SELECT YEAR(date_step_end) Год, MONTHNAME(date_step_end) Месяц, SUM(price * bb.amount) Сумма
FROM 
    book 
    INNER JOIN buy_book bb USING(book_id)
    INNER JOIN buy USING(buy_id) 
    INNER JOIN buy_step USING(buy_id)
    INNER JOIN step USING(step_id)                  
WHERE  date_step_end AND name_step = "Оплата"  
GROUP BY 1, 2
ORDER BY 2, 1
