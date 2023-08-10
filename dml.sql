--BUSINESS
-- This allows to insert only new businesses not already in the database from the raw_table
INSERT INTO Business (Name, URL)
SELECT DISTINCT rt.Business_Name, rt.Business_URL
FROM raw_table rt
LEFT JOIN Business b ON rt.Business_Name = b.Name AND rt.Business_URL = b.URL
WHERE b.Business_ID IS NULL;

--SUBSCRIPTION_TYPE
-- This allows to insert only new subscription types not already in the database from the raw_table
INSERT INTO Subscription_Type (Name, Order_Max, Monthly_Price, Yearly_Price)
SELECT DISTINCT rt.Subscription_Name, rt.Subscription_Order_Max, rt.Subscription_Monthly_Price, rt.Subscription_Yearly_Price
FROM raw_table rt
LEFT JOIN Subscription_Type st ON rt.Subscription_Name = st.Name
WHERE st.Subscription_Type_ID IS NULL;


--SUBSCRIPTION
BEGIN;
-- This allows to update existing subscriptions in the database from the raw_table, it will only update the end date and updated at
UPDATE Subscription AS s
SET 
    End_Date = (
        SELECT MAX(rt.Business_Sub_End_Date)
        FROM raw_table rt
        JOIN Business b ON rt.Business_Name = b.Name AND rt.Business_URL = b.URL
        JOIN Subscription_Type st ON rt.Subscription_Name = st.Name
        WHERE s.Business_ID = b.Business_ID
            AND s.Subscription_Type_ID = st.Subscription_Type_ID
    ),
    Updated_At = CURRENT_TIMESTAMP
WHERE
    EXISTS (
        SELECT 1
        FROM raw_table rt
        JOIN Business b ON rt.Business_Name = b.Name AND rt.Business_URL = b.URL
        JOIN Subscription_Type st ON rt.Subscription_Name = st.Name
        WHERE s.Business_ID = b.Business_ID
            AND s.Subscription_Type_ID = st.Subscription_Type_ID
    );

-- This allows to insert only new subscriptions not already in the database from the raw_table
INSERT INTO Subscription (Business_ID, Subscription_Type_ID, Start_Date, End_Date, Updated_At)
SELECT
    b.Business_ID,
    st.Subscription_Type_ID,
    MIN(rt.Business_Sub_Start_Date) AS Start_Date,
    MAX(rt.Business_Sub_End_Date) AS End_Date,
    CURRENT_TIMESTAMP
FROM
    raw_table rt
JOIN Business b ON rt.Business_Name = b.Name AND rt.Business_URL = b.URL
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


--CUSTOMER PROFILE
BEGIN;
-- Update existing records in Customer_Profile
UPDATE Customer_Profile cp
SET 
    (Name, Email, Phone) = (r.Customer_Name, r.Customer_Email, r.Customer_Phone),
    Updated_At = CURRENT_TIMESTAMP
FROM raw_table r
WHERE cp.Email = r.Customer_Email;


-- Insert only new records into Customer_Profile
INSERT INTO Customer_Profile (Name, Email, Phone, Created_At, Updated_At)
SELECT DISTINCT
    r.Customer_Name,
    r.Customer_Email,
    r.Customer_Phone,
    MIN(r.Order_Creation_Date) AS Created_At,
    CURRENT_TIMESTAMP
FROM raw_table r
LEFT JOIN Customer_Profile cp ON r.Customer_Email = cp.Email
WHERE cp.Email IS NULL
GROUP BY r.Customer_Name, r.Customer_Email, r.Customer_Phone;

COMMIT;

--PRODUCT
BEGIN;

-- Update existing products
UPDATE Business_Product bp
SET
    Title = raw.Product_Title,
    Sku = raw.Product_Sku,
    Amount = raw.Product_Amount,
    Cost = raw.Product_Cost,
    Description = raw.Product_Description,
    Updated_At = CURRENT_TIMESTAMP
FROM
    raw_table raw
JOIN Business b ON raw.Business_Name = b.Name and raw.Business_URL = b.URL
WHERE
    bp.Business_ID = b.Business_ID
    AND bp.SKU = raw.PRODUCT_SKU;

-- Insert new products
INSERT INTO Business_Product (Business_ID, Title, Sku, Amount, Cost, Description, Created_At, Updated_At)
SELECT 
    b.Business_ID,
    raw.Product_Title,
    raw.Product_Sku,
    raw.Product_Amount,
    raw.Product_Cost,
    raw.Product_Description,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
FROM
    raw_table raw
JOIN Business b ON raw.Business_Name = b.Name and raw.Business_URL = b.URL
LEFT JOIN Business_Product bp ON b.Business_ID = bp.Business_ID AND raw.Product_Sku = bp.Sku
WHERE bp.Product_ID IS NULL;

COMMIT;


-- order table 
BEGIN;

INSERT INTO Business_Order (Business_ID, Customer_ID, Order_Number, Shipping_Amount_Paid, Shipping_Cost, Total_Refund, Discount_Code, Financial_Status, Created_At, Fulfilled_At, Cancelled_At)
SELECT 
    b.Business_ID,
    cp.Customer_ID,
    raw.Internal_Order_Number,
    raw.Order_Shipping_Amount_paid,
    raw.Order_Shipping_Cost,
    raw.Order_Total_Refund,
    raw.Order_Discount_Code,
    raw.Order_Financial_Status,
    raw.Order_Creation_Date,
    raw.Order_Fulfilled_Date,
    raw.Order_Cancellation_Date
FROM
    raw_table raw
JOIN Business b ON raw.Business_Name = b.Name AND raw.Business_URL = b.URL
JOIN Customer_Profile cp ON raw.Customer_Email = cp.Email 
LEFT JOIN Business_Order bo ON b.Business_ID = bo.Business_ID AND raw.Internal_Order_Number = bo.Order_Number AND cp.Customer_ID = bo.Customer_ID
WHERE bo.Order_ID IS NULL;

--Insert into Business_Order_lineitem
INSERT INTO Business_Order_lineitem(Business_ID, Gross_Revenue, Discount_Amount, Quantity, Tax, Order_ID, Product_ID)  
SELECT
    DISTINCT 
    b.Business_ID,
    rt.Lineitem_Gross_Revenue,
    rt.Lineitem_Discount_Amount,
    rt.Lineitem_Quantity,
    rt.Linetem_Tax,
    bo.Order_ID,
    bp.Product_ID
FROM
    raw_table rt
JOIN Business b ON rt.Business_Name = b.Name AND rt.Business_URL = b.URL
JOIN Business_Order bo ON rt.Internal_Order_Number = bo.Order_Number AND b.Business_ID = bo.Business_ID
JOIN Business_Product bp ON rt.Product_Sku = bp.Sku AND b.Business_ID = bp.Business_ID
WHERE NOT EXISTS (
    SELECT 1
    FROM Business_Order_lineitem bol
    WHERE bol.Business_ID = b.Business_ID
        AND bol.Order_ID = bo.Order_ID
        AND bol.Product_ID = bp.Product_ID
);


-- business_customer 
-- every time a new order is inserted, we need to insert a new record in the business_customer table if customer is not already associated with the business
INSERT INTO Business_Customer (Business_ID, Customer_ID)
SELECT DISTINCT
    b.Business_ID,
    cp.Customer_ID
FROM
    Business b
JOIN Business_Order bo ON b.Business_ID = bo.Business_ID 
JOIN Customer_Profile cp ON bo.Customer_ID = cp.Customer_ID
WHERE
    NOT EXISTS (
        SELECT 1
        FROM Business_Customer bc
        WHERE bc.Business_ID = b.Business_ID
        AND bc.Customer_ID = cp.Customer_ID
    );
COMMIT;

-- Insert distinct addresses into the Address table
INSERT INTO Address (Country, State, Zip, Line1, Line2, Created_At)
SELECT DISTINCT
    rt.Order_Billing_Country AS Country,
    rt.Order_Billing_State AS State,
    rt.Order_Billing_Zip AS Zip,
    rt.Order_Billing_Address1 AS Line1,
    rt.Order_Billing_Address2 AS Line2,
    CURRENT_TIMESTAMP
FROM raw_table rt
WHERE rt.Order_Billing_Country IS NOT NULL AND NOT EXISTS (
    SELECT 1
    FROM Address a
    WHERE a.Country = rt.Order_Billing_Country
    AND a.State = rt.Order_Billing_State
    AND a.Zip = rt.Order_Billing_Zip
    AND a.Line1 = rt.Order_Billing_Address1
    AND a.Line2 = rt.Order_Billing_Address2
)
UNION
SELECT DISTINCT
    rt.Order_Country AS Country,
    rt.Order_State AS State,
    rt.Order_Zip AS Zip,
    rt.Order_Address1 AS Line1,
    rt.Order_Address2 AS Line2,
    CURRENT_TIMESTAMP
FROM raw_table rt
WHERE NOT EXISTS (
    SELECT 1
    FROM Address a
    WHERE a.Country = rt.Order_Country
    AND a.State = rt.Order_State
    AND a.Zip = rt.Order_Zip
    AND a.Line1 = rt.Order_Address1
    AND a.Line2 = rt.Order_Address2
);




-- Insert data into Business_Order_Address using unified Address IDs
INSERT INTO Business_Order_Address (Address_ID, Type, Business_ID, Order_ID)
SELECT
    a.Address_ID,
    'Billing' AS Type,
    bo.Business_ID,
    bo.Order_ID
FROM raw_table rt
JOIN Address a ON
    a.Country = rt.Order_Billing_Country AND
    a.State = rt.Order_Billing_State AND
    a.Zip = rt.Order_Billing_Zip AND
    a.Line1 = rt.Order_Billing_Address1 AND
    a.Line2 = rt.Order_Billing_Address2
JOIN Business_Order bo ON rt.Internal_Order_Number = bo.Order_Number
WHERE NOT EXISTS (
    SELECT 1
    FROM Business_Order_Address boa
    WHERE boa.Address_ID = a.Address_ID
    AND boa.Type = 'Billing'
    AND boa.Business_ID = bo.Business_ID
    AND boa.Order_ID = bo.Order_ID
)
UNION
SELECT
    a.Address_ID,
    'Shipping' AS Type,
    bo.Business_ID,
    bo.Order_ID
FROM raw_table rt
JOIN Address a ON
    a.Country = rt.Order_Country AND
    a.State = rt.Order_State AND
    a.Zip = rt.Order_Zip AND
    a.Line1 = rt.Order_Address1 AND
    a.Line2 = rt.Order_Address2
JOIN Business_Order bo ON rt.Internal_Order_Number = bo.Order_Number
WHERE NOT EXISTS (
    SELECT 1
    FROM Business_Order_Address boa
    WHERE boa.Address_ID = a.Address_ID
    AND boa.Type = 'Shipping'
    AND boa.Business_ID = bo.Business_ID
    AND boa.Order_ID = bo.Order_ID
);























