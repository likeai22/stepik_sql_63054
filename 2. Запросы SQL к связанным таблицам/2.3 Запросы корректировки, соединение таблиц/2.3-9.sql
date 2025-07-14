-- ALTER TABLE supply DROP COLUMN author_id;
ALTER TABLE supply ADD author_id INT;

UPDATE supply s
SET s.author_id = (SELECT a.author_id from author a WHERE a.name_author = s.author);

ALTER TABLE supply
ADD FOREIGN KEY (author_id) REFERENCES author(author_id) ON DELETE SET NULL;

ALTER TABLE supply DROP COLUMN author;

-- решения
CREATE TABLE flower(
    line_id INT PRIMARY KEY AUTO_INCREMENT,
    line VARCHAR(50)
);
    
INSERT INTO flower(line)
VALUES
("         .     ."),
("    ...  :``..':"),
("     : ````.'   :''::'"),
("   ..:..  :     .'' :"),
("``.    `:    .'     :"),
("    :    :   :        :"),
("     :   :   :         :"),
("     :    :   :        :"),
("      :    :   :..''''``::."),
("       : ...:..'     .''"),
("       .'   .'  .::::'"),
("      :..'''``:::::::"),
("      '         `::::"),
("                  `::."),
("                   `::"),
("                    :::."),
("         ..:.:.::'`. ::'`.  . : : ."),
("       ..'      `:.: ::   :'       .:"),
("      .:        .:``:::  :       .: ::"),
("      .:    ..''     :::.'    :':    :"),
("       : .''         .:: : : '"),
("        :          .'`::"),
("                      ::"),
("                      ::"),
("                      ::"),
("                      ::"),
("                      ::"),
("                      ::");


SELECT line FROM flower;


# Задание
/* Читатели потеряли интерес к тем книгам, которые представлены в магазине 
Маркетологи прогнозируют, что в ближайшее время интерес к ним не возникнет. 
Поэтому решено: 
A) все книги из магазина переместить в склад; 
B) увеличить кол-во экземпляров на складе для книг с одинаковым автором, названием и ценой (считаем, что это одно издание); 
C) сделать новые записи на складе для книг с динаковым автором, названием, но разной ценой; аналогично для книг, которых нет на складе; 
D) переместить из склада в магазин те книги, которые там не были представлены.

Попутно выяснилось, что таблицы склада и магазина немного не согласованы. Потребуется предварительная подготовка.
*/
# Пошаговое выполнение задачи

# 0) Подготовка
## 0a) Сверить таблицы author и supply на предмет отсутствующих авторов в author;
SELECT "0a" AS "Сверить таблицы author и supply";
SELECT author FROM supply
LEFT JOIN author ON supply.author = author.name_author
WHERE author NOT IN(
    SELECT author FROM supply
    INNER JOIN author ON supply.author = author.name_author)
;
/*
+----------------+
| author         |
+----------------+
| Стивенсон Р.Л. |
+----------------+
*/
## 0b) Добавить в author недостающих авторов;
SELECT "0b" AS "Добавить в author недостающих авторов";
INSERT INTO author(name_author)
SELECT author FROM supply
LEFT JOIN author ON supply.author = author.name_author
 WHERE author NOT IN(
    SELECT author FROM supply
    INNER JOIN author ON supply.author = author.name_author)
;

SELECT * FROM author;
/*
Query result:
+-----------+------------------+
| author_id | name_author      |
+-----------+------------------+
| 1         | Булгаков М.А.    |
| 2         | Достоевский Ф.М. |
| 3         | Есенин С.А.      |
| 4         | Пастернак Б.Л.   |
| 5         | Лермонтов М.Ю.   |
| 6         | Стивенсон Р.Л.   |
+-----------+------------------+
*/

## 0c) Добавить в таблицу supply новое поле genre после поля author;
SELECT "0c" AS "Добавить в таблицу supply новое поле genre";
ALTER TABLE supply
ADD COLUMN genre VARCHAR(20) AFTER author;

DESCRIBE supply;
/*
Query result:
+-----------+--------------+------+-----+---------+----------------+
| Field     | Type         | Null | Key | Default | Extra          |
+-----------+--------------+------+-----+---------+----------------+
| supply_id | int(11)      | NO   | PRI | None    | auto_increment |
| title     | varchar(50)  | YES  |     | None    |                |
| author    | varchar(30)  | YES  |     | None    |                |
| genre     | varchar(20)  | YES  |     | None    |                |
| price     | decimal(8,2) | YES  |     | None    |                |
| amount    | int(11)      | YES  |     | None    |                |
+-----------+--------------+------+-----+---------+----------------+
*/

## 0d) Обновить поле genre в таблице supply 
SELECT "0d" AS "Обновить поле genre в таблице supply";
-- для совпадающих записей;

UPDATE supply, (
    SELECT title, name_author, name_genre
    FROM genre
    INNER JOIN book USING(genre_id)
    INNER JOIN author USING(author_id)
    ) qu
SET supply.genre = qu.name_genre
WHERE supply.title = qu.title
AND supply.author = qu.name_author
;

-- исходя из названия;
/*
В наличии записи без указания жанра, но в ряде случаев название жанра очевидно, 
например, книги со словами в названии "Стихотворения", "Поэмы" почти наверняка принадлежат жанру "Поэзия".
*/

SELECT title, author, genre 
FROM supply
WHERE genre IS Null;

UPDATE supply
SET genre = "Поэзия"
WHERE title LIKE "%тихотвор%_"
AND genre IS Null
;

-- для оставшихся книг после визуальной проверки.

UPDATE supply
SET genre = "Роман"
WHERE genre IS Null
AND author LIKE "Пастернак%"
;

UPDATE supply
SET genre = "Приключения"
WHERE genre IS Null
AND author LIKE "Стивенсон%"
;

SELECT title, author, genre FROM supply;
/*
+-----------------------+------------------+-------------+
| title                 | author           | genre       |
+-----------------------+------------------+-------------+
| Доктор Живаго         | Пастернак Б.Л.   | Роман       |
| Черный человек        | Есенин С.А.      | Поэзия      |
| Белая гвардия         | Булгаков М.А.    | Роман       |
| Идиот                 | Достоевский Ф.М. | Роман       |
| Стихотворения и поэмы | Лермонтов М.Ю.   | Поэзия      |
| Остров сокровищ       | Стивенсон Р.Л.   | Приключения |
+-----------------------+------------------+-------------+
*/

# 1) Выбрать книги, которые есть только на складе и не представлены в магазине;
## 1a) Cоздать временную таблицу supply_temp, занести туда книги, которые есть только на складе и не представлены в магазине (формат таблицы такой же как и таблица склада);

CREATE TABLE supply_temp(
    supply_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(50),
    author VARCHAR(50),
    genre VARCHAR(50),
    price INT,
    amount INT
);

## 1b) Смотрим, какие книги есть только на складе (supply) и не представлены в магазине (book);
SELECT "1b" AS "книги только на складе и не в магазине";

SELECT supply.title, supply.author, supply.genre, supply.price, supply.amount
FROM supply
LEFT JOIN book USING(title)
LEFT JOIN author ON book.author_id = author.author_id 
AND author.name_author = supply.author
WHERE supply.author NOT IN (
    SELECT author.name_author
    FROM author
    INNER JOIN book USING(author_id)
    INNER JOIN supply 
    ON book.title = supply.title AND author.name_author = supply.author)
AND supply.title NOT IN (
    SELECT book.title
    FROM book
    INNER JOIN author USING(author_id)
    INNER JOIN supply 
    ON book.title = supply.title AND author.name_author = supply.author);

/*
+-----------------------+----------------+-------------+--------+--------+
| title                 | author         | genre       | price  | amount |
+-----------------------+----------------+-------------+--------+--------+
| Стихотворения и поэмы | Лермонтов М.Ю. | Поэзия      | 255.90 | 4      |
| Доктор Живаго         | Пастернак Б.Л. | Роман       | 380.80 | 4      |
| Остров сокровищ       | Стивенсон Р.Л. | Приключения | 599.99 | 5      |
+-----------------------+----------------+-------------+--------+--------+
*/

## 1c) Записываем данные во временую таблицу supply_temp, используя предыдущий запрос;
SELECT "1c" AS "Записываем данные во временую таблицу supply_temp";

INSERT INTO supply_temp(title, author, genre, price, amount)
SELECT supply.title, supply.author, supply.genre, supply.price, supply.amount
FROM supply
LEFT JOIN book USING(title)
LEFT JOIN author ON book.author_id = author.author_id 
AND author.name_author = supply.author
WHERE supply.author NOT IN (
    SELECT author.name_author
    FROM author
    INNER JOIN book USING(author_id)
    INNER JOIN supply 
    ON book.title = supply.title AND author.name_author = supply.author)
AND supply.title NOT IN (
    SELECT book.title
    FROM book
    INNER JOIN author USING(author_id)
    INNER JOIN supply 
    ON book.title = supply.title AND author.name_author = supply.author);
    
-- Визуально проверяем содержимое временной таблицы с данными предыдущего запроса;
SELECT * FROM supply_temp;

/*
+-----------+-----------------------+----------------+-------------+-------+--------+
| supply_id | title                 | author         | genre       | price | amount |
+-----------+-----------------------+----------------+-------------+-------+--------+
| 1         | Стихотворения и поэмы | Лермонтов М.Ю. | Поэзия      | 256   | 4      |
| 2         | Доктор Живаго         | Пастернак Б.Л. | Роман       | 381   | 4      |
| 3         | Остров сокровищ       | Стивенсон Р.Л. | Приключения | 600   | 5      |
+-----------+-----------------------+----------------+-------------+-------+--------+
*/

## 1d) Удаляем книги (которые есть на скаде и не представлены в магазине) из таблицы склада supply;
-- предыдущий код использовать невозможно из-за технических ограничений, но можно использовать временную таблицу supply_temp;
SELECT "Удаляем книги есть на скаде и не в магазине" AS "1d";

SELECT * FROM supply;
DELETE FROM supply
USING supply
INNER JOIN supply_temp USING(title, author)
;
    
-- Проверяем содержимое складa;
SELECT "остаток на складе" AS "1d";

SELECT title, author, genre, price, amount FROM supply;


# 2) Перемещаем книги из магазина на склад по разным правилам;
-- есть одинаковые книги с разной ценой, их нужно вставить в целевую таблицу;
-- есть одинаковые книги с одинаковой ценой, в целевой таблице нужно изменить количество;
-- есть книги, которых нет на складе, но есть в магазине;

## 2a) Вывести  запросом книги с одинаковыми названием, автором и ценой, которые есть в магазине и на складе;
-- в таблице supply нужно обновить значения поля amount;
SELECT "2a" AS "книги с одинаковыми названием, автором и ценой";

SELECT supply.title, supply.author, book.price, supply.price
FROM supply
INNER JOIN book USING(title)
INNER JOIN author ON author.name_author = supply.author AND book.author_id = author.author_id
WHERE supply.price = book.price
;

## 2b) Обновить количество книг с одинаковым названием, автором и ценой, которые есть на складе и в магазине;

UPDATE supply, book, author
SET supply.amount = supply.amount + IF(
    supply.price = (SELECT book.price FROM book
                    INNER JOIN author USING(author_id)
                    WHERE author.name_author = supply.author
                    AND
                    book.title = supply.title),
    (SELECT book.amount FROM book
     INNER JOIN author USING(author_id)
     WHERE author.name_author = supply.author
     AND
     book.title = supply.title), 0)
;

