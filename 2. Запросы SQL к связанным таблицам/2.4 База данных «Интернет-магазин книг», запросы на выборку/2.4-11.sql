SELECT buy_id,
    DATEDIFF(date_step_end, date_step_beg) AS Количество_дней,
    IF (
        days_delivery - DATEDIFF(date_step_end, date_step_beg) < 0,
        DATEDIFF(date_step_end, date_step_beg) - days_delivery, 0
    ) AS Опоздание
FROM city
    JOIN client USING(city_id)
    JOIN buy USING(client_id)
    JOIN buy_step USING(buy_id)
    JOIN step USING(step_id)
WHERE step_id = 3
    AND date_step_end
ORDER BY buy_id;


-- с сайта
SELECT buy_id, delta AS Количество_дней, 
IF(delta - days_delivery > 0, delta - days_delivery, 0) AS Опоздание 
FROM city
INNER JOIN client USING(city_id)
INNER JOIN buy USING(client_id)
INNER JOIN (SELECT buy_id, DATEDIFF(date_step_end, date_step_beg) delta 
            FROM buy_step INNER JOIN step USING(step_id)
            WHERE name_step = 'Транспортировка' AND date_step_end) temp USING(buy_id)
ORDER BY buy_id;    

-- зачем WHERE, если можно джойнить таблицы сразу по условиям задачи :)
SELECT buy_step.buy_id,
       DATEDIFF(date_step_end, date_step_beg) as Количество_дней,
       IF(DATEDIFF(date_step_end, date_step_beg)>days_delivery, DATEDIFF(date_step_end, date_step_beg)-days_delivery, 0) as Опоздание
FROM city
    JOIN client   USING(city_id)
    JOIN buy      USING(client_id)
    JOIN buy_step ON buy_step.buy_id = buy.buy_id and date_step_end is not NULL
    JOIN step     ON step.step_id = buy_step.step_id and name_step = 'Транспортировка';

-- Вариант с использованием GREATEST вместо IF:
SELECT
    buy_id,
    DATEDIFF(date_step_end, date_step_beg) AS Количество_дней,
    GREATEST(DATEDIFF(date_step_end, date_step_beg) - days_delivery, 0) AS Опоздание
FROM
    buy
    INNER JOIN buy_step USING(buy_id)
    INNER JOIN step     USING(step_id)
    INNER JOIN client   USING(client_id)
    INNER JOIN city     USING(city_id)
WHERE
    name_step = 'Транспортировка' AND date_step_end IS NOT NULL
ORDER BY buy_id;

-- nc
SELECT buy_id,
       (@D := DATEDIFF(date_step_end, date_step_beg)) AS Количество_дней,
       IF(@D > days_delivery,
          @D - city.days_delivery, 0)                 AS Опоздание
FROM city
         INNER JOIN client USING (city_id)
         INNER JOIN buy USING (client_id)
         INNER JOIN buy_step USING (buy_id)
         INNER JOIN step USING (step_id)
WHERE name_step = 'Транспортировка'
  AND date_step_end IS NOT NULL
ORDER BY 1;