USE stepik_sql_63054;

DROP TABLE IF EXISTS supply;
CREATE table supply(
    supply_id int primary key auto_increment,
    title	VARCHAR(50),
    author	VARCHAR(30),
    price	DECIMAL(8, 2),
    amount	INT
)