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
| StoreType		| 50,000	|
| CustomerAge		| 50,000	|
| CustomerGender	| 50,000	|
| ProductName		| 50,000	|
| Region		| 42,633	|
---------------------------------
*/

-- Part 1: Analysing Transaction Amount-------------------------------------
----------------------------------------------------------------------------
-- Total sales 
SELECT SUM(TransactionAmount) AS TotalSales
FROM salesdata;
-- Total sales amounted to Rs 10,202,662,960.19

-- Average Transaction Amount 
SELECT AVG(TransactionAmount) AS AvgTransactionAmount
FROM salesdata;
-- 20,405.32

-- Top 10 customers by total overall sales
SELECT CustomerID, SUM(TransactionAmount) as TotalTransactionAmount
FROM salesdata
WHERE CustomerID IS NOT NULL
GROUP BY CustomerID
ORDER BY TotalTransactionAmount DESC
LIMIT 10;

/* The top 10 customers by total overall sales is as:
CustomerID	TotalTransactionAmount
32460		800724.49
39732		773331.78
10494		773034.52
17752		769126.59
9502		763669.57
17919		762414.23
28140		750696.90
18111		740229.76
28256		732385.24
1910		698656.27
*/

-- Bottom 5 customers by total overall sales
SELECT CustomerID, SUM(TransactionAmount) as TotalTransactionAmount
FROM salesdata
WHERE CustomerID IS NOT NULL
GROUP BY CustomerID
ORDER BY TotalTransactionAmount 
LIMIT 5;
/*
CustomerID	TotalTransactionAmount
35462		-664.86
39606		-598.96
45098		 22.34
32287		 64.87
46086		 67.54
*/

-- Sales by Region 
SELECT Region, SUM(TransactionAmount) AS SalesByRegion
FROM salesdata
GROUP BY Region
ORDER BY SalesByRegion DESC;
/*
Region	SalesByRegion
South	3,177,273,109.38
East	2,654,969,082.59
North	2,171,502,697.87
West	2,159,911,845.88
NULL	   39,006,224.47

From the test set (first 100 records), the cities and the regions don't always match, example Lucknow is recoded to be in both West and North. If the regions are not absolute, and represent different parts of the same city further analysis needs to be done.
*/

SELECT COUNT(DISTINCT City) FROM salesdata;

-- Total revenue by city 
SELECT City, SUM(TransactionAmount) AS RevenueByCity
FROM salesdata
GROUP BY City
ORDER BY RevenueByCity DESC;
/*
City		RevenueByCity
Kolkata		1,027,325,507.51
Ahmedabad	1,023,675,900.25
Bangalore	1,022,379,945.89
Pune		1,022,136,461.28
Chennai		1,022,122,710.60
Delhi		1,021,352,525.15
Lucknow		1,021,207,908.00
Mumbai		1,018,525,530.92
Jaipur		1,015,044,077.82
Hyderabad	1,008,892,392.77

The top revenue is generated by cities like Kolkata and Ahmedabad, and least in cities like Mumbai and Hydrabad. 
*/

-- Sales by Payment Method
SELECT PaymentMethod, SUM(TransactionAmount) AS SalesByPaymentMethod
FROM salesdata
GROUP BY PaymentMethod
ORDER BY SalesByPaymentMethod DESC;

/*
PaymentMethod	SalesByPaymentMethod
Cash			2,556,679,197.41
Debit Card		2,552,366,143.98
UPI				2,530,177,440.30
Credit Card		2,517,706,935.56
NULL			   45,733,242.94
*/

-- Sales by Store Type
SELECT StoreType, SUM(TransactionAmount) AS SalesByStoreType
FROM salesdata
GROUP BY StoreType
ORDER BY SalesByStoreType DESC;

/*
StoreType	SalesByStoreType
In-Store	5,078,881,502.74
Online		5,078,048,214.51
NULL		   45,733,242.94
*/

-- Sales by Product 
SELECT ProductName, SUM(TransactionAmount) AS SalesByProduct
FROM salesdata
GROUP BY ProductName
ORDER BY SalesByProduct DESC;

/*
ProductName	SalesByProduct
Laptop		6,231,220,430.24
Sofa		3,777,022,903.56
T-Shirt		  102,306,079.47
NULL		   45,733,242.94
Notebook	   24,079,586.12
Apple		   22,300,717.86
*/	

-- Sales by Customer Age Group
SELECT 
    CASE 
        WHEN CustomerAge BETWEEN 18 AND 25 THEN '18-25'
        WHEN CustomerAge BETWEEN 26 AND 35 THEN '26-35'
        WHEN CustomerAge BETWEEN 36 AND 45 THEN '36-45'
        WHEN CustomerAge BETWEEN 46 AND 60 THEN '46-60'
        WHEN CustomerAge BETWEEN 60 AND 150 THEN'60+'
        ELSE 'Age Not Mentioned'
    END AS AgeGroup,
    SUM(TransactionAmount) AS SalesByAgeGroup
FROM salesdata
GROUP BY AgeGroup
ORDER BY AgeGroup;

/*
AgeGroup			SalesByAgeGroup
18-25				1,422,126,799.06
26-35				1,791,131,581.70
36-45				1,780,329,661.52
46-60				2,680,156,973.73
60+					2,528,917,944.18
Age Not Mentioned	   45,733,242.94
*/

-- Sales by Gender
SELECT CustomerGender, SUM(TransactionAmount) AS SalesByGender
FROM salesdata
GROUP BY CustomerGender
ORDER BY SalesByGender DESC;

/*
CustomerGender	SalesByGender
Male			3397984626.42
Other			3391554647.25
Female			3367390443.58
NULL			45733242.94
*/

-- Sales Discount Impact
SELECT SUM(TransactionAmount),  DiscountPercent 
FROM salesdata
GROUP BY DiscountPercent;
-- Here the DiscountPercent is given correct to 2 decimal places, due to which the query output is not intuitively useful

SELECT ROUND(DiscountPercent,0) AS WholePercent, SUM(TransactionAmount) AS SalesByDiscount
FROM salesdata
GROUP BY WholePercent
ORDER BY WholePercent DESC;
-- Again not too many insights can be derived from this output

SELECT 
	CASE 
		WHEN DiscountPercent BETWEEN 0 AND 10 THEN '0-10'
		WHEN DiscountPercent BETWEEN 10 AND 20 THEN '10-20'
        WHEN DiscountPercent BETWEEN 20 AND 30 THEN '20-30'
        WHEN DiscountPercent BETWEEN 30 AND 40 THEN '30-40'
        WHEN DiscountPercent BETWEEN 40 AND 50 THEN '40-50'
        ELSE '50+'
	END AS DiscountRange, 
    SUM(TransactionAmount) AS TotalSalesInRange
FROM salesdata
GROUP BY DiscountRange
ORDER BY DiscountRange DESC;
/*
DiscountRange	TotalSalesInRange
40-50			2,023,000,553.23
30-40			2,053,653,716.92
20-30			2,041,329,345.10
10-20			2,048,195,407.31
0-10			2,036,483,937.63

From here, it can be deduced that the discount range that earned the most revenue is 30-40% and least is 40-50% 
*/

-- Promotional Impact
SELECT IsPromotional, COUNT(IsPromotional) AS TotalTransaction, SUM(TransactionAmount) AS Revenue, ROUND(SUM(TransactionAmount)/COUNT(IsPromotional), 2) AS AverageTransactionAmount
FROM salesdata
GROUP BY IsPromotional;

/*
IsPromotional	TotalTransaction	Revenue				AverageTransactionAmount
No				250,685				5,103,816,281.93	20,359.48
Yes				249,315				5,098,846,678.26	20,451.42
*/

-- Sales by Month
SELECT 
    DATE_FORMAT(TransactionDate, '%m') AS Month,
    SUM(TransactionAmount) AS TotalTransactionAmount,
    COUNT(TransactionAmount) AS TotalTransactions,
    ROUND(SUM(TransactionAmount)/COUNT(TransactionAmount), 2) AS AverageTransaction
FROM salesdata
GROUP BY Month
ORDER BY TotalTransactionAmount DESC;

SELECT MAX(TransactionDate) FROM salesdata;