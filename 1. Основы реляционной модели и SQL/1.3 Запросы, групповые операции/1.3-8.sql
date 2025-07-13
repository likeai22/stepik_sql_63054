-- Посчитать стоимость всех экземпляров каждого автора без учета книг «Идиот» и «Белая гвардия». В результат включить только тех авторов, у которых суммарная стоимость книг (без учета книг «Идиот» и «Белая гвардия») более 5000 руб. Вычисляемый столбец назвать Стоимость. Результат отсортировать по убыванию стоимости.
SELECT author,
    SUM(price * amount) AS Стоимость
FROM book
WHERE title <> 'Идиот'
    AND title <> 'Белая гвардия'
GROUP BY author
HAVING SUM(price * amount) > 5000
ORDER BY Стоимость DESC;

-- решения с сайта
SELECT author, SUM(price * amount) AS Стоимость FROM book
WHERE title NOT IN ('Идиот', 'Белая Гвардия')
GROUP BY author
HAVING Стоимость > 5000
ORDER BY Стоимость DESC;


SELECT author, SUM(price * amount) AS Стоимость
  FROM book
 WHERE 'Идиот' <> title <> 'Белая гвардия'
 GROUP BY author
HAVING Стоимость >= 5000
 ORDER BY Стоимость DESC;


-- gpt
SELECT author,
    SUM(CASE 
            WHEN title NOT IN ('Идиот', 'Белая гвардия') 
            THEN price * amount 
            ELSE 0 
        END) AS Стоимость
FROM book
GROUP BY author
HAVING SUM(CASE 
               WHEN title NOT IN ('Идиот', 'Белая гвардия') 
               THEN price * amount 
               ELSE 0 
           END) > 5000
ORDER BY Стоимость DESC;


 SELECT author, Стоимость
FROM (
    SELECT author,
           SUM(CASE WHEN title NOT IN ('Идиот', 'Белая гвардия') THEN price * amount ELSE 0 END) AS Стоимость
    FROM book
    GROUP BY author
) AS t
WHERE Стоимость > 5000
ORDER BY Стоимость DESC;
