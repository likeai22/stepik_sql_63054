-- Вывести информацию (автора, книгу и количество) о тех книгах, количество экземпляров которых в таблице book не дублируется.

-- delete from book where book_id = 8;

SELECT author,
    title,
    amount
FROM book
WHERE amount not in (
        select amount
        from book
        GROUP BY amount
        HAVING count(amount) > 1
    );


-- решения с сайта
