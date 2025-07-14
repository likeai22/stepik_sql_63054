DROP TABLE IF EXISTS book,
genre,
supply,
author;

CREATE TABLE author
(
    author_id INT PRIMARY KEY AUTO_INCREMENT,
    name_author VARCHAR(50)
);

CREATE table supply(
    supply_id int primary key auto_increment,
    title	VARCHAR(50),
    author	VARCHAR(30),
    price	DECIMAL(8, 2),
    amount	INT
);

CREATE TABLE genre
(
    genre_id   INT PRIMARY KEY AUTO_INCREMENT,
    name_genre varchar(30)
);

CREATE TABLE book
(
    book_id   INT PRIMARY KEY AUTO_INCREMENT,
    title     VARCHAR(50),
    author_id INT NOT NULL,
    genre_id  INT,
    price     DECIMAL(8, 2),
    amount    INT,
    FOREIGN KEY (author_id) REFERENCES author (author_id) ON DELETE CASCADE,
    FOREIGN KEY (genre_id) REFERENCES genre (genre_id) ON DELETE SET NULL
);

INSERT INTO author (name_author)
VALUES ('Булгаков М.А.'),
       ('Достоевский Ф.М.'),
       ('Есенин С.А.'),
       ('Пастернак Б.Л.'),
       ('Лермонтов М.Ю.');


INSERT INTO genre (name_genre)
VALUES ('Роман'),
       ('Поэзия'),
       ('Приключения');

INSERT INTO book (title, author_id, genre_id, price, amount)
VALUES ('Мастер и Маргарита', 1, 1, 670.99, 3),
       ('Белая гвардия ', 1, 1, 540.50, 5),
       ('Идиот', 2, 1, 460.00, 10),
       ('Братья Карамазовы', 2, 1, 799.01, 2),
       ('Игрок', 2, 1, 480.50, 10),
       ('Стихотворения и поэмы', 3, 2, 650.00, 15),
       ('Черный человек', 3, 2, 570.20, 6),
       ('Лирика', 4, 2, 518.99, 2),
       ('Стихотворения и поэмы', 5, 2, 255.90, 4);

INSERT INTO supply (title, author, price, amount)
VALUES ('Доктор Живаго', 'Пастернак Б.Л.', 618.99, 3),
       ('Черный человек', 'Есенин С.А.', 570.20, 6),
    --    ('Евгений Онегин', 'Пушкин А.С.', 440.8, 5),
       ('Идиот', 'Достоевский Ф.М.', 360.8, 3),
       ('Стихотворения и поэмы', 'Лермонтов М.Ю.', 255.9, 4),
       ('Остров сокровищ', 'Стивенсон Р.Л.', 599.99, 5);


INSERT INTO author (name_author) 
    SELECT s.author
    FROM supply s
    LEFT JOIN author a ON s.author = a.name_author
    WHERE a.name_author IS NULL;


INSERT INTO book (title, author_id, price, amount)
SELECT s.title,
    a.author_id,
    s.price,
    s.amount
FROM supply s
    INNER JOIN author a ON s.author = a.name_author
    LEFT JOIN book b ON b.author_id = a.author_id AND b.title = s.title
WHERE s.title NOT IN (SELECT title FROM book);

UPDATE book
JOIN genre ON (
    (book.title = 'Евгений Онегин' AND genre.name_genre = 'Поэзия') OR
    (book.title = 'Остров сокровищ' AND genre.name_genre = 'Приключения') OR
    (book.title = 'Доктор Живаго' AND genre.name_genre = 'Роман')
)
SET book.genre_id = genre.genre_id
WHERE book.genre_id IS NULL;


-- Можно посмотреть какие строки получаются при создании таблицы: 
SHOW COLUMNS FROM book;
SHOW TABLES;
