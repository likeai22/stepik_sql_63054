SELECT name_genre, SUM(bb.amount) AS Количество
FROM genre
    JOIN book USING(genre_id) 
    JOIN buy_book bb USING(book_id)
GROUP BY name_genre
HAVING SUM(bb.amount) = (
    SELECT MAX(total)
    FROM (
        SELECT SUM(bb.amount) AS total
        FROM buy_book bb
        JOIN book USING(book_id)
        GROUP BY genre_id
    ) AS subquery
);


"Можно задать нумерацию для количества заказанных экземпляров книг.
Найти все самые популярные и присвоить им номер 1 (по убыванию суммы), что позволит быстрее найти все требующиеся genre_id.

DENSE_RANK ( ) OVER ( [ <partition_by_clause> ] < order_by_clause > )
Эта функция возвращает ранг каждой строки в секции результирующего набора без промежутков в значениях ранжирования. Ранг определенной строки равен количеству различных значений рангов, предшествующих строке, увеличенному на единицу. (Описание функции взято с https://learn.microsoft.com/ru-ru/sql/t-sql/functions/dense-rank-transact-sql?view=sql-server-ver16)
"
SELECT name_genre, Количество
FROM (
    SELECT 
        name_genre, 
        SUM(bb.amount) AS Количество,
        RANK() OVER (ORDER BY SUM(bb.amount) DESC) AS `rank`
    FROM genre
    JOIN book USING(genre_id) 
    JOIN buy_book bb USING(book_id)
    GROUP BY name_genre
) AS ranked
WHERE `rank` = 1;

-- с сайта
-- С точки зрения оптимизации запроса, решение через WITH будет оптимальней, чем через вложенный запрос. Просто и компактно решается через обобщеное табличное представление
WITH qq AS (SELECT name_genre, sum(bb.amount) AS Количество
                FROM genre g
                         JOIN book b
                         USING (genre_id)
                         JOIN buy_book bb
                         USING (book_id)
               GROUP BY name_genre)
SELECT name_genre, Количество
  FROM qq
HAVING количество = (SELECT max(Количество) FROM qq);

-- ALL
SELECT name_genre, SUM(bb.amount) AS Количество 
FROM book 
    JOIN genre USING (genre_id)
    JOIN buy_book bb USING (book_id)
GROUP BY name_genre
HAVING Количество >= ALL 
    (SELECT SUM(bb.amount) AS sum_amount
     FROM book JOIN buy_book bb USING (book_id)
     GROUP BY genre_id);
