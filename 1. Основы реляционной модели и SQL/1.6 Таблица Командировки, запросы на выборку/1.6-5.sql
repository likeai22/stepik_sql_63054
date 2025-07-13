select city, count(city) as Количество from trip
GROUP BY city
order by Количество desc
limit 2;


-- примеры с сайта:
