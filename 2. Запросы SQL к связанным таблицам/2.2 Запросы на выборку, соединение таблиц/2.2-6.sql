SELECT name_author, SUM(amount) Количество
FROM
    author 
LEFT JOIN book ON author.author_id = book.author_id
GROUP BY name_author
HAVING Количество < 10
ORDER BY Количество;


SELECT name_author, SUM(amount) Количество
FROM
    author 
LEFT JOIN book USING(author_id)
GROUP BY name_author
HAVING Количество < 10 OR COUNT(title) = 0
ORDER BY Количество;

SELECT name_author, SUM(amount) Количество
FROM
    author 
LEFT JOIN book USING(author_id)
GROUP BY name_author
HAVING COALESCE(Количество, 0) < 10
ORDER BY Количество;



