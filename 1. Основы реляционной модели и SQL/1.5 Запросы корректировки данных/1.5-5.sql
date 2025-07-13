-- Занести из таблицы supply в таблицу book только те книги, авторов которых нет в  book.

INSERT INTO book (title, author, price, amount)
select title, author, price, amount
FROM supply
where author not in (SELECT author FROM book);


select * from book;

-- примеры с сайта:

INSERT INTO book (title, author, price, amount)
SELECT title, author, price, amount 
FROM supply
WHERE author NOT IN (
	SELECT DISTINCT author
	FROM book
	);