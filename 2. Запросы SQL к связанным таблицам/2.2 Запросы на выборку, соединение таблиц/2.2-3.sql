SELECT name_genre 
FROM genre LEFT JOIN book
     ON genre.genre_id = book.genre_id
WHERE book.title is NULL;

-- комментарии
SELECT DISTINCT name_genre 
FROM genre LEFT JOIN book
     on genre.genre_id = book.genre_id
WHERE title is NUll;


--#1 JOIN ON
--SELECT name_genre
--FROM genre LEFT JOIN book ON genre.genre_id = book.genre_id
--WHERE title IS NULL

--#2 JOIN USING
SELECT name_genre
FROM genre LEFT JOIN book USING(genre_id)
WHERE title IS NULL

--#3 EXISTS
--SELECT g.name_genre
--  FROM genre g
-- WHERE NOT EXISTS(SELECT * FROM book b WHERE b.genre_id = g.genre_id)
 

select name_genre
from genre
where genre.genre_id not in (select distinct genre_id as id from book);