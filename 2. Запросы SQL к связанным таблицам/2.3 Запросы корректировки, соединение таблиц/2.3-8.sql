DELETE FROM book
USING genre
JOIN author
INNER JOIN book ON author.author_id = book.author_id AND genre.genre_id = book.genre_id
WHERE genre.name_genre = "Поэзия";

-- решение
DELETE FROM author
USING 
    author 
    INNER JOIN book ON author.author_id = book.author_id
    INNER JOIN genre ON book.genre_id = genre.genre_id
WHERE genre.name_genre = "Поэзия";

SELECT * FROM author;
SELECT * FROM book;