-- Вывести информацию (автора, название и цену) о  книгах, цены которых меньше или равны средней цене книг на складе. Информацию вывести в отсортированном по убыванию цены виде. Среднее вычислить как среднее по цене книги

SELECT author, title, price FROM book
WHERE price <= (SELECT AVG(price) FROM book)
ORDER BY price DESC;


SELECT AVG(price) FROM book

-- решения с сайта
