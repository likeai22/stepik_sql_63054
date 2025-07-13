SELECT author_id,
    SUM(amount) AS sum_amount
FROM book
GROUP BY author_id
ORDER BY sum_amount DESC
LIMIT 1;


SELECT name_author, MAX(sum_amount) AS max_sum_amount
FROM (
        SELECT author_id,
            SUM(amount) AS sum_amount
        FROM book
        GROUP BY author_id
    ) query_in;


SELECT name_author,
    SUM(amount) as Количество
FROM author
    INNER JOIN book on author.author_id = book.author_id
GROUP BY name_author
HAVING SUM(amount) = (
        /* вычисляем максимальное из общего количества книг каждого автора */
        SELECT MAX(sum_amount) AS max_sum_amount
        FROM (
                /* считаем количество книг каждого автора */
                SELECT author_id,
                    SUM(amount) AS sum_amount
                FROM book
                GROUP BY author_id
            ) query_in
    );

SELECT name_author, author_id,
    SUM(amount) AS sum_amount
FROM 
    author LEFT JOIN book USING(author_id)
GROUP BY author_id
ORDER BY sum_amount DESC
LIMIT 1;


select name_author, name_genre
from author
LEFT JOIN book USING(author_id)
LEFT JOIN genre USING(genre_id)
GROUP BY name_author, name_genre
HAVING COUNT(name_genre) = 1
ORDER BY name_author


-- решение
select name_author
from author
    JOIN book USING(author_id)
    JOIN genre USING(genre_id)
GROUP BY name_author
HAVING COUNT(DISTINCT(name_genre)) = 1 

select name_author
from author
    JOIN book USING(author_id)
GROUP BY name_author
HAVING COUNT(DISTINCT(genre_id)) = 1 


