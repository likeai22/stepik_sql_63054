SELECT title, name_genre, price
FROM book INNER JOIN genre
ON book.genre_id = genre.genre_id
WHERE amount > 8
ORDER BY price DESC;