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
    Internal_Order_Number VARCHAR(16),
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

--- load data from csv
-- COPY raw_table FROM '/Users/savana/Desktop/Clean Desktop/school/project/dummy_data.csv' WITH CSV HEADER;
-- COPY raw_table FROM '/home/david/simplify2/dummy_data.csv' WITH CSV HEADER;
