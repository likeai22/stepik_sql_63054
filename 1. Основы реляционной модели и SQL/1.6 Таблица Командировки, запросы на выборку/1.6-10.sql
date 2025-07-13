select name,
    city,
    date_first,
    per_diem * (datediff(date_last, date_first) + 1) as Сумма
from trip
where date_first LIKE '2020-02-%'
    or date_first LIKE '2020-03-%'
order BY name,
    Сумма desc

-- примеры с сайта:
SELECT name, city, date_first, per_diem*(DATEDIFF(date_last, date_first) + 1) AS Сумма
FROM trip
WHERE date_first BETWEEN '2020-02-01' AND '2020-03-31'
ORDER BY name, Сумма DESC


select name, city, date_first, per_diem*(datediff(date_last,date_first)+1) as Сумма from trip
where MONTH(date_first) in (2,3) and YEAR(date_first) = 2020
order by name, Сумма desc;


select
name 
, city
, date_first 
, (datediff(date_last,date_first)+1)*per_diem as Сумма
from trip
where MONTHNAME(date_first) in ('February','March')
and year(date_first)='2020'
order by name, per_diem 
