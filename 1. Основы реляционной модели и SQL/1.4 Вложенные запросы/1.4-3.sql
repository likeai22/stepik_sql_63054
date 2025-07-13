-- Вывести информацию (автора, название и цену) о тех книгах, цены которых превышают минимальную цену книги на складе не более чем на 150 рублей в отсортированном по возрастанию цены виде.

-- INSERT INTO book (title, author, price, amount) VALUES
-- ('Евгений Онегин', 'Пушкин А.С.', 610.00, 10);

SELECT author, title, price FROM book
WHERE price <= (SELECT MIN(price) + 150 FROM book)
ORDER BY price;

SELECT MIN(price) FROM book

-- решения с сайта
SELECT author, title, price 
FROM book
WHERE (price-(SELECT MIN(price) FROM book)) BETWEEN 0 AND 150 
ORDER BY price ASC;

SELECT author, title, price
FROM book
WHERE price <= ((SELECT MIN(price) FROM book) + 150)
ORDER BY price;