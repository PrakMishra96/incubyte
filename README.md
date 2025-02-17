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



1) a.Total Revenue - 10,202,662,960.19

	 b.Average Transaction Amount - 20,405.32

	 c.Total Products Sold - 3,747,755

	 d.Total Sales and Revenue and Quantity by Products

-- Although the most sold product by number was 'Apple', but the most Revenue generating product was 'Laptops'
-- The promotions must be directed towards Laptops, because they generate more revenue for roughly the same number of units sold compared to sofas.

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

	c.Top Cities by Revune

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

4)a.Top Customers by Total Items bought 

-- top 5 Customers by total items bought have bought 270+ items, whereas the top customer bought 289 items over the year. However, the revenues from these customers ranges from 58,000 to 326,000 this is significantly less than found in 2)a.Top customers by revenue. 
	
 b.City with most transactions and Revenue

 -- Top city by total no of transaction is Bangalore but by revenue is Kolkata followed by Ahmedabad and in 3rd place Bangalore. Cities like Pune and Hyderabad are the bottom two.
	-- removed b.City with most customers - Hyadrabad
	c.Total customers in a loyaltyPoint range
	d.Total Customers by no. of returns
	e.Customer count by feedback
	f.Effect of Delivery delays on Feedback
	g.Effects of Promotions on customers

5)a.Sales, Revenue, and Units sold every Month
	b.Total customers with more than one transaction per month.
	c.No of Customers with multiple same day transactions
	d.Rank of each City by Totalsales For each Month
