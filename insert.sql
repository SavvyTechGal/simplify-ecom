
-- This allows to insert only new businesses not already in the database from the raw_table
INSERT INTO Business (Name, URL)
SELECT DISTINCT rt.Business_Name, rt.Business_URL
FROM raw_table rt
LEFT JOIN Business b ON rt.Business_Name = b.Name AND rt.Business_URL = b.URL
WHERE b.Business_ID IS NULL;

-- INSERT INTO Subscription_Type 
-- (Name, Order_Max, Monthly_Price, Yearly_Price)
-- SELECT Subscription_Name, Subscription_Order_Max, Subscription_Monthly_Price, Subscription_Yearly_Price FROM raw_table;


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




-- INSERT INTO Address (Country, State, Zip, Line1, Line2, Updated_At)
-- SELECT DISTINCT rt.Country, rt.State, rt.Zip, rt.Line1, rt.Line2, rt.Updated_At
-- FROM raw_table rt
-- LEFT JOIN Address a ON rt.Country = a.Country
--                     AND rt.State = a.State
--                     AND rt.Zip = a.Zip
--                     AND rt.Line1 = a.Line1
--                     AND rt.Line2 = a.Line2
-- WHERE a.Address_ID IS NULL;