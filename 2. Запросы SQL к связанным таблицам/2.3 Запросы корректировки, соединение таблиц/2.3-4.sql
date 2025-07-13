INSERT INTO book (title, author_id, price, amount)
SELECT s.title,
    a.author_id,
    s.price,
    s.amount
FROM supply s
    INNER JOIN author a ON s.author = a.name_author
    LEFT JOIN book b ON b.author_id = a.author_id AND b.title = s.title
WHERE s.amount <> 0;

-- SELECT title, author_id, price, amount
-- FROM 
--     author 
--     INNER JOIN supply ON author.name_author = supply.author
-- WHERE amount <> 0;