-- Part 3: Transaction Date data -------------------------------------
----------------------------------------------------------------------------
-- Sales, Revenue, and Units sold every Month
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

-- customerID and TransactionDate
-- Customers with only one purchase in the year
SELECT COUNT(*) AS SingleUsesCount 
FROM (
	SELECT CustomerID, COUNT(CustomerID) 
	FROM salesdata
    WHERE CustomerID IS NOT NULL
	GROUP BY CustomerID
	HAVING COUNT(CustomerID) <= 12
    ) AS t;
-- There were 42 customers that only baught one item in the whole year

-- Total customers with more than one transaction per month.
SELECT COUNT(*) AS One_item_per_month
FROM (
	SELECT CustomerID, COUNT(CustomerID) 
	FROM salesdata
    WHERE CustomerID IS NOT NULL
	GROUP BY CustomerID
	HAVING COUNT(CustomerID) >12
    ) AS t;
-- There were 6695 customers who baught more than 12 items in the year or on an average more than 1 item per month.

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
WHERE DaysBetweenPurchases = 0;
-- There are 649 customers that had multiple transactions on their first use.
-- Similarly there are 21,816 customers that had transactions with more than a month (30 days) apart, and 4,406 custoemrs had transactions more than 3 months (90 dyas) apart.
-- Dedicated campaigns can be arranged for such customers to drive sales.

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
)SELECT * FROM DayDiff
ORDER BY DaysBetweenPurchases DESC;

-- Total sales by products sold
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
    COUNT(*) AS TotalSales,
    SUM(Quantity) AS TotalItemsSold
FROM salesdata
WHERE TransactionDate IS NOT NULL
GROUP BY TransMonth
ORDER BY TotalItemsSold DESC;

