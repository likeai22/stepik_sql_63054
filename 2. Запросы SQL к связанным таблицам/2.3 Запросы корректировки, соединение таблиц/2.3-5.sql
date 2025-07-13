-- SELECT genre_id
-- FROM genre
-- WHERE name_genre in ('Роман', 'Поэзия', 'Приключения');
-- -- 1 2 3

UPDATE book
SET genre_id = (
        SELECT g.genre_id
        FROM genre g
        WHERE g.name_genre = 'Поэзия'
    )
WHERE title = 'Стихотворения и поэмы'
    AND genre_id is NULL;
UPDATE book
SET genre_id = (
        SELECT g.genre_id
        FROM genre g
        WHERE g.name_genre = 'Приключения'
    )
WHERE title = 'Остров сокровищ'
    AND genre_id is NULL;


-- 2
UPDATE book
JOIN genre ON (
    (book.title = 'Стихотворения и поэмы' AND genre.name_genre = 'Поэзия') OR
    (book.title = 'Остров сокровищ' AND genre.name_genre = 'Приключения')
)
SET book.genre_id = genre.genre_id
WHERE book.genre_id IS NULL;


select * from book;


-- 3
update book 
set genre_id = if (book.title = 'Остров сокровищ', 3, if (book.title = 'Стихотворения и поэмы', 2, null))
where genre_id is null;
select * from book;
