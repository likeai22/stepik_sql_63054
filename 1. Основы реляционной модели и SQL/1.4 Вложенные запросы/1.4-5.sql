-- Вывести информацию (автора, книгу и количество) о тех книгах, количество экземпляров которых в таблице book не дублируется.

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
