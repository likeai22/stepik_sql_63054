SELECT a.name_author, bk.title, COUNT(bb.amount) AS Количество
FROM 
    author a
    JOIN book bk USING(author_id)
    LEFT JOIN buy_book bb USING(book_id)
GROUP BY a.name_author, bk.title
ORDER BY a.name_author, bk.title; 


-- с сайта
