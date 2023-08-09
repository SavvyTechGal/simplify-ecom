-- INSERT INTO Business ( Name,  URL)
-- SELECT Business_Name, Business_URL
-- FROM raw_table;


INSERT INTO Subscription_Type 
(Name, Order_Max, Monthly_Price, Yearly_Price)
SELECT Subscription_Name, Subscription_Order_Max, Subscription_Monthly_Price, Subscription_Yearly_Price FROM raw_table;



-- INSERT INTO Subscription (Business_ID, Subscription_Type_ID, Start_Date, End_Date)
-- SELECT
--     b.Business_ID,
--     st.Subscription_Type_ID,
--     raw.Subscription_Start_Date,
--     raw.Subscription_End_Date
-- FROM
--     raw_table raw
--     JOIN Business b ON raw.Business_Name = b.Name
--     JOIN Subscription_Type st ON raw.Subscription_Name = st.Name;