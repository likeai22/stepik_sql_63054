-- 6. Вычисления по таблице целиком
SELECT ROUND(AVG(price), 2) AS Средняя_цена,
    ROUND(SUM(price * amount), 2) AS Стоимость
FROM book
WHERE amount BETWEEN 5 AND 14;

-- решения с сайта

-- Но здесь важно понимать, что в данном запросе оператор HAVING используется для того, чтобы проверить, есть ли хотя бы одна строка в результате запроса (COUNT(*) >= 1). Это может быть полезно, если требуется убедиться, что есть какие-то данные, которые соответствуют заданным условиям, и только потом выполнять дополнительные расчеты.

-- Просто помните, единственная разница состоит в том, что WHERE фильтрует строки, а HAVING - группы.
SELECT ROUND(AVG(price), 2) AS Средняя_цена,
    ROUND(SUM(price * amount), 2) AS Стоимость
FROM book
WHERE amount BETWEEN 5 AND 14
HAVING COUNT(*) >= 1;

-- Через Having
SELECT ROUND(AVG(price), 2) AS Средняя_цена,
    ROUND(SUM(price * amount), 2) AS Стоимость
FROM book
GROUP BY amount BETWEEN 5 AND 14
HAVING SUM(
        amount BETWEEN 5 AND 14
    );