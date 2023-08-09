CREATE TABLE raw_table (
    Business_Name VARCHAR(32),
    Business_URL VARCHAR(64),
    Business_Avg_Monthly_Sales DOUBLE PRECISION,
    Business_Avg_Net_Revenue DOUBLE PRECISION,
    Business_Sub_Start_Date TIMESTAMP,
    Business_Sub_End_Date TIMESTAMP,
    Subscription_Name VARCHAR(32),
    Subscription_Order_Max INT,
    Subscription_Monthly_Price INT,
    Subscription_Yearly_Price INT,
    Order_Total DOUBLE PRECISION,
    Order_Subtotal DOUBLE PRECISION,
    Order_Tax DOUBLE PRECISION,
    Order_Shipping_Amount_paid DOUBLE PRECISION,
    Order_Shipping_Cost DOUBLE PRECISION,
    Order_Product_Cost DOUBLE PRECISION,
    Order_Total_Refund DOUBLE PRECISION,
    Order_Creation_Date TIMESTAMP,
    Order_Fulfilled_Date TIMESTAMP,
    Order_Cancellation_Date TIMESTAMP,
    Order_Financial_Status VARCHAR(16),
    Order_Discount_Amount DOUBLE PRECISION,
    Order_Discount_Code VARCHAR(16),
    Order_Country VARCHAR(3),
    Order_State VARCHAR(64),
    Order_Zip VARCHAR(16),
    Order_Address1 VARCHAR(64),
    Order_Address2 VARCHAR(64),
    Order_Billing_Country VARCHAR(3),
    Order_Billing_State VARCHAR(16),
    Order_Billing_Zip VARCHAR(16),
    Order_Billing_Address1 VARCHAR(64),
    Order_Billing_Address2 VARCHAR(64),
    Lineitem_Title VARCHAR(32),
    Lineitem_Sku VARCHAR(16),
    Lineitem_Gross_Revenue DOUBLE PRECISION,
    Lineitem_Net_Revenue DOUBLE PRECISION,
    Lineitem_Discount_Amount DOUBLE PRECISION,
    Lineitem_Quantity INT,
    Linetem_Tax DOUBLE PRECISION,
    Lineitem_Cost DOUBLE PRECISION,
    Customer_Name VARCHAR(32),
    Customer_Email VARCHAR(32),
    Customer_Phone VARCHAR(32),
    Customer_First_Order_Date TIMESTAMP,
    Customer_Last_Order_Date TIMESTAMP,
    Customer_AVG_LTV DOUBLE PRECISION,
    Customer_Address1 VARCHAR(64),
    Customer_Address2 VARCHAR(64),
    Product_Title VARCHAR(32),
    Product_Amount DOUBLE PRECISION,
    Product_Cost DOUBLE PRECISION,
    Product_Description VARCHAR(256),
    Product_Sku VARCHAR(16)
);

CREATE TABLE Business (
    Business_ID SERIAL PRIMARY KEY,
    Name VARCHAR(32) UNIQUE,
    URL VARCHAR(64) UNIQUE
);

INSERT INTO Business (Name, URL)
SELECT DISTINCT rt.Business_Name, rt.Business_URL
FROM raw_table rt
LEFT JOIN Business b ON rt.Business_Name = b.Name AND rt.Business_URL = b.URL
WHERE b.Business_ID IS NULL;

CREATE TABLE Subscription_Type (
    Subscription_Type_ID SERIAL PRIMARY KEY,
    Name VARCHAR(32) UNIQUE,
    Order_Max INT,
    Monthly_Price INT,
    Yearly_Price INT
);

INSERT INTO Subscription_Type (Name, Order_Max, Monthly_Price, Yearly_Price)
SELECT DISTINCT rt.Subscription_Name, rt.Subscription_Order_Max, rt.Subscription_Monthly_Price, rt.Subscription_Yearly_Price
FROM raw_table rt
LEFT JOIN Subscription_Type st ON rt.Subscription_Name = st.Name
WHERE st.Subscription_Type_ID IS NULL;


CREATE TABLE Subscription (
    Subscription_ID SERIAL PRIMARY KEY,
    Business_ID INT,
    Subscription_Type_ID INT,
    Start_Date TIMESTAMP,
    End_Date TIMESTAMP,
    Updated_At TIMESTAMP,
    FOREIGN KEY (Business_ID) REFERENCES Business(Business_ID),
    FOREIGN KEY (Subscription_Type_ID) REFERENCES Subscription_Type(Subscription_Type_ID),
    CONSTRAINT unique_subscription_combination UNIQUE (Business_ID, Subscription_Type_ID, Start_Date)
);


INSERT INTO Subscription (Business_ID, Subscription_Type_ID, Start_Date, End_Date)
SELECT
    b.Business_ID,
    st.Subscription_Type_ID,
    raw.Business_Sub_Start_Date,
    raw.Business_Sub_End_Date
FROM
    raw_table raw
LEFT JOIN Business b ON raw.Business_Name = b.Name
LEFT JOIN Subscription_Type st ON raw.Subscription_Name = st.Name
WHERE NOT EXISTS (
    SELECT 1
    FROM Subscription s
    WHERE s.Business_ID = b.Business_ID
    AND s.Subscription_Type_ID = st.Subscription_Type_ID
    AND s.Start_Date = raw.Business_Sub_Start_Date
    AND s.End_Date = raw.Business_Sub_End_Date
);








