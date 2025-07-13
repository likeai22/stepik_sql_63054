-- Посчитать сколько и каких экземпляров книг нужно заказать поставщикам, чтобы на складе стало одинаковое количество экземпляров каждой книги, равное значению самого большего количества экземпляров одной книги на складе. Вывести название книги, ее автора, текущее количество экземпляров на складе и количество заказываемых экземпляров книг. Последнему столбцу присвоить имя Заказ. В результат не включать книги, которые заказывать не нужно.


SELECT title,
    author,
    amount,
    (
        abs(
            amount - (
                SELECT max(amount)
                FROM book
            )
        )
    ) AS Заказ
FROM book
WHERE abs(
        amount - (
            SELECT max(amount)
            FROM book
        )
    ) > 0;


-- решения с сайта
SELECT title,
    author,
    amount,
    (
        SELECT MAX(amount)
        FROM book
    ) - amount AS Заказ
FROM book
HAVING Заказ > 0;

SELECT title,
    author,
    amount,
    (
        SELECT MAX(amount)
        FROM book
    ) - amount AS Заказ
FROM book
WHERE amount NOT IN (
        SELECT MAX(amount)
        FROM book
    );


with cte as (
    SELECT max(amount) max_count
    FROM book
)
SELECT title,
    author,
    amount,
    cte.max_count - amount AS Заказ
FROM cte,
    book
WHERE cte.max_count - amount > 0
