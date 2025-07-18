-- Придумайте один или несколько запросов к нашей таблице book, используя вложенные запросы. Проверьте, правильно ли они работают.

-- delete from book where book_id = 8;

SELECT author,
    title,
    price,
    amount,
    ROUND(100 * price*amount / (SELECT SUM(price*amount) FROM book), 2) income_percent
FROM book
ORDER BY income_percent DESC;


-- select author, title, min(price)
--         from book
--         GROUP BY author;

-- решения с сайта
