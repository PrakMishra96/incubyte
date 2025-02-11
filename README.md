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

Part 1: Analysing TransactionAmount or Revenue
a)Total Revenue generated throughout the year (2022) was Rs 10,202,662,960.19, and the average transaction amount is Rs 20,405.
b)The top 10 customers have spent more than Rs 69,000 each, with the top customer spending Rs 800,724.49.
c)The bottom 5 customers have spent less than Rs 100, with two customers with negative amounts, this shows that they have possibly been refunded for a return. The most note-worthy point is that such customers were only 2, further analysis can be conducted to investigate the reason for this data, though this is not very alarming from a purely sales point of view. 
d)Sales by Region and City - Cities like Kolkata and Ahmedabad generated top revenues, while cities like Mumbai and Hyderabad generated the lowest revenues. This could imply low market penetration in Mumbai and Hyderabad, a potential reason could be tougher competition.
e)Sales by PaymentMethod - there was an almost equal share of each type of payment method, which means no particular method was favored by the customers.
Sales by StoreType - The customers almost equally favor both in-store and online modes.
f)The top product by revenue is "Laptop", followed by "Sofa" while the lowest revenue-generating product is "Apple"
g)CustomerAge analysis shows that the most revenue-generating age range is "46-60", all genders are almost equal in the share of revenue generated.
h)Analysing the impact of Promotions and Discounts shows that the top percentage range was "30-40" and that Promotion had little to no impact on overall or average TransactionAmount.
i)The top month by revenue was August, and the least was December (though the dataset provided only had data upto the 14th of December).


