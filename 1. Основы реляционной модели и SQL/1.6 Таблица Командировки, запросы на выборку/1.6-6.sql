select name, city, DATEDIFF(date_last, date_first) + 1 as Длительность from trip
where city not in ('Москва', 'Санкт-Петербург')
order by Длительность desc, city desc;


-- примеры с сайта:
