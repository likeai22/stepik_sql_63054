select name,
    city,
    date_first,
    date_last
from trip
where MONTH(date_first) = MONTH(date_last)
ORDER BY city asc, name asc

-- примеры с сайта:
SELECT name, city, date_first, date_last FROM trip
WHERE EXTRACT(month FROM date_first) =
EXTRACT(month FROM date_last)
ORDER BY city, name


