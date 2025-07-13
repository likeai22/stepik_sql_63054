-- Удалить из таблицы supply книги тех авторов, общее количество экземпляров книг которых в таблице book превышает 10.

-- SELECT * FROM supply;
-- SELECT * FROM book;

DELETE FROM supply
WHERE author in (
    SELECT author from book
    group by author
    having sum(amount) > 10
);


DELETE FROM supply
WHERE (SELECT SUM(amount) 
       FROM book WHERE 
       book.author = supply.author) > 10


DELETE FROM supply
WHERE (
    SELECT SUM(amount)
    FROM book
    GROUP BY author
    HAVING supply.author=book.author
) > 10;