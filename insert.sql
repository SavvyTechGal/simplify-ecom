
-- This allows to insert only new businesses not already in the database from the raw_table
INSERT INTO Business (Name, URL)
SELECT DISTINCT rt.Business_Name, rt.Business_URL
FROM raw_table rt
LEFT JOIN Business b ON rt.Business_Name = b.Name AND rt.Business_URL = b.URL
WHERE b.Business_ID IS NULL;


-- This allows to insert only new subscription types not already in the database from the raw_table
INSERT INTO Subscription_Type (Name, Order_Max, Monthly_Price, Yearly_Price)
SELECT DISTINCT rt.Subscription_Name, rt.Subscription_Order_Max, rt.Subscription_Monthly_Price, rt.Subscription_Yearly_Price
FROM raw_table rt
LEFT JOIN Subscription_Type st ON rt.Subscription_Name = st.Name
WHERE st.Subscription_Type_ID IS NULL;

BEGIN;

UPDATE Subscription AS s
SET 
    End_Date = (
        SELECT MAX(rt.Business_Sub_End_Date)
        FROM raw_table rt
        JOIN Business b ON rt.Business_Name = b.Name
        JOIN Subscription_Type st ON rt.Subscription_Name = st.Name
        WHERE s.Business_ID = b.Business_ID
            AND s.Subscription_Type_ID = st.Subscription_Type_ID
    ),
    Updated_At = CURRENT_TIMESTAMP
WHERE
    EXISTS (
        SELECT 1
        FROM raw_table rt
        JOIN Business b ON rt.Business_Name = b.Name
        JOIN Subscription_Type st ON rt.Subscription_Name = st.Name
        WHERE s.Business_ID = b.Business_ID
            AND s.Subscription_Type_ID = st.Subscription_Type_ID
    );

INSERT INTO Subscription (Business_ID, Subscription_Type_ID, Start_Date, End_Date, Updated_At)
SELECT
    b.Business_ID,
    st.Subscription_Type_ID,
    MIN(rt.Business_Sub_Start_Date) AS Start_Date,
    MAX(rt.Business_Sub_End_Date) AS End_Date,
    CURRENT_TIMESTAMP
FROM
    raw_table rt
JOIN Business b ON rt.Business_Name = b.Name
JOIN Subscription_Type st ON rt.Subscription_Name = st.Name
WHERE NOT EXISTS (
    SELECT 1
    FROM Subscription s
    WHERE s.Business_ID = b.Business_ID
        AND s.Subscription_Type_ID = st.Subscription_Type_ID
)
GROUP BY
    b.Business_ID, st.Subscription_Type_ID;

COMMIT;


BEGIN;
-- Update existing records
UPDATE Customer_Profile cp
SET 
    (Name, Email, Phone) = (r.Customer_Name, r.Customer_Email, r.Customer_Phone),
    Updated_At = CURRENT_TIMESTAMP
FROM raw_table r
WHERE cp.Email = r.Customer_Email;


-- Insert new records
INSERT INTO Customer_Profile (Name, Email, Phone, Created_At, Updated_At)
SELECT DISTINCT
    r.Customer_Name,
    r.Customer_Email,
    r.Customer_Phone,
    MIN(r.Customer_First_Order_Date) AS Created_At,
    MAX(r.Customer_Last_Order_Date) AS Updated_At
FROM raw_table r
LEFT JOIN Customer_Profile cp ON r.Customer_Email = cp.Email
WHERE cp.Email IS NULL
GROUP BY r.Customer_Name, r.Customer_Email, r.Customer_Phone;

COMMIT;



