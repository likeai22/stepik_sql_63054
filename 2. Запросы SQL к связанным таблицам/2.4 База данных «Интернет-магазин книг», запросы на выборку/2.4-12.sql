SELECT DISTINCT name_client
FROM client
    JOIN buy USING(client_id)
    JOIN buy_book USING(buy_id)
    JOIN book USING(book_id) 
    JOIN author ON author.author_id = book.author_id AND author.name_author LIKE 'Достоевский%'
ORDER BY name_client;



-- с сайта
-- А я еще подзапросы решил качнуть
SELECT DISTINCT name_client
FROM client
WHERE client_id IN (
        SELECT client_id
        FROM buy
        WHERE buy_id IN (
                SELECT buy_id
                FROM buy_book
                WHERE book_id IN (
                        SELECT book_id
                        FROM book
                        WHERE author_id IN (
                                SELECT author_id
                                FROM author
                                WHERE name_author LIKE 'Достоевский%'
                            )
                    )
            )
    )
ORDER BY name_client