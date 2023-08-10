-- create raw_table
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

-- load data from csv
COPY raw_table FROM 'path/dummy_data.csv' WITH CSV HEADER;



-- Creating Business table
CREATE TABLE Business (
    Business_ID SERIAL PRIMARY KEY,
    Name VARCHAR(32) UNIQUE,
    URL VARCHAR(64) UNIQUE
);

-- Creating Subscription_Type table
CREATE TABLE Subscription_Type (
    Subscription_Type_ID SERIAL PRIMARY KEY,
    Name VARCHAR(32) UNIQUE,
    Order_Max INT,
    Monthly_Price INT,
    Yearly_Price INT
);

-- Creating Subscription table
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

-- Creating Customer_Profile table
CREATE TABLE Customer_Profile (
    Customer_ID SERIAL PRIMARY KEY,
    Name VARCHAR(32),
    Email VARCHAR(32) UNIQUE,
    Phone VARCHAR(32) UNIQUE,
    Created_At TIMESTAMP,
    Updated_At TIMESTAMP
);


-- Creating Business_Order table
CREATE TABLE Business_Order (
    Business_ID INT,
    Order_ID SERIAL,
    Customer_ID INT,
    Order_Number VARCHAR(16),
    Shipping_Amount_Paid DOUBLE PRECISION,
    Shipping_Cost DOUBLE PRECISION,
    Total_Refund DOUBLE PRECISION,
    Discount_Code VARCHAR(16),
    Financial_Status VARCHAR(16),
    Created_At TIMESTAMP,
    Fulfilled_At TIMESTAMP,
    Cancelled_At TIMESTAMP,
    PRIMARY KEY (Business_ID, Order_ID),
    FOREIGN KEY (Business_ID) REFERENCES Business(Business_ID),
    FOREIGN KEY (Customer_ID) REFERENCES Customer_Profile(Customer_ID)
);

-- Creating Business_Customers linker table
CREATE TABLE Business_Customer(
    Business_ID INT,
    Customer_ID INT,
    PRIMARY KEY (Business_ID, Customer_ID),
    FOREIGN KEY (Business_ID) REFERENCES Business(Business_ID),
    FOREIGN KEY (Customer_ID) REFERENCES Customer_Profile(Customer_ID)
);

-- have an updated column for when an order is updated Created_At ,Fulfilled_At ,Cancelled_At


-- Creating Address table
CREATE TABLE Address (
    Address_ID SERIAL PRIMARY KEY,
    Country VARCHAR(3),
    State VARCHAR(16),
    Zip VARCHAR(16),
    Line1 VARCHAR(64),
    Line2 VARCHAR(64),
    Created_At TIMESTAMP
);


-- Creating Business_Order_Address table
CREATE TABLE Business_Order_Address (
    Address_ID INT,
    Type VARCHAR(8),
    Business_ID INT,
    Order_ID INT,
    PRIMARY KEY (Address_ID, Type, Business_ID, Order_ID),
    FOREIGN KEY (Address_ID) REFERENCES Address(Address_ID),
    FOREIGN KEY (Business_ID) REFERENCES Business(Business_ID),
    FOREIGN KEY (Business_ID, Order_ID) REFERENCES Business_Order(Business_ID, Order_ID)
);

-- Creating Business_Product table
CREATE TABLE Business_Product (
    Business_ID INT,
    Product_ID SERIAL,
    Title VARCHAR(32),
    Sku VARCHAR(16),
    Amount DOUBLE PRECISION,
    Cost DOUBLE PRECISION,
    Description VARCHAR(256),
    Created_At TIMESTAMP,
    Updated_At TIMESTAMP,
    PRIMARY KEY (Business_ID, Product_ID),
    FOREIGN KEY (Business_ID) REFERENCES Business(Business_ID)
);


-- Creating Business_Order_lineitem table
CREATE TABLE Business_Order_lineitem (
    Business_ID INT,
    Lineitem_ID SERIAL,
    Gross_Revenue DOUBLE PRECISION,
    Discount_Amount DOUBLE PRECISION,
    Quantity INT,
    Tax DOUBLE PRECISION,
    Order_ID INT,
    Product_ID INT,
    PRIMARY KEY (Business_ID, Lineitem_ID),
    FOREIGN KEY (Business_ID) REFERENCES Business(Business_ID),
    FOREIGN KEY (Business_ID, Order_ID) REFERENCES Business_Order(Business_ID, Order_ID),
    FOREIGN KEY (Business_ID, Product_ID) REFERENCES Business_Product(Business_ID, Product_ID)
);



