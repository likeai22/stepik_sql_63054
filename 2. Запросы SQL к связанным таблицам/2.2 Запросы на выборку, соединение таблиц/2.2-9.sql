-- TRUNCATE TABLE supply;

-- insert INTO supply (title, author, price, amount)
-- VALUES 
-- ('Доктор Живаго', 'Пастернак Б.Л.', 618.99, 3),
-- ('Черный человек', 'Есенин С.А.', 570.20, 6),
-- ('Евгений Онегин', 'Пушкин А.С.', 440.8, 5),
-- ('Идиот', 'Достоевский Ф.М.', 360.8, 3);

-- решение
SELECT b.title Название, s.author Автор, (b.amount + s.amount) Количество
FROM book b
INNER JOIN author a USING(author_id)
INNER JOIN supply s ON a.name_author = s.author AND b.title = s.title
WHERE s.price = b.price

-- или
SELECT b.title Название, s.author Автор, (b.amount + s.amount) Количество
FROM book b
INNER JOIN author a USING(author_id)
INNER JOIN supply s ON a.name_author = s.author && b.title = s.title && b.price = s.price


-- примеры
select book.title as Название, name_author as Автор, book.amount + supply.amount as Количество
from book
    inner join author using(author_id)
    inner join supply 
    on (book.title, author.name_author, book.price) = (supply.title, supply.author, supply.price)

select title as Название, name_author as Автор, book.amount + supply.amount as Количество
from book
inner join supply
using (title, price)
inner join author
using (author_id);


