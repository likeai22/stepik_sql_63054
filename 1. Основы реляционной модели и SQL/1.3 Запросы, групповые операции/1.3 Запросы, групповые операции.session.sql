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

INSERT INTO book (title, author, price, amount) VALUES
('Мастер и Маргарита', 'Булгаков М.А.', 670.99, 3),
('Белая гвардия', 'Булгаков М.А.', 540.50, 5),
('Идиот', 'Достоевский Ф.М.', 460.00, 10),
('Братья Карамазовы', 'Достоевский Ф.М.', 799.01, 3),
('Игрок', 'Достоевский Ф.М.', 480.50, 10),
('Стихотворения и поэмы', 'Есенин С.А.', 650.00, 15);


-- Запросы к таблице book

-- 1. Отобрать различные (уникальные) элементы столбца amount таблицы book.
SELECT DISTINCT amount FROM book;

-- 2. Выборка данных, групповые функции SUM и COUNT


