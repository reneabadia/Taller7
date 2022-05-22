CREATE DATABASE softka_store;

-- Show all databases
SHOW DATABASES;

-- Use DB
USE softka_store;

-- Show All tables
SHOW FULL TABLES FROM softka_store;

-- Create Tables
CREATE TABLE provider(
	provider_id INT AUTO_INCREMENT NOT NULL,
    provider_name VARCHAR(150) NOT NULL,
    provider_mail VARCHAR(150) NOT NULL,
    provider_nit VARCHAR(150) NOT NULL,
    logic_deleted ENUM('true','false') DEFAULT 'false' NULL,
    PRIMARY KEY (provider_id)
)ENGINE=InnoDB;

CREATE TABLE product(
	product_id INT AUTO_INCREMENT NOT NULL,
    product_name VARCHAR(150) NOT NULL,
    product_price VARCHAR(150) NOT NULL,
    product_serial VARCHAR(150) NOT NULL,
    logic_deleted ENUM('true','false') DEFAULT 'false' NULL,
    id_provider INT NOT NULL,
    PRIMARY KEY (product_id),
    INDEX id_provider (id_provider),
    CONSTRAINT FK_product_provider FOREIGN KEY (id_provider) REFERENCES provider (provider_id) ON UPDATE RESTRICT ON DELETE RESTRICT
)ENGINE=InnoDB;

CREATE TABLE seller(
	seller_id INT AUTO_INCREMENT NOT NULL,
    seller_name VARCHAR(150) NOT NULL,
    logic_delete ENUM('true','false') DEFAULT 'false' NULL,
    PRIMARY KEY (seller_id)
)ENGINE=InnoDB;

CREATE TABLE client(
	client_id INT AUTO_INCREMENT NOT NULL,
    doc_type VARCHAR(150) NOT NULL,
    doc_number VARCHAR(150) NOT NULL,
    logic_deleted ENUM('true','false') DEFAULT 'false' NULL,
    PRIMARY KEY (client_id)
)ENGINE=InnoDB;

CREATE TABLE sales(
	sales_id INT AUTO_INCREMENT NOT NULL,
    id_seller INT NOT NULL, 
    id_client INT NOT NULL,
    warranty_id VARCHAR(150) NOT NULL,
    logic_deleted ENUM('true','false') DEFAULT 'false' NULL,
    PRIMARY KEY (sales_id),
    INDEX id_seller (id_seller),
	INDEX id_client (id_client),
    CONSTRAINT FK_seller_sale FOREIGN KEY (id_seller) REFERENCES seller (seller_id) ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT FK_client_sale FOREIGN KEY (id_client) REFERENCES client (client_id) ON UPDATE CASCADE ON DELETE CASCADE
)ENGINE=InnoDB;

CREATE TABLE sold_product(
	sold_product_id INT AUTO_INCREMENT NOT NULL,
    id_sales INT NOT NULL,
    id_product INT NOT NULL,
    PRIMARY KEY (sold_product_id),
    INDEX id_sales (id_sales),
	INDEX id_product (id_product),
    FOREIGN KEY (id_product) REFERENCES product (product_id),
    CONSTRAINT FK_sale_sold_product FOREIGN KEY (id_sales) REFERENCES sales (sales_id) ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT FK_product_sold_product FOREIGN KEY (id_product) REFERENCES product (product_id) ON UPDATE CASCADE ON DELETE CASCADE
)ENGINE=InnoDB;

CREATE TABLE product_provider(
	product_provider_id INT AUTO_INCREMENT NOT NULL,
    id_product INT NOT NULL,
    id_provider INT NOT NULL,
    PRIMARY KEY (product_provider_id),
    INDEX id_provider (id_provider),
	INDEX id_product (id_product)
)ENGINE=InnoDB;

-- Insert data in tables
INSERT INTO provider (provider_name, provider_mail, provider_nit) 
	VALUES 
		('Microsoft', 'microsift@mail.com', '0101010'),
		('Apple', 'apple@mail.com', '0202020'),
		('Apple', 'xiaomi@mail.com', '0303030');
    
INSERT INTO seller (seller_name) 
	VALUES ('Fulanito');

INSERT INTO product (product_name, product_price, product_serial, id_provider) 
	VALUES 
		('Xbox One Series S', '1200', '0123467890', 1),
		('iPhone 12', '100', '0012346789', 2),
		('MiBand 4', '70', '1234678900', 3),
        ('Mouse', '10', '6543210', 1),
        ('Keyboard', '30', '796421', 2);

INSERT INTO client (doc_type, doc_number) 
	VALUES 
		('Passport', '123456789'),
		('CC', '987654321'),
		('CC', '147258369'),
		('CC', '13579'),
		('CC', '97531');

INSERT INTO sales (id_seller, id_client, warranty_id) 
	VALUES 
		(1, 1, 'qwerty'),
		(1, 2, 'poiuyt'),
		(1, 3, 'zxcvbn'),
        (1, 4, 'bill_4'),
        (1, 5, 'bill_5');
      
INSERT INTO sold_product (id_sales, id_product)
	VALUES
		(4, 1),
		(5, 2);
        


-- Delete sales phisycal
DELETE FROM sales WHERE sales_id= 1;
DELETE FROM sales WHERE sales_id= 2;

-- Delete sales logical
UPDATE sales SET logic_deleted='true' WHERE sales_id= 3;
UPDATE sales SET logic_deleted='true' WHERE sales_id= 4;

-- Modify Products
UPDATE product SET product_name='Xbox One X' WHERE product_id=1;
UPDATE product SET product_name='iPhone 13' WHERE product_id=2;
UPDATE product SET product_name='Xiaomi MiBand 6' WHERE product_id=3;

-- Modify Providers
UPDATE provider SET provider_name='Distritech' WHERE provider_id=1;
UPDATE provider SET provider_name='Super distributor' WHERE provider_id=2;
UPDATE provider SET provider_name='Porktech importations' WHERE provider_id=3;

-- Table Querys
SELECT * FROM product;
SELECT * FROM provider;
SELECT * FROM seller;
SELECT * FROM client;
SELECT * FROM sales;
SELECT * FROM sold_product;






