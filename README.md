# incubyte
The dataset is too large to be imported into the DB directly. There are errors while importing due to multiple NULL values and the datetime format is not suitable MySQL Workbench.

Data Formatting:
1) Splitting the data into 5 segments of equal number of records.
2) Substituting the empty cells for "NULL" for MySQL to treat them as NULL values.
3) Formating the datetime to '%Y-%m-%d %H:%M:%S'

Importing Data: The dataset now split into 5 parts is imported using "LOAD DATA LOCAL INFILE". After each load, check no. of records in the table using "SELECT COUNT(1)"

The NULL vales are as follows: TransactionID, TransactionAmount, Quantity, DiscountPercent, City, LoyaltyPoints, Returned, FeedbackScore, ShippingCost, DeliveryTimeDays, and IsPromotional columns have no NULL values. The following columns have multiple NULL values as shown below: 
| CustomerID | 50,000 | | TransactionDate | 50,000 | | PaymentMethod | 50,000 | | StoreType | 50,000 | | CustomerAge | 50,000 | | CustomerGender | 50,000 | | ProductName | 50,000 | | Region | 42,633 |
