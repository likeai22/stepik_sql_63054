SELECT b.title, name_author, b.price, s.price
FROM book b 
JOIN author a USING(author_id)
JOIN supply s ON b.title = s.title AND a.name_author = s.author
WHERE b.price <> s.price;

-- решение
UPDATE book b
    JOIN author a USING(author_id)
    JOIN supply s ON b.title = s.title
    AND a.name_author = s.author
SET b.price = (b.price * b.amount + s.price * s.amount) / (b.amount + s.amount),
    b.amount = b.amount + s.amount,
    s.amount = 0
WHERE b.price <> s.price;
