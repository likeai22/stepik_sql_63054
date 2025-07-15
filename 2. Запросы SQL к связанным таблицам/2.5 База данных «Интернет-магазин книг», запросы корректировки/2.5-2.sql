INSERT INTO client (name_client, city_id, email) VALUES ('Попов Илья', 1, 'popov@test');

-- stepik
Insert into client
(name_client, city_id, email)
select 'Попов Илья', (select city_id from city where name_city='Москва'), 'popov@test'