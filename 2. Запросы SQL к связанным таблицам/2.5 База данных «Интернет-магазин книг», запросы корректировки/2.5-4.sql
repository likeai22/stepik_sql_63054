INSERT INTO buy_book (buy_id, book_id, amount) 
SELECT 5, (SELECT book_id FROM book WHERE title='Лирика'), 2
UNION
SELECT 5, (SELECT book_id FROM book WHERE title='Белая гвардия'), 1;

-- stepik
