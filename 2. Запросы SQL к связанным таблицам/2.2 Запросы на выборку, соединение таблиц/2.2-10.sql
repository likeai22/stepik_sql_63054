-- SELECT name_author, name_genre, COUNT(book.title) Количество
-- from genre    
--     JOIN author
--     LEFT JOIN book USING(author_id, genre_id)
-- GROUP BY name_author, name_genre;


SELECT name_author, name_genre, COUNT(book.title) Количество
from book
JOIN genre USING(genre_id)
LEFT JOIN author USING(author_id)
GROUP BY name_author, name_genre;

SELECT name_author, name_genre, COUNT(book.title) AS Количество
FROM book
JOIN genre USING(genre_id)
JOIN author USING(author_id)
GROUP BY name_author, name_genre
UNION
SELECT author.name_author, genre.name_genre, 0 AS Количество
FROM author
CROSS JOIN genre
LEFT JOIN book USING(author_id, genre_id)
WHERE book.title IS NULL
ORDER BY name_author, name_genre;

SELECT 
    a.name_author, 
    g.name_genre, 
    COUNT(b.title) OVER (PARTITION BY a.name_author, g.name_genre) AS Количество
FROM author a
CROSS JOIN genre g
LEFT JOIN book b ON b.author_id = a.author_id AND b.genre_id = g.genre_id
ORDER BY a.name_author, g.name_genre;

SELECT 
    name_author,
    name_genre,
    COUNT(book.title) AS Количество,
    DENSE_RANK() OVER (PARTITION BY name_genre ORDER BY COUNT(book.title) DESC) AS `rank`
FROM book
JOIN author USING(author_id)
JOIN genre USING(genre_id)
GROUP BY name_genre, name_author
ORDER BY name_genre, `rank`;


-- SELECT name_author, name_genre, COUNT(book.title) AS Количество
-- FROM author
-- CROSS JOIN genre
-- LEFT JOIN book USING(author_id, genre_id)
-- GROUP BY name_author, name_genre;

-- SELECT dense_rank() over w as `rank`,
--     title,
--     name_author,
--     name_genre,
--     price,
--     amount
-- from book
--     JOIN author USING(author_id)
--     JOIN genre USING(genre_id)
-- GROUP BY name_author
-- window w as (ORDER BY price ASC, amount ASC) 
-- -- ORDER BY `rank` DESC, price DESC, amount DESC;



-- SELECT dense_rank() over w as `rank`,
--     title,
--     price,
--     amount
-- from book
-- window w as (ORDER BY price DESC) 
-- ORDER BY `rank`, price;
