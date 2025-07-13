
SELECT city, COUNT(city) AS Количество
FROM trip
GROUP BY city
HAVING Количество > 0
ORDER BY city;


-- примеры с сайта:
SELECT city, COUNT(*) Количество
FROM trip
GROUP BY city
ORDER BY 1;