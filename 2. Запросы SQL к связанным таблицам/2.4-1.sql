DROP DATABASE IF EXISTS stepik_bookshop_63054;
CREATE DATABASE stepik_bookshop_63054;
USE stepik_bookshop_63054;

-- DROP TABLE IF EXISTS
-- genre,
-- author,
-- city,
-- book,
-- client,
-- buy,
-- step,
-- buy_book,
-- buy_step,
-- buy_archive;

CREATE TABLE author (
    author_id INT PRIMARY KEY AUTO_INCREMENT,
    name_author VARCHAR(50)
);

CREATE TABLE genre (
    genre_id INT PRIMARY KEY AUTO_INCREMENT,
    name_genre varchar(30)
);

CREATE TABLE city (
    city_id INT PRIMARY KEY AUTO_INCREMENT,
    name_city VARCHAR(30),
    days_delivery INT
);

CREATE TABLE book (
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(50),
    author_id INT NOT NULL,
    genre_id INT,
    price DECIMAL(8, 2),
    amount INT
);

CREATE TABLE client(
    client_id INT PRIMARY KEY AUTO_INCREMENT,
    name_client VARCHAR(50),
    city_id INT,
    email VARCHAR(30)
);

CREATE TABLE buy(
    buy_id INT PRIMARY KEY AUTO_INCREMENT,
    buy_description VARCHAR(100),
    client_id INT
);

CREATE table step(
    step_id INT PRIMARY KEY AUTO_INCREMENT,
    name_step VARCHAR(30)
);

CREATE TABLE buy_book(
    buy_book_id INT PRIMARY KEY AUTO_INCREMENT,
    buy_id INT,
    book_id INT,
    amount INT
);

CREATE TABLE buy_step(
    buy_step_id INT PRIMARY KEY AUTO_INCREMENT,
    buy_id INT,
    step_id INT,
    date_step_beg DATE,
    date_step_end DATE
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
    ('Белая гвардия', 1, 1, 540.50, 5),
    ('Идиот', 2, 1, 460.00, 10),
    ('Братья Карамазовы', 2, 1, 799.01, 3),
    ('Игрок', 2, 1, 480.50, 10),
    ('Стихотворения и поэмы', 3, 2, 650.00, 15),
    ('Черный человек', 3, 2, 570.20, 6),
    ('Лирика', 4, 2, 518.99, 2);

INSERT INTO city (name_city, days_delivery)
VALUES ("Москва", 5),
    ("Санкт-Петербург", 3),
    ("Владивосток", 12);

INSERT INTO client(name_client, city_id, email)
VALUES ('Баранов Павел', 3, 'baranov@test'),
    ('Абрамова Катя', 1, 'abramova@test'),
    ('Семенонов Иван', 2, 'semenov@test'),
    ('Яковлева Галина', 1, 'yakovleva@test');

INSERT INTO buy(buy_description, client_id)
VALUES ('Доставка только вечером', 1),
    (NULL, 3),
    ('Упаковать каждую книгу по отдельности', 2),
    (NULL, 1);

INSERT INTO buy_book (buy_id, book_id, amount)
VALUES (1, 1, 1),
    (1, 7, 2),
    (1, 3, 1),
    (2, 8, 2),
    (3, 3, 2),
    (3, 2, 1),
    (3, 1, 1),
    (4, 5, 1);

INSERT INTO step (name_step)
VALUES ('Оплата'),
('Упаковка'),
    ('Транспортировка'),
    ('Доставка');

INSERT INTO buy_step (buy_id, step_id, date_step_beg, date_step_end)
VALUES (1, 1, '2020-02-20', '2020-02-20'),
    (1, 2, '2020-02-20', '2020-02-21'),
    (1, 3, '2020-02-22', '2020-03-07'),
    (1, 4, '2020-03-08', '2020-03-08'),
    (2, 1, '2020-02-28', '2020-02-28'),
    (2, 2, '2020-02-29', '2020-03-01'),
    (2, 3, '2020-03-02', NULL),
    (2, 4, NULL, NULL),
    (3, 1, '2020-03-05', '2020-03-05'),
    (3, 2, '2020-03-05', '2020-03-06'),
    (3, 3, '2020-03-06', '2020-03-10'),
    (3, 4, '2020-03-11', NULL),
    (4, 1, '2020-03-20', NULL),
    (4, 2, NULL, NULL),
    (4, 3, NULL, NULL),
    (4, 4, NULL, NULL);

ALTER TABLE book
    ADD FOREIGN KEY (author_id) REFERENCES author(author_id) ON DELETE CASCADE,
    ADD FOREIGN KEY (genre_id)  REFERENCES genre(genre_id)   ON DELETE CASCADE;

ALTER TABLE client ADD FOREIGN KEY (city_id)  REFERENCES city(city_id) ON DELETE CASCADE;

ALTER TABLE buy_book 
    ADD FOREIGN KEY (book_id) REFERENCES book(book_id) ON DELETE CASCADE,
    ADD FOREIGN KEY (buy_id)  REFERENCES buy(buy_id)   ON DELETE CASCADE;

ALTER TABLE buy ADD FOREIGN KEY (client_id) REFERENCES client(client_id) ON DELETE CASCADE;

ALTER TABLE buy_step
    ADD FOREIGN KEY (buy_id)  REFERENCES buy(buy_id) ON DELETE CASCADE,
    ADD FOREIGN KEY (step_id) REFERENCES step(step_id) ON DELETE CASCADE;


CREATE TABLE buy_archive (
    buy_archive_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    buy_id INT,
    client_id INT,
    book_id INT,
    date_payment DATE,
    price DECIMAL(8,2),
    amount INT,
    FOREIGN KEY (client_id) REFERENCES client(client_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id)
);

INSERT INTO buy_archive (buy_id, client_id, book_id, date_payment, price, amount)
VALUES
    (2, 1, 1, '2019-02-21', 670.60, 2),
    (2, 1, 3, '2019-02-21', 450.90, 1),
    (1, 2, 2, '2019-02-10', 520.30, 2),
    (1, 2, 4, '2019-02-10', 780.90, 3),
    (1, 2, 3, '2019-02-10', 450.90, 1),
    (3, 4, 4, '2019-03-05', 780.90, 4),
    (3, 4, 5, '2019-03-05', 480.90, 2),
    (4, 1, 6, '2019-03-12', 650.00, 1),
    (5, 2, 1, '2019-03-18', 670.60, 2),
    (5, 2, 4, '2019-03-18', 780.90, 1);

"
SHOW COLUMNS FROM book;
DESCRIBE table_name;

SHOW TABLES;
"