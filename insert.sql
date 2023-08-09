INSERT INTO Business (Name, URL)
SELECT DISTINCT rt.Business_Name, rt.Business_URL
FROM raw_table rt
LEFT JOIN Business b ON rt.Business_Name = b.Name AND rt.Business_URL = b.URL
WHERE b.Business_ID IS NULL;


INSERT INTO Subscription_Type (Name, Order_Max, Monthly_Price, Yearly_Price)
SELECT DISTINCT rt.Subscription_Name, rt.Subscription_Order_Max, rt.Subscription_Monthly_Price, rt.Subscription_Yearly_Price
FROM raw_table rt
LEFT JOIN Subscription_Type st ON rt.Subscription_Name = st.Name
WHERE st.Subscription_Type_ID IS NULL;


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