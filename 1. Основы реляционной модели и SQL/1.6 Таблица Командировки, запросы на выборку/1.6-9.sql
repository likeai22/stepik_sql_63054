select MONTHNAME(date_first) as Месяц, count(MONTHNAME(date_first)) as Количество from trip
GROUP BY Месяц
order by Количество desc, Месяц asc;

-- примеры с сайта:
SELECT MONTHNAME(date_first) AS Месяц, Count(1) AS Количество FROM trip
GROUP BY Месяц
ORDER BY Количество DESC, Месяц



