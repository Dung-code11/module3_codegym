-- bài 1
CREATE database db_demo;
use db_demo;

-- bài 2
CREATE TABLE Products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    productCode VARCHAR(50),
    productName VARCHAR(100),
    productPrice DECIMAL(10,2),
    productAmount INT,
    productDescription TEXT,
    productStatus BOOLEAN
);
INSERT INTO Products (productCode, productName, productPrice, productAmount, productDescription, productStatus)
VALUES
('P001', 'Laptop Dell', 1200.00, 10, 'Dell XPS 13', 1),
('P002', 'MacBook Air', 1300.00, 5, 'Apple M1', 1),
('P003', 'Asus ROG', 1500.00, 3, 'Gaming Laptop', 1),
('P004', 'HP Envy', 1100.00, 7, 'HP Premium Series', 0);

-- bài 3

CREATE UNIQUE INDEX idx_unique_productCode on Products(prouctCode);
CREATE INDEX idx_name_price on Products(productName,productPrice);
EXPLAIN SELECT * FROM Products WHERE productCode = 'P003';
EXPLAIN SELECT * FROM Products WHERE productName = 'Asus ROG' AND productPrice = 1500.00;

-- bài 4
CREATE VIEW v_product_basic AS 
SELECT productCode, productName,productPrice,productStatus
FROM Products;

CREATE OR REPLACE VIEW v_product_basic AS
SELECT productCode, productName, productPrice, productStatus, productAmount
FROM Products;

DROP VIEW IF EXISTS v_product_basic;

-- bài 5

DELIMITER //
CREATE PROCEDURE sp_get_all_products()
BEGIN
    SELECT * FROM Products;
END //
DELIMITER ;
CALL sp_get_all_products();

DELIMITER //
CREATE PROCEDURE sp_add_product(
    IN p_code VARCHAR(50),
    IN p_name VARCHAR(100),
    IN p_price DECIMAL(10,2),
    IN p_amount INT,
    IN p_description TEXT,
    IN p_status BOOLEAN
)
BEGIN
    INSERT INTO Products (productCode, productName, productPrice, productAmount, productDescription, productStatus)
    VALUES (p_code, p_name, p_price, p_amount, p_description, p_status);
END //
DELIMITER ;
CALL sp_add_product('P005', 'Lenovo ThinkPad', 1000.00, 8, 'Business laptop', 1);

DELIMITER //
CREATE PROCEDURE sp_update_product_by_id(
    IN p_id INT,
    IN p_name VARCHAR(100),
    IN p_price DECIMAL(10,2),
    IN p_amount INT,
    IN p_description TEXT,
    IN p_status BOOLEAN
)
BEGIN
    UPDATE Products
    SET productName = p_name,
        productPrice = p_price,
        productAmount = p_amount,
        productDescription = p_description,
        productStatus = p_status
    WHERE id = p_id;
END //
DELIMITER ;
CALL sp_update_product_by_id(2, 'MacBook Pro', 2000.00, 6, 'Updated version', 1);

DELIMITER //
CREATE PROCEDURE sp_delete_product_by_id(IN p_id INT)
BEGIN
    DELETE FROM Products WHERE id = p_id;
END //
DELIMITER ;
CALL sp_delete_product_by_id(4);





