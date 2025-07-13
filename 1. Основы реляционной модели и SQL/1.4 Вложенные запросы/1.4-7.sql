-- Придумайте один или несколько запросов к нашей таблице book, используя вложенные запросы. Проверьте, правильно ли они работают.

-- delete from book where book_id = 8;

SELECT author,
    title,
    price
FROM book
WHERE price < any (
        select min(price)
        from book
        GROUP BY author
    );

select author, title, min(price)
        from book
        GROUP BY author;

-- решения с сайта
