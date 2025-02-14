-- Part 2: Analysing Customer data -------------------------------------
----------------------------------------------------------------------------
-- Customer base
SELECT COUNT(DISTINCT CustomerID) AS TotalCustomers 
FROM salesdata;
-- 48,994

-- Top Customers by Quantity of products bought 
SELECT ROW_NUMBER() OVER (ORDER BY COUNT(Quantity) DESC) AS NUM,
	CustomerID, 
	COUNT(Quantity) AS TotalItemsBaught,
    SUM(TransactionAmount) AS TotalRevenue
FROM salesdata
WHERE CustomerID IS NOT NULL
GROUP BY CustomerID
ORDER BY TotalItemsBaught DESC;

-- No of Customers and Discount
SELECT COUNT(DISTINCT CustomerID) FROM salesdata;
SELECT 
	CASE 
		WHEN DiscountPercent BETWEEN 0 AND 10 THEN '0-10'
		WHEN DiscountPercent BETWEEN 10 AND 20 THEN '10-20'
        WHEN DiscountPercent BETWEEN 20 AND 30 THEN '20-30'
        WHEN DiscountPercent BETWEEN 30 AND 40 THEN '30-40'
        WHEN DiscountPercent BETWEEN 40 AND 50 THEN '40-50'
        ELSE '50+'
	END AS DiscountRange, 
    COUNT(DISTINCT CustomerID) TotalCust,
    SUM(TransactionAmount)
FROM salesdata
GROUP BY DiscountRange
ORDER BY DiscountRange DESC;

-- Bifurcation by city
SELECT City, COUNT(DISTINCT CustomerID) AS TotalCust 
FROM salesdata
GROUP BY City
ORDER BY TotalCust;

-- Bifurcation by StoreType
SELECT StoreType, COUNT(DISTINCT CustomerID) AS TotalCust 
FROM salesdata
WHERE StoreType IS NOT NULL
GROUP BY StoreType;

-- Customer Age
SELECT MIN(CustomerAge) FROM salesdata;

SELECT CustomerID, CustomerAge 
FROM salesdata 
WHERE CustomerID IS NOT NULL 
ORDER BY CustomerID
LIMIT 10;
-- The same CustomerID has multiple CustomerAges, this inconsistency prevents any further analysis 

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
-- Consistient with the data from Sales by age


SELECT CustomerID, LoyaltyPoints FROM salesdata WHERE CustomerID IS NOT NULL ORDER BY CustomerID LIMIT 10;
-- Loyalty Points
SELECT MAX(LoyaltyPoints) FROM salesdata;
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
-- Although LoyaltyPoints fluctuate for customers, in this year most customers belonged to mid range of LoyaltyPoints.

-- Finding Customers having most returns
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
	-- HAVING TotalReturns > 12
	ORDER BY TotalReturns DESC)
SELECT COUNT(CustomerID) AS Total_customers, TotalReturns
FROM Cust_Count_Returns
GROUP BY TotalReturns;
-- There were 502 customers with no returns in the data provided. Thus it can concluded that the customers are mostly satisfied with their products.

SELECT FeedbackScore, COUNT(CustomerID) AS TotalCustomers
FROM salesdata
GROUP BY FeedbackScore
ORDER BY TotalCustomers DESC;
/*
FeedbackScore	TotalCustomers
			2	90332
			4	90149
			5	90114
			1	89853
			3	89552
-- There are many customers that have given a feedbackscore of 2, which is alarming and a deep investigation need to be conducted to find the reason.
*/


SELECT FeedbackScore, COUNT(CustomerID) AS TotalCustomers
FROM salesdata
WHERE DeliveryTimeDays > 5
GROUP BY FeedbackScore
ORDER BY TotalCustomers DESC;
/*
FeedbackScore	TotalCustomers
			4	28463
			3	28379
			2	28373
			1	28206
			5	28174
-- This supports that the low feedback is not due to long delivery days
*/


SELECT CustomerID, SUM(TransactionAmount) AS TotalSales,
	SUM(
        CASE 
            WHEN IsPromotional LIKE 'Yes%' THEN 1
            WHEN IsPromotional LIKE 'No%' THEN 0
            ELSE -1
        END) AS Promoted
FROM salesdata 
WHERE CustomerID IS NOT NULL
GROUP BY CustomerID
ORDER BY TotalSales DESC;


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
-- According to this effect of promotional decreases with increasing promotions after 6 promotions
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