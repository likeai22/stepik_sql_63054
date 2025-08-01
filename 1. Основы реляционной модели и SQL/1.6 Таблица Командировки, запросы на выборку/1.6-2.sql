
SELECT name, city, per_diem, date_first, date_last FROM trip
WHERE trip.name LIKE '%а %'
ORDER BY date_last DESC;


-- примеры с сайта:

-- Вариант решения не через LIKE. 
-- Есть функция SUBSTRING_INDEX(). 
-- Функция принимает 3 аргумента: атрибут, разделитель, индекс. 
-- Атрибут - штука которую необходимо разделить. Разделитель - штука на которую смотрит функция и по ней разделяет атрибут. Индекс - значение, которое мы хотим получить у разделенного атрибута. Пример:
-- SUBSTRING_INDEX(name, ' ', 1) - раздели атрибут name по пробелу(" ") и верни первое значение. Если в функцию попадает "Федорова А.Ю.", то строка разделиться на 2 части "Федорова" и "А.Ю.", а функция вернет подстроку "Федорова", так как у этой подстроки индекс = 1. Если бы мы указали SUBSTRING_INDEX(name, ' ', 2), то функция вернула бы "А.Ю.", ибо индекс = 2. 
-- После того как мы получили подстроку "Федорова" мы можем легко проверить является ли последняя буква фамилии буквой "а".
-- Для этого можно использовать функцию RIGHT().
-- Функция RIGHT принимает 2 аргумента строку и позицию. Пример:
-- RIGHT(name, 1) - вернет первый символ с правой стороны строки. Значит, если мы дадим в функцию подстроку "Федорова", то мы получим последнюю букву фамилии - букву "а". RIGHT("Федорова", 1) вернет букву "а". 
-- Теперь мы можем объединить две функции. Первая функция вернет фамилию, а вторая функция вернет последнюю букву, после этого мы сравним последнюю букву с требуемым значением. Итак:
-- RIGTH(SUBSTRING_INDEX(name, ' ', 1), 1)
-- Далее засовываем это в условие и кайфуем:
-- WHERE RIGHT(SUBSTRING_INDEX(name,' ',1),1) = 'а' 

select name, city, per_diem, date_first, date_last from trip
WHERE RIGHT(SUBSTRING_INDEX(name,' ',1),1) = 'а' 
order by date_last DESC


SELECT name, city, per_diem, date_first, date_last
FROM trip
WHERE name LIKE '%а _._.'
ORDER BY date_last DESC;