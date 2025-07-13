insert INTO book (title, author_id, genre_id, price, amount)
values ("Герой нашего времени", 5, 3, 570.59, 2),
    ("Доктор Живаго", 4, 3, 740.50, 5);


-- неправильно(но работает)
select title, name_author, name_genre, price, amount
from author 
JOIN book USING(author_id)
JOIN genre USING(genre_id)
GROUP BY title, name_author, price, genre_id
HAVING genre_id IN
         (
          SELECT query_in_1.genre_id
          FROM 
              (
                SELECT genre_id, SUM(amount) AS sum_amount
                FROM book
                GROUP BY genre_id
               )query_in_1
          JOIN 
              ( /*результат 31*/
                SELECT genre_id, SUM(amount) AS sum_amount
                FROM book
                GROUP BY genre_id
                ORDER BY sum_amount DESC
                LIMIT 1
               ) query_in_2
          USING(sum_amount)
         )
ORDER BY title;


-- неправильно(но работает) улучшил
select title, name_author, name_genre, price, amount
from author 
JOIN book USING(author_id)
JOIN genre USING(genre_id)
WHERE genre_id IN
         (
          SELECT query_in_1.genre_id
          FROM 
              (
                SELECT genre_id, SUM(amount) AS sum_amount
                FROM book
                GROUP BY genre_id
               )query_in_1
          JOIN 
              (
                SELECT genre_id, SUM(amount) AS sum_amount
                FROM book
                GROUP BY genre_id
                ORDER BY sum_amount DESC
                LIMIT 1
               ) query_in_2
          USING(sum_amount)
         )
ORDER BY title;



-- разбор
select title, name_author, name_genre, price, amount
from author 
JOIN book USING(author_id)
JOIN genre USING(genre_id)
-- GROUP BY title, name_author, price, name_genre
WHERE genre_id IN (1, 2)
ORDER BY title;

-- решение вроде верно (списано)
select title,
    name_author,
    name_genre,
    price,
    amount
from author
    JOIN book USING(author_id)
    JOIN genre USING(genre_id)
WHERE name_genre IN (
    SELECT name_genre
    FROM (
        SELECT name_genre,
            SUM(amount) AS amount
        FROM genre
            JOIN book USING(genre_id)
        GROUP BY name_genre
        HAVING SUM(amount) = (
            SELECT max_amount
            FROM (
                    SELECT genre_id,
                        SUM(amount) AS max_amount
                    FROM book
                    GROUP BY genre_id
                    ORDER BY SUM(amount) DESC
                    LIMIT 1
                ) AS amount
            )
    )rightgenre
)
ORDER BY title;


-- ***********************************
-- экспер
-- количество
SELECT max_amount
FROM (
        SELECT genre_id,
            SUM(amount) AS max_amount
        FROM book
        GROUP BY genre_id
        ORDER BY SUM(amount) DESC
        LIMIT 1
    ) AS amount


-- "Роман", "Поэзия"
SELECT name_genre
FROM (
        SELECT name_genre,
            SUM(amount) AS amount
        FROM genre
            JOIN book USING(genre_id)
        GROUP BY name_genre
        HAVING SUM(amount) = 31
    ) rightgenre

-- итог
select title,
    name_author,
    name_genre,
    price,
    amount
from author
    JOIN book USING(author_id)
    JOIN genre USING(genre_id)
WHERE name_genre IN ("Роман", "Поэзия")

-- *****************************



SELECT genre_id, SUM(amount) AS sum_amount
FROM book
GROUP BY genre_id
ORDER BY sum_amount DESC
LIMIT 1;

SELECT query_in_1.genre_id
FROM 
    (/* выбираем код жанра и количество произведений, относящихся к нему */
      SELECT genre_id, SUM(amount) AS sum_amount
      FROM book
      GROUP BY genre_id 
    )query_in_1
    INNER JOIN
    (/* выбираем запись, в которой указан код жанр с максимальным количеством книг */
      SELECT genre_id, SUM(amount) AS sum_amount
      FROM book
      GROUP BY genre_id
      ORDER BY sum_amount DESC
      LIMIT 1
     ) query_in_2
     ON query_in_1.sum_amount= query_in_2.sum_amount      


SELECT  name_author, name_genre
FROM 
    author 
    INNER JOIN book ON author.author_id = book.author_id
    INNER JOIN genre ON  book.genre_id = genre.genre_id
GROUP BY name_author,name_genre, genre.genre_id
HAVING genre.genre_id IN
         (/* выбираем автора, если он пишет книги в самых популярных жанрах*/
          SELECT query_in_1.genre_id
          FROM 
              ( /* выбираем код жанра и количество произведений, относящихся к нему */
                SELECT genre_id, SUM(amount) AS sum_amount
                FROM book
                GROUP BY genre_id
               )query_in_1
          INNER JOIN 
              ( /* выбираем запись, в которой указан код жанр с максимальным количеством книг */
                SELECT genre_id, SUM(amount) AS sum_amount
                FROM book
                GROUP BY genre_id
                ORDER BY sum_amount DESC
                LIMIT 1
               ) query_in_2
          ON query_in_1.sum_amount= query_in_2.sum_amount
         ); 



SELECT title, name_author, name_genre, price, amount
FROM author
INNER JOIN book 
ON author.author_id = book.author_id
INNER JOIN genre 
ON book.genre_id = genre.genre_id
WHERE book.genre_id IN 
    (SELECT genre_id
     FROM book
     GROUP BY genre_id
     HAVING SUM(amount) >= ALL(SELECT SUM(amount) FROM book GROUP BY genre_id)
     )
ORDER BY title;

-- оконные функции подъехали с WITH
with n as (select *, sum(amount) over(partition by genre_id) as summ
from book
)
select title, a.name_author, g.name_genre, price, amount
from n 
    inner join genre as g on n.genre_id = g.genre_id
    inner join author as a on n.author_id = a.author_id
where summ = (select max(summ) from n)
order by title