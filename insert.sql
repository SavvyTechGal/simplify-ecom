INSERT INTO Business ( Name,  URL)
SELECT Business_Name, Business_URL
FROM raw_table;

INSERT INTO Subscription_Type 
(Name, Order_Max, Monthly_Price, Yearly_Price)
SELECT Subscription_Name, Subscription_Order_Max, Subscription_Monthly_Price, Subscription_Yearly_Price FROM attribute_table;