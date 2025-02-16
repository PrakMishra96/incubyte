# incubyte
The dataset is too large to be imported into the DB directly. There are errors while importing due to multiple NULL values and the datetime format is not suitable MySQL Workbench.

Data Formatting:
1) Splitting the data into 5 segments of equal number of records.
2) Substituting the empty cells for "NULL" for MySQL to treat them as NULL values.
3) Formating the datetime to '%Y-%m-%d %H:%M:%S'

Importing Data: The dataset now split into 5 parts is imported using "LOAD DATA LOCAL INFILE". After each load, check no. of records in the table using "SELECT COUNT(1)"

The NULL vales are as follows: TransactionID, TransactionAmount, Quantity, DiscountPercent, City, LoyaltyPoints, Returned, FeedbackScore, ShippingCost, DeliveryTimeDays, and IsPromotional columns have no NULL values. The following columns have multiple NULL values as shown below: 

| CustomerID       | 50,000 | 

| TransactionDate  | 50,000 | 

| PaymentMethod    | 50,000 |

| StoreType        | 50,000 | 

| CustomerAge      | 50,000 | 

| CustomerGender   | 50,000 | 

| ProductName      | 50,000 | 

| Region           | 42,633 |

Part 1: Analysing TransactionDate

a)Sales, Revenue, and Units sold every Month - 

TransMonth	TotalSales	TotalRevenue	  AverageRevenue	UnitsSold

	Jan	40098	       814518652.58	      20313.20		300531
 
	Feb	36208        744181785.06	      20552.97		272934
 
	March	40247        818874213.27	      20346.22		303822
 
	April	38941        801872066.80	      20591.97		290314
 
	May	40196        819562671.77	      20389.16		301294
 
	June	38785        790468924.13	      20380.79		293485
 
	July	40199        817029612.91	      20324.63		299704
 
	August	40267        822157143.34	      20417.64		298672
 
	Sept	38906        791350039.70	      20340.05		291839
 
	Oct	40202        815402571.54	      20282.64		302980
 
	Nov	38831        799945427.92	      20600.69		290306
 
	Dec	17120        342380997.76	      19998.89		127943
-- The month that saw the most products sold is August (40,267 items sold), August also had the top overall revenue of  822,157,143.34. 
-- But the highest Average Revenue was in November. And most items were sold in March.

b.Customers with only one purchase in the year - 42 customers that only bought one item in the whole year

c.No of Customers with multiple same-day transactions
-- 649 customers that had multiple transactions on their first use.
-- Similarly, 26,564 customers that had transactions with less than a month (30 days) apart, 
-- and 17,301 customers had transactions between 30 days and 90 days (more than a month but less than 3 months)
-- Dedicated campaigns can be arranged for such customers to drive sales.

d.Rank of each City by Totalsales For each Month
TransMonth	City	    TotalSales	CityRank
January		  Kolkata		  4159	    1
February	  Delhi		    3738	    1
March		    Chennai		  4077	    1
April		    Mumbai		  4020	    1
May			    Chennai		  4097	    1
June		    Lucknow		  3963	    1
July		    Lucknow		  4126	    1
August		  Jaipur		  4139	    1
September	  Bangalore	  3976	    1
October		  Bangalore	  4224	    1
November	  Kolkata		  3951	    1
December	  Mumbai		  1775	    1
-- Here we can see that Bangalore gave the best monthly totalsales number in October. 
