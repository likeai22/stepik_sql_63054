DELETE FROM author a
WHERE (
        SELECT SUM(b.amount)
        FROM book b
        WHERE a.author_id = b.author_id
    ) < 20;
SELECT *
FROM author;


SELECT author_id, SUM(b.amount) Количество FROM author
JOIN book b USING(author_id)
GROUP BY author_id
HAVING Количество < 20;