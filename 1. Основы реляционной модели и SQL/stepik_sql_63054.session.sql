USE stepik_sql_63054;

-- Структура и наполнение таблицы
DROP TABLE IF EXISTS book;
CREATE TABLE book (
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(50),
    author VARCHAR(30),
    price DECIMAL(8,2),
    amount INT
);

DROP TABLE IF EXISTS supply;
CREATE table supply(
    supply_id int primary key auto_increment,
    title	VARCHAR(50),
    author	VARCHAR(30),
    price	DECIMAL(8, 2),
    amount	INT
);

-- INSERT INTO book (title, author, price, amount) VALUES
-- ('Мастер и Маргарита', 'Булгаков М.А.', 670.99, 3),
-- ('Белая гвардия', 'Булгаков М.А.', 540.50, 5),
-- ('Идиот', 'Достоевский Ф.М.', 460.00, 10),
-- ('Братья Карамазовы', 'Достоевский Ф.М.', 799.01, 3),
-- ('Игрок', 'Достоевский Ф.М.', 480.50, 10),
-- ('Стихотворения и поэмы', 'Есенин С.А.', 650.00, 15);


INSERT INTO book (title, author, price, amount) VALUES
('Мастер и Маргарита', 'Булгаков М.А.', 670.99, 3),
('Белая гвардия', 'Булгаков М.А.', 540.50, 5),
('Идиот', 'Достоевский Ф.М.', 460.00, 10),
('Братья Карамазовы', 'Достоевский Ф.М.', 799.01, 2),
('Стихотворения и поэмы', 'Есенин С.А.', 650.00, 15);

insert into supply (supply_id, title, author, price, amount)
values (1, 'Лирика', 'Пастернак Б.Л.', 518.99, 2),
    (2, 'Черный человек', 'Есенин С.А.', 570.20, 6),
    (3, 'Белая гвардия', 'Булгаков М.А.', 540.50, 7),
    (4, 'Идиот', 'Достоевский Ф.М.', 360.80, 3);