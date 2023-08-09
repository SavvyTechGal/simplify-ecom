INSERT INTO Business (Name, URL)
SELECT DISTINCT rt.Business_Name, rt.Business_URL
FROM raw_table rt
LEFT JOIN Business b ON rt.Business_Name = b.Name AND rt.Business_URL = b.URL
WHERE b.Business_ID IS NULL;


-- This allows to insert only new businesses not already in the database from the raw_table

INSERT INTO Subscription_Type (Name, Order_Max, Monthly_Price, Yearly_Price)
SELECT DISTINCT rt.Subscription_Name, rt.Subscription_Order_Max, rt.Subscription_Monthly_Price, rt.Subscription_Yearly_Price
FROM raw_table rt
LEFT JOIN Subscription_Type st ON rt.Subscription_Name = st.Name
WHERE st.Subscription_Type_ID IS NULL;




INSERT INTO Subscription (Business_ID, Subscription_Type_ID, Start_Date, End_Date, Updated_At)
SELECT
    b.Business_ID,
    st.Subscription_Type_ID,
    rt.Business_Sub_Start_Date,
    rt.Business_Sub_End_Date,
    CURRENT_TIMESTAMP
FROM
    raw_table rt
LEFT JOIN Business b ON rt.Business_Name = b.Name
LEFT JOIN Subscription_Type st ON rt.Subscription_Name = st.Name
WHERE NOT EXISTS (
    SELECT 1
    FROM Subscription s
    WHERE s.Business_ID = b.Business_ID
    AND s.Subscription_Type_ID = st.Subscription_Type_ID
    AND s.Start_Date = rt.Business_Sub_Start_Date
    AND s.End_Date = rt.Business_Sub_End_Date
);










INSERT INTO Business_Product (Business_ID, Title, Sku, Amount, Cost, Description)
SELECT 
    b.Business_ID,
    raw.Product_Title,
    raw.Product_Sku,
    raw.Product_Amount,
    raw.Product_Cost,
    raw.Product_Description
FROM
    raw_table raw
Left JOIN Business b ON raw.Business_Name = b.Name;


































