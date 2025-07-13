SELECT name, number_plate, violation FROM fine f 
GROUP BY name, number_plate, violation
HAVING count(violation) > 1
ORDER BY name, number_plate, violation;


-- примеры с сайта
