-- Create DataBase 
CREATE DATABASE incubyte;
SHOW DATABASES;
USE incubyte;
SHOW TABLES;

-- Creating the table to import salesdata dataset into
CREATE TABLE IF NOT EXISTS salesdata (
    TransactionID INT,
    CustomerID INT,  
    TransactionDate DATETIME,
    TransactionAmount DECIMAL(8, 2),  
    PaymentMethod VARCHAR(20),
    Quantity INT, 
    DiscountPercent DECIMAL(5, 2),
    City VARCHAR(20),
    StoreType VARCHAR(20),
    CustomerAge INT,
    CustomerGender VARCHAR(10),
    LoyaltyPoints INT,
    ProductName VARCHAR(20),
    Region VARCHAR(20),
    Returned VARCHAR(5),
    FeedbackScore INT,
    ShippingCost DECIMAL(6, 2),
    DeliveryTimeDays INT,
    IsPromotional VARCHAR(5),
    PRIMARY KEY (TransactionID)
);

-- Importing the data in chunks created by python script
SHOW VARIABLES LIKE 'local_infile';
SET global local_infile = 1;

LOAD DATA LOCAL INFILE 'C:/Users/user/Downloads/incubyte/formatted_data_1.csv'
INTO TABLE salesdata
FIELDS TERMINATED BY ','          
ENCLOSED BY '"'                   
LINES TERMINATED BY '\n'          
(
  TransactionID,                  
  CustomerID,
  TransactionDate,
  TransactionAmount,
  PaymentMethod,
  Quantity,
  DiscountPercent,
  City,
  StoreType,
  CustomerAge,
  CustomerGender,
  LoyaltyPoints,
  ProductName,
  Region,
  Returned,
  FeedbackScore,
  ShippingCost,
  DeliveryTimeDays,
  IsPromotional
);
-- Check the data imported
SELECT * FROM salesdata LIMIT 5;
-- Verify that all data has been imported
SELECT COUNT(1) FROM salesdata;

LOAD DATA LOCAL INFILE 'C:/Users/user/Downloads/incubyte/formatted_data_2.csv'
INTO TABLE salesdata
FIELDS TERMINATED BY ','          
ENCLOSED BY '"'                   
LINES TERMINATED BY '\n';   

-- Verify that all data has been imported
SELECT COUNT(1) FROM salesdata;

LOAD DATA LOCAL INFILE 'C:/Users/user/Downloads/incubyte/formatted_data_3.csv'
INTO TABLE salesdata
FIELDS TERMINATED BY ','          
ENCLOSED BY '"'                   
LINES TERMINATED BY '\n';   

-- Verify that all data has been imported
SELECT COUNT(1) FROM salesdata;

LOAD DATA LOCAL INFILE 'C:/Users/user/Downloads/incubyte/formatted_data_4.csv'
INTO TABLE salesdata
FIELDS TERMINATED BY ','          
ENCLOSED BY '"'                   
LINES TERMINATED BY '\n';   

-- Verify that all data has been imported
SELECT COUNT(1) FROM salesdata;

LOAD DATA LOCAL INFILE 'C:/Users/user/Downloads/incubyte/formatted_data_5.csv'
INTO TABLE salesdata
FIELDS TERMINATED BY ','          
ENCLOSED BY '"'                   
LINES TERMINATED BY '\n';   

-- Verify that all data has been imported
SELECT COUNT(1) FROM salesdata;
-- At the end all 500,000 records were added to the table


