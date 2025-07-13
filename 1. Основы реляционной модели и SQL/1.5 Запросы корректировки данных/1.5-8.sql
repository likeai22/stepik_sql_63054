-- Для тех книг в таблице book , которые есть в таблице supply, не только увеличить их количество в таблице book ( увеличить их количество на значение столбца amountтаблицы supply), но и пересчитать их цену (для каждой книги найти сумму цен из таблиц book и supply и разделить на 2).


-- UPDATE book
-- JOIN supply ON book.title = supply.title AND book.author = supply.author
-- SET 
--     book.amount = book.amount + supply.amount,
--     book.price = (book.price + supply.price) / 2;

update book, supply
set book.amount = book.amount + supply.amount,
    book.price = (book.price + supply.price) / 2
where book.title = supply.title
    and book.author = supply.author


-- с сайта stepik.org
-- UPDATE book, supply 
-- SET book.amount = book.amount + supply.amount, 
--     book.price = (book.price + supply.price)/2
-- WHERE book.title = supply.title and book.author = supply.author;

-- SELECT * FROM book;

-- UPDATE book
-- set amount = amount + (
--         select sum(amount)
--         from supply
--         where supply.title = book.title
--             and supply.author = book.author
--     ),
--     price = (
--         price + (
--             select avg(price)
--             from supply
--             where supply.title = book.title
--                 and supply.author = book.author
--         )
--     ) / 2
-- where exists (
--         select 1
--         from supply
--         where supply.title = book.title
--             and supply.author = book.author
--     );