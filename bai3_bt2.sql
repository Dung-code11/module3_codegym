CREATE DATABASE qlbanhang;
USE qlbanhang;

CREATE TABLE Customer (
    cID INT PRIMARY KEY,
    Name VARCHAR(255),
    cAge TINYINT
);

INSERT INTO Customer (cID, Name, cAge) VALUES
(1, 'Minh Quan', 10),
(2, 'Ngoc Oanh', 20),
(3, 'Hong Ha', 50);

CREATE TABLE `Order` (
    oID INT PRIMARY KEY,
    cID INT,
    oDate DATETIME,
    oTotalPrice INT DEFAULT NULL,
    CONSTRAINT fk_order_customer
        FOREIGN KEY (cID) REFERENCES Customer(cID)
);

INSERT INTO `Order` (oID, cID, oDate, oTotalPrice) VALUES
(1, 1, '2006-03-21', NULL),
(2, 2, '2006-03-23', NULL),
(3, 1, '2006-03-16', NULL);

CREATE TABLE Product (
    pID INT PRIMARY KEY,
    pName VARCHAR(25),
    pPrice INT
);

INSERT INTO Product (pID, pName, pPrice) VALUES
(1, 'May Giat', 3),
(2, 'Tu Lanh', 5),
(3, 'Dieu Hoa', 7),
(4, 'Quat', 1),
(5, 'Bep Dien', 2);

CREATE TABLE OrderDetail (
    oID INT,
    pID INT,
    odQTY INT,
    PRIMARY KEY (oID, pID),
    CONSTRAINT fk_od_order    FOREIGN KEY (oID) REFERENCES `Order`(oID),
    CONSTRAINT fk_od_product  FOREIGN KEY (pID) REFERENCES Product(pID)
);

INSERT INTO OrderDetail (oID, pID, odQTY) VALUES
(1, 1, 3),
(1, 3, 7),
(1, 4, 2),
(2, 1, 1),
(3, 1, 8),
(2, 5, 4),
(2, 3, 3);

-- bai 1
SELECT 
    o.oID,
    c.Name AS CustomerName,
    o.oDate,
    SUM(od.odQTY * p.pPrice) AS TotalPrice
FROM `Order` AS o
JOIN Customer AS c ON o.cID = c.cID
JOIN OrderDetail AS od ON o.oID = od.oID
JOIN Product AS p ON od.pID = p.pID
GROUP BY o.oID, c.Name, o.oDate;

-- bai 2
UPDATE `Order` AS o
JOIN (
    SELECT od.oID, SUM(od.odQTY * p.pPrice) AS total
    FROM OrderDetail AS od
    JOIN Product AS p ON od.pID = p.pID
    GROUP BY od.oID
) AS t ON o.oID = t.oID
SET o.oTotalPrice = t.total;

-- bai3
SELECT DISTINCT c.Name
FROM Customer AS c
JOIN `Order` AS o ON c.cID = o.cID
JOIN OrderDetail AS od ON o.oID = od.oID
JOIN Product AS p ON od.pID = p.pID
WHERE p.pName = 'Dieu Hoa';

-- bai4
SELECT c.Name
FROM Customer AS c
LEFT JOIN `Order` AS o ON c.cID = o.cID
WHERE o.oID IS NULL;
