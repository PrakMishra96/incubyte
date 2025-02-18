# incubyte
The dataset is too large to be imported into the DB directly. There are errors while importing due to multiple NULL values and the DateTime format is not suitable for MySQL Workbench.

Data Formatting:
1) Splitting the data into 5 segments of equal number of records.
2) Substituting the empty cells for "NULL" for MySQL to treat them as NULL values.
3) Formating the DateTime to '%Y-%m-%d %H:%M:%S'

Importing Data: The dataset now split into 5 parts is imported using "LOAD DATA LOCAL INFILE". After each load, check no. of records in the table using "SELECT COUNT(1)"

The NULL values are as follows: TransactionID, TransactionAmount, Quantity, DiscountPercent, City, LoyaltyPoints, Returned, FeedbackScore, ShippingCost, DeliveryTimeDays, and IsPromotional columns have no NULL values. The following columns have multiple NULL values as shown below: 

| CustomerID       | 50,000 | 

| TransactionDate  | 50,000 | 

| PaymentMethod    | 50,000 |

| StoreType        | 50,000 | 

| CustomerAge      | 50,000 | 

| CustomerGender   | 50,000 | 

| ProductName      | 50,000 | 

| Region           | 42,633 |



1) a.Total Revenue - 10,202,662,960.19

	 b.Average Transaction Amount - 20,405.32

	 c.Total Products Sold - 3,747,755

	 d.Total Sales and Revenue and Quantity by Products

-- Although the most sold product by number was 'Apple', the most Revenue generating product was 'Laptop' and 'Sofa'
-- The promotions must be directed towards laptops because they generate more revenue for roughly the same number of units sold as sofas.

	e.Total Customers - 48,994

2)a.Top 5 Customers by Revenue

CustomerID	|TotalTransactionAmount

32460		|800724.49

39732		|773331.78

10494		|773034.52

17752		|769126.59

9502		|763669.57

	b.Bottom 5 customers by Revenue

CustomerID	TotalTransactionAmount
 
35462		|-664.86

39606		|-598.96

45098		| 22.34

32287		| 64.87

46086		| 67.54

	c.Total Customers with Spend less Rs 208000

 -- Total of 30063 customers spent less than Rs 208,000
 
 	d.Top Cities by Revune

 Cities like Kolkata and Ahmedabad generate the top revenue and the least in cities like Mumbai and Hyadrabad. 

3)a.Revenue by Payment method - roughly the same by all methods

-- All payments bring in roughly the same revenue, and the order of most to least revenue-generating method is Cash, Debit Card, UPI, Credit Card. 

-- The no of transaction is also roughly same, but the order of most to least no of transactions is: Debit Card, Cash, UPI, Credit Card.


	b.Revenue by StoreType
-- Instore purchases exceed online purchases both in total revenue and number of transactions
 
	c.Revenue by CustomerAge

-- Highest paying customers belong to the 46-60 age range, followed by 60+ and 36-45 age ranges. 

	d.Revenue by CustomerGender
 
-- Males and others spent the most, whereas females were the lowest spending customer type.

	e.Revenue by Range of DiscountPercent

-- The discount range that earned the most revenue is 30-40% and the least revenue-generating range is 40-50%

4)a.Top Customers by Total Items Bought 

-- top 5 Customers by total items bought have bought 270+ items, whereas the top customer bought 289 items over the year. However, the revenues from these customers ranges from 58,000 to 326,000 this is significantly less than found in 2)a.Top customers by revenue. 
	
 b.City with the most transactions and Revenue

 -- The top city by total no of transactions is Bangalore but by revenue is Kolkata followed by Ahmedabad and in 3rd place Bangalore. Cities like Pune and Hyderabad are the bottom two.
	
 c.Total customers in a loyalty point range

 -- Although LoyaltyPoints fluctuate for customers, this year most customers belonged to the mid-range of LoyaltyPoints.

d.Total Customers by no. of returns

-- There were more than 35 customers with more than 12 returns throughout the year.

-- There were 502 customers with no returns in the data provided. Thus it can concluded that the customers are mostly satisfied with their products.

	e.Customer count by feedback

 -- Many customers (total of 90,332) have given a feedback score of 2, which is alarming and a deep investigation needs to be conducted to find the reason.

	f.Effect of Delivery Delays on Feedback (more than 5 days)

FeedbackScore	TotalCustomers

	4	28463
 
	3	28379
 
	2	28373
 
	1	28206
 
	5	28174
 
 -- This supports that the low feedback is not due to long delivery days
 
g.Effects of Promotions on customers

-- The effect of promotions decreases with increasing number of promotions after 5 promotions

5)a.Sales, Revenue, and Units sold every Month

-- Highest total sales of 40,267 was in August, the highest Revenue of Rs 822,157,143.34 also in August, however, the highest Average Revenue of Rs 20,600.69 was in November.

-- The highest no of products sold was in March, total of 303,822 units of different products was sold.

b.Total customers with more than one transaction per month.

-- 6695 customers bought more than 12 items in the year or on average more than 1 item per month.

c.No of Customers with multiple same-day transactions

-- 649 customers had multiple transactions on their first use.

-- Similarly 26,564 customers had transactions less than a month (30 days) apart, 

-- and 17,301 customers had transactions between 30 days and 90 days (more than a month but less than 3 months)

-- Dedicated campaigns can be arranged for such customers to drive sales.

d.Rank of each City by Totalsales For each Month

TransMonth	City		TotalSales	CityRank

January		Kolkata		4159		1

February	Delhi		3738		1

March		Chennai		4077		1

April		Mumbai		4020		1

May		Chennai		4097		1

June		Lucknow		3963		1

July		Lucknow		4126		1

August		Jaipur		4139		1

September	Bangalore	3976		1

October		Bangalore	4224		1

November	Kolkata		3951		1

December	Mumbai		1775		1

-- Kolkata, Chennai, Mumbai, Lucknow, and Bangalore came top of month in Total Sales. 
