INSERT INTO buy (buy_description, client_id) 
SELECT 'Связаться со мной по вопросу доставки', (SELECT client_id FROM client WHERE name_client='Попов Илья');

-- stepik
