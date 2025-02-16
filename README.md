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

ProductName	SalesByProduct		TotalTransactions	TotalProducts

Laptop		|6,231,220,430.24	|89,809			|   89,809

Sofa		|3,777,022,903.56	|89,740			|   89,740

T-Shirt		|  102,306,079.47	|90,187			|  270,545

NULL		|   45,733,242.94	|50,000			|  502,299

Notebook	|   24,079,586.12	|90,294			|  498,649

Apple		|   22,300,717.86	|89,970			|2,296,713

	 e.Total Customers - 48,994

2)a.Top 5 Customers by Revenue

CustomerID	TotalTransactionAmount

32460		800724.49

39732		773331.78

10494		773034.52

17752		769126.59

9502		763669.57

	b.Bottom 5 customers by Revenue

CustomerID	TotalTransactionAmount
 
35462		-664.86

39606		-598.96

45098		 22.34

32287		 64.87

46086		 67.54

	c.Top Cities by Revune
 
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

	
3)a.Revenue by Payment method - roughly the same by all methods

PaymentMethod	SalesByPaymentMethod

Cash			2,556,679,197.41

Debit Card		2,552,366,143.98

UPI			2,530,177,440.30

Credit Card		2,517,706,935.56

NULL			   45,733,242.94

	b.Revenue by StoreType
 
StoreType	RevenueByStoreType	TotalTransactions

In-Store	5,078,881,502.74	224,782

Online		5,078,048,214.51	225,218

NULL		   45,733,242.94	 50,000

	c.Revenue by CustomerAge

AgeGroup	TotalCust	TotalRevenue

18-25		33619		1422126799.06

26-35		37463		1791131581.70

36-45		37490		1780329661.52

46-60		43437		2680156973.73

60+		42476		2483184701.24

Not Mentioned	29528		  45733242.94

	d.Revenue by CustomerGender

CustomerGender		SalesByGender

Male			3397984626.42

Other			3391554647.25

Female			3367390443.58

NULL			45733242.94

	e.Revenue by Range of DiscountPercent

DiscountRange		TotalSalesInRange

40-50			2,023,000,553.23

30-40			2,053,653,716.92

20-30			2,041,329,345.10

10-20			2,048,195,407.31

0-10			2,036,483,937.63


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
