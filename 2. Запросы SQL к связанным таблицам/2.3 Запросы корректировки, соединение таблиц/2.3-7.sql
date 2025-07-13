DELETE FROM genre g
WHERE (
        SELECT COUNT(b.genre_id)
        FROM book b
        WHERE g.genre_id = b.genre_id
    ) < 4;
SELECT *
FROM genre;


SELECT g.name_genre, COUNT(g.genre_id) Количество FROM genre g
JOIN book b USING(genre_id)
GROUP BY genre_id
HAVING Количество < 4;


DELETE FROM genre
WHERE name_genre LIKE "%я";