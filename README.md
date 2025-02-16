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
	 e.Total Customers

2)a.Top 5 customers by Revenue
	b.Bottom 5 customers by Revenue
	c.Top Cities by Revune
	
3)a.Revenue by Payment method - roughly same by all methods
	b.Revenue by StoreType
	c.Revenue by CustomerAge --- use from part2
	d.Revenue by CustomerGender
	e.Revenue by Range of DiscountPercent

4)a.Top Customers by Total items baught
	b.City with most transactions and Revenue
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
