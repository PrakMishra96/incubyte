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

/* 
 1) a.Total Revenue,
	b.Average Transaction Amount 
	c.Total Products Sold 
	d.Total Sales and Revenue and Quantity by Products
    e.Total Customers
*/

-- 1) a.Total Revenue
SELECT SUM(TransactionAmount) AS TotalRevenue
FROM salesdata;
-- Total revenue amounted to Rs 10,202,662,960.19

-- 1) b.Average Transaction Amount 
SELECT AVG(TransactionAmount) AS AvgTransactionAmount
FROM salesdata;
-- 20,405.32

-- 1) c.Total Products Sold
SELECT SUM(Quantity) AS TotalProductsSold
FROM salesdata;
-- Total number of products sold over the year is 3,747,755

-- 1) d.Total Sales and Revenue and Quantity by Products
SELECT ProductName, 
	SUM(TransactionAmount) AS RevenueByProduct, 
	COUNT(*) AS TotalTransaction, 
    SUM(Quantity) AS TotalProducts
FROM salesdata
GROUP BY ProductName
ORDER BY RevenueByProduct DESC;
-- Althou the most sold product by number was 'Apple', the most Revenue generating product was Laptops. 
-- The promotions needs to be directed towards Laptops, because they generate more revenue for roughly the same no of units sold as compared to sofas.

/*
ProductName	SalesByProduct		TotalTransactions	TotalProducts
Laptop		6,231,220,430.24	89,809				   89,809
Sofa		3,777,022,903.56	89,740				   89,740
T-Shirt		  102,306,079.47	90,187				  270,545
NULL		   45,733,242.94	50,000				  502,299
Notebook	   24,079,586.12	90,294				  498,649
Apple		   22,300,717.86	89,970				2,296,713
*/

-- 1) e.Total Customers
SELECT COUNT(DISTINCT CustomerID) AS TotalCustomers 
FROM salesdata;
-- 48,994

/*
 2) a.Top 5 customers by Revenue
	b.Bottom 5 customers by Revenue
	c.Top Cities by Revune
*/

-- 2) a.Top 5 customers by Revenue
SELECT CustomerID, SUM(TransactionAmount) as TotalTransactionAmount
FROM salesdata
WHERE CustomerID IS NOT NULL
GROUP BY CustomerID
ORDER BY TotalTransactionAmount DESC
LIMIT 5;

/* The top 10 customers by total overall sales is as:
CustomerID	TotalTransactionAmount
32460		800724.49
39732		773331.78
10494		773034.52
17752		769126.59
9502		763669.57
*/

-- 2) b.Bottom 5 customers by Revenue
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

-- 2) c.Top Cities by Revune
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

/*
 3) a.Revenue by Payment method
	b.Revenue by StoreType
	c.Revenue by CustomerAge
	d.Revenue by CustomerGender
	e.Revenue by Range of DiscountPercent
*/

-- 3) a.Revenue by Payment method
SELECT PaymentMethod, SUM(TransactionAmount) AS RevenueByPaymentMethod
FROM salesdata
GROUP BY PaymentMethod
ORDER BY RevenueByPaymentMethod DESC;

/*
PaymentMethod	SalesByPaymentMethod
Cash			2,556,679,197.41
Debit Card		2,552,366,143.98
UPI				2,530,177,440.30
Credit Card		2,517,706,935.56
NULL			   45,733,242.94
*/

-- 3) b.Revenue by StoreType
SELECT StoreType, SUM(TransactionAmount) AS RevenueByStoreType, COUNT(*) AS TotalTransactions
FROM salesdata
GROUP BY StoreType
ORDER BY RevenueByStoreType DESC;

/*
StoreType	RevenueByStoreType	TotalTransactions
In-Store	5,078,881,502.74	224,782
Online		5,078,048,214.51	225,218
NULL		   45,733,242.94	 50,000
*/

-- 3) c.Revenue by CustomerAge
SELECT 
	CASE 
        WHEN CustomerAge BETWEEN 18 AND 25 THEN '18-25'
        WHEN CustomerAge BETWEEN 26 AND 35 THEN '26-35'
        WHEN CustomerAge BETWEEN 36 AND 45 THEN '36-45'
        WHEN CustomerAge BETWEEN 46 AND 60 THEN '46-60'
        WHEN CustomerAge BETWEEN 60 AND 150 THEN'60+'
        ELSE 'Age Not Mentioned'
    END AS AgeGroup,
    COUNT(DISTINCT CustomerID) AS TotalCust,
    SUM(TransactionAmount) AS TotalRevenue
FROM salesdata
GROUP BY AgeGroup;

/*
AgeGroup		TotalCust	TotalRevenue
	18-25		33619		1422126799.06
	26-35		37463		1791131581.70
	36-45		37490		1780329661.52
	46-60		43437		2680156973.73
	60+			42476		2483184701.24
Not Mentioned	29528		  45733242.94
*/

-- 3) d.Revenue by CustomerGender
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

-- 3) e.Revenue by Range of DiscountPercent
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

/*
 4) a.Top Customers by Total items baught
	b.City with most Transactions and Revenue
	c.Total customers in a loyaltyPoint range
	d.Total Customers by no. of returns
	e.Feedback count
	f.Effect of Delivery delays on Feedback
	g.Effects of Promotions on customers -- part2
*/

-- 4) a.Top Customers by Total items baught
SELECT ROW_NUMBER() OVER (ORDER BY COUNT(Quantity) DESC) AS NUM,
	CustomerID, 
	COUNT(Quantity) AS TotalItemsBaught,
    SUM(TransactionAmount) AS TotalRevenue
FROM salesdata
WHERE CustomerID IS NOT NULL
GROUP BY CustomerID
ORDER BY TotalItemsBaught DESC
LIMIT 5;
/*
NUM	CustomerID	TotalItemsBaught	TotalRevenue
1		35173			24			334919.38
2		39402			24			558436.27
3		 3353			23			258066.84
4		 5617			23			384885.64
5		24925			22			336947.79
*/

-- 4) b.City with most Transactions and Revenue
SELECT City, COUNT(0) AS TotalTransactions, SUM(TransactionAmount) AS Revenue
FROM salesdata
GROUP BY City
ORDER BY TotalTransactions DESC;
/*
City		TotalTransactions	Revenue
Bangalore		50319			1022379945.89
Delhi			50215			1021352525.15
Lucknow			50190			1021207908.00
Kolkata			50141			1027325507.51
Ahmedabad		50008			1023675900.25
Mumbai			49953			1018525530.92
Jaipur			49900			1015044077.82
Chennai			49783			1022122710.60
Pune			49764			1022136461.28
Hyderabad		49727			1008892392.77
*/
-- Top city by total no of transaction is Bangalore but by revenue is Kolkata followed by Ahmedabad and in 3rd place Bangalore.

-- 4) c.Total customers in a loyaltyPoint range
SELECT COUNT(LoyaltyPoints) FROM salesdata WHERE LoyaltyPoints IS NOT NULL;
SELECT 
	CASE
		WHEN LoyaltyPoints BETWEEN 0 AND 999 THEN '0-999'
        WHEN LoyaltyPoints BETWEEN 1000 AND 1999 THEN '1000-1999'
        WHEN LoyaltyPoints BETWEEN 2000 AND 2999 THEN '2000-2999'
        WHEN LoyaltyPoints BETWEEN 3000 AND 3999 THEN '3000-3999'
        WHEN LoyaltyPoints BETWEEN 4000 AND 4999 THEN '4000-4999'
        WHEN LoyaltyPoints BETWEEN 5000 AND 5999 THEN '5000-5999'
        WHEN LoyaltyPoints BETWEEN 6000 AND 6999 THEN '6000-6999'
        WHEN LoyaltyPoints BETWEEN 7000 AND 7999 THEN '7000-7999'
        WHEN LoyaltyPoints BETWEEN 8000 AND 8999 THEN '8000-8999'
        WHEN LoyaltyPoints BETWEEN 9000 AND 9999 THEN '9000-999'
        ELSE 'NotKnown'
	END AS LoyaltyPointRange,
    COUNT(CustomerID) AS TotalCustomers
FROM salesdata
GROUP BY LoyaltyPointRange
ORDER BY TotalCustomers DESC;
/*
LoyaltyPointRange	TotalCustomers
		5000-5999	45251
		4000-4999	45249
		6000-6999	45212
		1000-1999	45031
		7000-7999	45017
		9000-999	44947
		3000-3999	44915
			0-999	44878
		8000-8999	44811
		2000-2999	44689
*/
-- Although LoyaltyPoints fluctuate for customers, in this year most customers belonged to mid range of LoyaltyPoints.

-- 4) d.Total Customers by no. of returns
-- Finding Customers having more than 12 returns
SELECT CustomerID, 
	SUM(
		CASE 
			WHEN Returned = 'Yes' THEN 1
			WHEN Returned = 'No' THEN 0
			ELSE -1
		END) AS TotalReturns
FROM salesdata
WHERE CustomerID IS NOT NULL
GROUP BY CustomerID
 HAVING TotalReturns > 12
ORDER BY TotalReturns DESC;
-- There were more than 35 customers with more than 12 return throughout the year. 

-- List of No of custoemrs against no of returns
WITH Cust_Count_Returns AS
	(SELECT CustomerID, 
		SUM(
			CASE 
				WHEN Returned = 'Yes' THEN 1
				WHEN Returned = 'No' THEN 0
				ELSE -1
			END) AS TotalReturns
	FROM salesdata
	WHERE CustomerID IS NOT NULL
	GROUP BY CustomerID
)SELECT COUNT(CustomerID) AS Total_customers, TotalReturns
FROM Cust_Count_Returns
GROUP BY TotalReturns
ORDER BY TotalReturns DESC;
/*
Total_Customers	TotalReturns
		   9		14
		  22		13
		  96		12
		 231		11
		 542		10
		1210		 9
		2387		 8
		4237		 7
		6569		 6
		8399		 5
		9247		 4
		7966		 3
		5294		 2
		2279		 1
		 502		 0
*/
-- There were 502 customers with no returns in the data provided. Thus it can concluded that the customers are mostly satisfied with their products.

-- 4) e.Feedback count
SELECT FeedbackScore, COUNT(CustomerID) AS FeedbackCount
FROM salesdata
GROUP BY FeedbackScore
ORDER BY FeedbackCount DESC;
/*
FeedbackScore	FeedbackCount
			2	90332
			4	90149
			5	90114
			1	89853
			3	89552
-- There are many customers that have given a feedbackscore of 2, which is alarming and a deep investigation need to be conducted to find the reason.
*/

-- 4) f.Effect of Delivery delays on Feedback
SELECT FeedbackScore, COUNT(CustomerID) AS FeedbackCount
FROM salesdata
WHERE DeliveryTimeDays > 5
GROUP BY FeedbackScore
ORDER BY FeedbackCount DESC;
/*
FeedbackScore	TotalCustomers
			4	28463
			3	28379
			2	28373
			1	28206
			5	28174
-- This supports that the low feedback is not due to long delivery days
*/

-- 4) g.Effect of Promotions Customers
WITH PromotionalRev AS
	(SELECT CustomerID, SUM(TransactionAmount) AS TotalRevenue,
		SUM(
			CASE 
				WHEN IsPromotional LIKE 'Yes%' THEN 1
				WHEN IsPromotional LIKE 'No%' THEN 0
				ELSE -1
			END) AS Promoted
	FROM salesdata 
	WHERE CustomerID IS NOT NULL
	GROUP BY CustomerID
	ORDER BY TotalRevenue DESC
)SELECT COUNT(CustomerID) AS TotalCustomers, SUM(TotalRevenue) AS Revenue, Promoted
FROM PromotionalRev 
GROUP BY Promoted
Order BY Promoted DESC;
-- According to this effect of promotional decreases with increasing promotions after 5 promotions
/*
TotalCustomers	Revenue			Promoted
		3		1269022.72		15
		8		3477495.45		14
		32		12182446.61		13
		83		27404039.05		12
		214		65586339.32		11
		543		163276733.61	10
		1205	337755575.27	9
		2406	618969199.90	8
		4225	993499063.03	7
		6448	1385668106.64	6
		8488	1669680272.77	5
		9258	1626308221.19	4
		8178	1273807038.35	3
		5180	699743130.34	2
		2205	246552647.99	1
		518		52564774.54		0
*/

/*
 5) a.Sales, Revenue, and Units sold every Month
	b.Total customers with more than one transaction per month.
	c.No of Customers with multiple same day transactions

*/

-- 5) a.Sales, Revenue, and Units sold every Month
SELECT 
	CASE
    WHEN MONTH(TransactionDate) = 1 THEN 'Jan'
    WHEN MONTH(TransactionDate) = 2 THEN 'Feb'
    WHEN MONTH(TransactionDate) = 3 THEN 'March'
    WHEN MONTH(TransactionDate) = 4 THEN 'April'
    WHEN MONTH(TransactionDate) = 5 THEN 'May'
    WHEN MONTH(TransactionDate) = 6 THEN 'June'
    WHEN MONTH(TransactionDate) = 7 THEN 'July'
    WHEN MONTH(TransactionDate) = 8 THEN 'August'
    WHEN MONTH(TransactionDate) = 9 THEN 'Sept'
    WHEN MONTH(TransactionDate) = 10 THEN 'Oct'
    WHEN MONTH(TransactionDate) = 11 THEN 'Nov'
    WHEN MONTH(TransactionDate) = 12 THEN 'Dec'
    END AS TransMonth,
    COUNT(TransactionID) AS TotalSales,
    SUM(TransactionAmount) AS TotalRevenue,
    ROUND(SUM(TransactionAmount)/COUNT(TransactionID), 2) AS AverageRevenue, 
    SUM(Quantity) AS UnitsSold
FROM salesdata
WHERE TransactionDate IS NOT NULL
GROUP BY TransMonth;
-- ORDER BY UnitsSold DESC;
/*
TransMonth	TotalSales	TotalRevenue	AverageRevenue	UnitsSold
	Jan			40098	814518652.58	20313.20		300531
	Feb			36208	744181785.06	20552.97		272934
	March		40247	818874213.27	20346.22		303822
	April		38941	801872066.80	20591.97		290314
	May			40196	819562671.77	20389.16		301294
	June		38785	790468924.13	20380.79		293485
	July		40199	817029612.91	20324.63		299704
	August		40267	822157143.34	20417.64		298672
	Sept		38906	791350039.70	20340.05		291839
	Oct			40202	815402571.54	20282.64		302980
	Nov			38831	799945427.92	20600.69		290306
	Dec			17120	342380997.76	19998.89		127943
*/
-- The month that saw the most products sold is August (40,267 items sold), August also had the top overall revenue of  822,157,143.34. 
-- But for the highest Average Revenue was in the month of November. And most items were sold in March.

-- 5) b.Customers with only one purchase in the year
SELECT COUNT(*) AS SingleUsesCount 
FROM (
	SELECT CustomerID, COUNT(CustomerID) 
	FROM salesdata
    WHERE CustomerID IS NOT NULL
	GROUP BY CustomerID
	HAVING COUNT(CustomerID) <= 1
    ) AS t;
-- There were 42 customers that only baught one item in the whole year

-- 5) b.Total customers with more than one transaction per month.
SELECT COUNT(*) AS One_item_per_month
FROM (
	SELECT CustomerID, COUNT(CustomerID) 
	FROM salesdata
    WHERE CustomerID IS NOT NULL
	GROUP BY CustomerID
	HAVING COUNT(CustomerID) >12
    ) AS t;
-- There were 6695 customers who baught more than 12 items in the year or on an average more than 1 item per month.

-- 5) c.No of Customers with multiple same day transactions
WITH DayDiff AS
	(SELECT 
		CustomerID,
		MIN(CASE WHEN TransactionRank = 1 THEN TransactionDate END) AS FirstPurchaseDate,
		MIN(CASE WHEN TransactionRank = 2 THEN TransactionDate END) AS SecondPurchaseDate,
		DATEDIFF(
			MIN(CASE WHEN TransactionRank = 2 THEN TransactionDate END),
			MIN(CASE WHEN TransactionRank = 1 THEN TransactionDate END)
		) AS DaysBetweenPurchases
	FROM (
		SELECT 
			CustomerID,
			TransactionDate,
			ROW_NUMBER() OVER (PARTITION BY CustomerID ORDER BY TransactionDate) AS TransactionRank
		FROM salesdata
		WHERE TransactionDate IS NOT NULL
	) RankedTransactions
	-- WHERE DaysBetweenPurchases = 0
	GROUP BY CustomerID
)SELECT COUNT(*) CustCount FROM DayDiff
-- WHERE DaysBetweenPurchases = 0;
-- WHERE DaysBetweenPurchases < 30;
WHERE DaysBetweenPurchases < 90 AND DaysBetweenPurchases > 30;
-- There are 649 customers that had multiple transactions on their first use.
-- Similarly there are 26,564 customers that had transactions with less than a month (30 days) apart, 
-- and 17,301 custoemrs had transactions between 30 days and 90 days (more than a month but less than 3 months)
-- Dedicated campaigns can be arranged for such customers to drive sales.

-- 50 d.Rank of each City by Totalsales For each Month
WITH MonthlySales AS (
    SELECT MONTH(TransactionDate) AS TransMonth, 
        City, 
        COUNT(*) AS TotalSales
    FROM salesdata
    WHERE TransactionDate IS NOT NULL
    GROUP BY TransMonth, City
),
RankedSales AS
	(SELECT TransMonth, 
		City, 
		TotalSales,
		RANK() OVER (PARTITION BY TransMonth ORDER BY TotalSales DESC) AS CityRank
	FROM MonthlySales
	ORDER BY TransMonth, CityRank
)SELECT
	CASE 
		WHEN TransMonth = 1 THEN 'January'
        WHEN TransMonth = 2 THEN 'February'
        WHEN TransMonth = 3 THEN 'March'
        WHEN TransMonth = 4 THEN 'April'
        WHEN TransMonth = 5 THEN 'May'
        WHEN TransMonth = 6 THEN 'June'
        WHEN TransMonth = 7 THEN 'July'
        WHEN TransMonth = 8 THEN 'August'
        WHEN TransMonth = 9 THEN 'September'
        WHEN TransMonth = 10 THEN 'October'
        WHEN TransMonth = 11 THEN 'November'
        WHEN TransMonth = 12 THEN 'December'
	END AS TransMonth, 
    City, TotalSales, CityRank
FROM RankedSales 
WHERE CityRank <=1;

/*
TransMonth	City	TotalSales	CityRank
January		Kolkata		4159	1
February	Delhi		3738	1
March		Chennai		4077	1
April		Mumbai		4020	1
May		Chennai		4097	1
June		Lucknow		3963	1
July		Lucknow		4126	1
August		Jaipur		4139	1
September	Bangalore	3976	1
October		Bangalore	4224	1
November	Kolkata		3951	1
December	Mumbai		1775	1
*/
