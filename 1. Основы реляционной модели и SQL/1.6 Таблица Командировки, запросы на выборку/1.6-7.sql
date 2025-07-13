select name,
    city,
    date_first,
    date_last
from trip
where DATEDIFF(date_last, date_first) = (
        select min(DATEDIFF(date_last, date_first))
        from trip
    );

-- примеры с сайта:
select name, city, date_first, date_last
from trip
where DATEDIFF(date_last, date_first) <= ALL(select DATEDIFF(date_last, date_first) from trip);

Select name, city, date_first, date_last
from trip
where (datediff(date_last, date_first)) = (select (datediff(date_last, date_first)) as длительности
       from trip
       order by длительности asc
       limit 1);

