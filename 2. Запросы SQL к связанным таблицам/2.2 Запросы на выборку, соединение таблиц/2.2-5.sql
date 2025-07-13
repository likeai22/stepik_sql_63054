SELECT name_genre, title, name_author
FROM
    book 
    INNER JOIN genre ON genre.genre_id = book.genre_id    
    INNER JOIN  author ON author.author_id = book.author_id    
WHERE name_genre LIKE "%оман"
ORDER BY title;

SELECT name_genre, title, name_author
FROM
    book 
    LEFT JOIN genre ON genre.genre_id = book.genre_id    
    RIGHT JOIN  author ON author.author_id = book.author_id    
WHERE name_genre LIKE "%оман"
ORDER BY title;

-- примеры
SELECT name_genre,
       title,
       name_author
  FROM (SELECT *
          FROM genre
         WHERE name_genre = 'Роман') AS genre
       JOIN book USING(genre_id)
       JOIN author USING(author_id)
 ORDER BY title ASC;


