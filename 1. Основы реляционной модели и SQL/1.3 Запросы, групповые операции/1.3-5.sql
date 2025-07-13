-- 5. Выборка данных c вычислением, групповые функции
SELECT author,
    ROUND(SUM(price * amount), 2) AS Стоимость,
    ROUND(
        (SUM(price * amount) * 18 / 100) / (1 + 18 / 100),
        2
    ) AS НДС,
    ROUND(SUM(price * amount) / (1 + 18 / 100), 2) AS Стоимость_без_НДС
FROM book
GROUP BY author;


-- решения с сайта
-- Вынес price*amount во вложенный запрос
SELECT a as author,
    t as Стоимость,
    ROUND(t * 0.18 / 1.18, 2) as НДС,
    ROUND(t / 1.18, 2) as Стоимость_без_НДС
FROM (
        SELECT author as a,
            SUM(price * amount) as t
        FROM book
        GROUP BY author
    ) as _

-- можно ещё укоротить
SELECT t.*,
    ROUND(Стоимость * 0.18 / 1.18, 2) НДС,
    ROUND(Стоимость / 1.18, 2) Стоимость_без_НДС
FROM (
        SELECT author,
            SUM(price * amount) Стоимость
        FROM book
        GROUP BY author
    ) t

-- Вот вариант с подзапросом и возможностью быстро менять налог 18 AS tax
SELECT s.author,
    ROUND(s.totalsum, 2) AS Стоимость,
    ROUND(s.totalsum * (tax / 100) / (1 + tax / 100), 2) AS НДС,
    ROUND(s.totalsum / (1 + tax / 100), 2) AS Стоимость_без_НДС
FROM (
        SELECT author,
            SUM(price * amount) AS totalsum,
            18 AS tax
        FROM book
        GROUP BY author
    ) AS s;
