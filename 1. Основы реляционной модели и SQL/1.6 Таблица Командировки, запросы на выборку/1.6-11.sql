-- UPDATE trip
-- set date_last = '2020-03-02'
-- where trip_id = 4

select name,
    sum((datediff(date_last, date_first) + 1) * per_diem) as Сумма
from trip
GROUP BY name
HAVING count(per_diem) > 3
ORDER BY Сумма desc


-- примеры с сайта:
select name, sum((datediff(date_last, date_first)+1)*per_diem) Сумма
from trip 
group by name
having count(*)>3
;

-- Когда не научился пользоваться HAVING COUNT
SELECT name, SUM((DATEDIFF(date_last,date_first)+1)*per_diem) AS Сумма
FROM trip
WHERE name IN (SELECT IF(COUNT(name)>3,name,0) from trip group by name)
GROUP BY name
ORDER BY name