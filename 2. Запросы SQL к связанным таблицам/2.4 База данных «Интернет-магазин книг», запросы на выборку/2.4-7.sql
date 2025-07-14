SELECT c.name_city, COUNT(*) AS Количество
FROM 
    city c
    JOIN client cl USING(city_id)
    JOIN buy b USING(client_id)
GROUP BY b.client_id, c.name_city
ORDER BY Количество DESC, c.name_city; 

SELECT name_city, COUNT(*) AS Количество
FROM 
    city
    JOIN client USING(city_id)
    JOIN buy USING(client_id)
GROUP BY name_city
ORDER BY Количество DESC, name_city; 


-- SHOW COLUMNS FROM client;
-- SHOW COLUMNS FROM buy;
-- SHOW COLUMNS FROM city;
