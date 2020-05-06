CREATE TABLE sales
(
	purchase_number INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    date_of_purchse DATE NOT NULL,
    customer_id INT,
    item_Code VARCHAR(10) NOT NULL
);

CREATE TABLE customers
(
	customer_id INT,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
	email_address VARCHAR(255),
    number_of_complaints INT
);
    
USE Sales;
SELECT *
FROM sales;

SELECT *
FROM sales.sales;

DROP TABLE sales;