-- Create DataBase 
CREATE DATABASE incubyte;
SHOW DATABASES;
USE incubyte;
SHOW TABLES;
describe salesdata;
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

-- Check NULL values 
SELECT SUM(CASE WHEN TransactionID IS NULL THEN 1 ELSE 0 END) AS transacid_nulls,
	SUM(CASE WHEN CustomerID IS NULL THEN 1 ELSE 0 END) AS custid_nulls,
    SUM(CASE WHEN TransactionDate IS NULL THEN 1 ELSE 0 END) AS date_nulls,
    SUM(CASE WHEN TransactionAmount IS NULL THEN 1 ELSE 0 END) AS amount_nulls,
    SUM(CASE WHEN PaymentMethod IS NULL THEN 1 ELSE 0 END) AS paymethod_nulls,
    SUM(CASE WHEN Quantity IS NULL THEN 1 ELSE 0 END) AS quant_nulls,
    SUM(CASE WHEN DiscountPercent IS NULL THEN 1 ELSE 0 END) AS discount_nulls,
    SUM(CASE WHEN City IS NULL THEN 1 ELSE 0 END) AS city_nulls,
    SUM(CASE WHEN StoreType IS NULL THEN 1 ELSE 0 END) AS storetype_nulls,
    SUM(CASE WHEN CustomerAge IS NULL THEN 1 ELSE 0 END) AS cust_age_nulls,
    SUM(CASE WHEN CustomerGender IS NULL THEN 1 ELSE 0 END) AS cust_gender_nulls,
    SUM(CASE WHEN LoyaltyPoints IS NULL THEN 1 ELSE 0 END) AS loyalty_points_nulls,
    SUM(CASE WHEN ProductName IS NULL THEN 1 ELSE 0 END) AS product_nulls,
    SUM(CASE WHEN Region IS NULL THEN 1 ELSE 0 END) AS region_nulls,
    SUM(CASE WHEN Returned IS NULL THEN 1 ELSE 0 END) AS returned_nulls,
    SUM(CASE WHEN FeedbackScore IS NULL THEN 1 ELSE 0 END) AS feedback_nulls,
    SUM(CASE WHEN ShippingCost IS NULL THEN 1 ELSE 0 END) AS shipping_nulls,
    SUM(CASE WHEN DeliveryTimeDays IS NULL THEN 1 ELSE 0 END) AS delay_nulls,
    SUM(CASE WHEN IsPromotional IS NULL THEN 1 ELSE 0 END) AS ispromotional_nulls
FROM salesdata;


-- TransactionID, TransactionAmount, Quantity, DiscountPercent, City, LoyaltyPoints, Returned, FeedbackScore, ShippingCost, DeliveryTimeDays, and IsPromotional columns have no NULL values.
-- The following columns have multiple NULL values as shown below:
/*
---------------------------------
| CustomerID		| 50,000	|
| TransactionDate	| 50,000	|
| PaymentMethod		| 50,000	|
| StoreType			| 50,000	|
| CustomerAge		| 50,000	|
| CustomerGender	| 50,000	|
| ProductName		| 50,000	|
| Region			| 42,633	|
---------------------------------
*/

