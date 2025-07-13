-- 6. Вычисления по таблице целиком
SELECT ROUND(MIN(price), 2) as Минимальная_цена,
    ROUND(MAX(price), 2) as Максимальная_цена,
    ROUND(AVG(price), 2) as Средняя_цена
FROM book;

-- решения с сайта
-- Уникальные названия произведений, но если названия будут повторяться у разных авторов, не пройдет. Вроде в следующих уроках будет информация по этой теме))
SELECT MIN(price) AS Минимальная_цена,
    MAX(price) AS Максимальная_цена,
    ROUND(AVG(price), 2) AS Средняя_цена
FROM (SELECT DISTINCT author, title, price FROM book) as _;
