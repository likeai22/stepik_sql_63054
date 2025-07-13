INSERT INTO book (title, author, price, amount)
select title, author, price, amount
FROM supply
where author not in ('Булгаков М.А.', 'Достоевский Ф.М.');


select * from book;

-- примеры с сайта:
INSERT INTO book (title, author, price, amount)
    SELECT title, author, price, amount
    FROM supply
    WHERE author NOT LIKE '%Булгаков%' AND author NOT LIKE '%Достоевск%';

INSERT INTO book (title, author, price, amount) 
       SELECT title, author, price, amount 
       FROM supply
       where title <> ALL (SELECT title FROM book);

INSERT INTO book (title, author, price, amount)
            SELECT title, author, price, amount
            FROM supply
            WHERE author NOT REGEXP '.*(Булгаков|Достоевский).*';

INSERT INTO book (title, author, price, amount) 
       SELECT title, author, price, amount 
       FROM supply
       WHERE title NOT IN (SELECT title FROM book);

insert into book (title, author, price, amount) 
select title, author, price, amount from supply
where author NOT LIKE "Булгаков%" and author NOT LIKE "Достоевск%";
