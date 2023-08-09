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

-- Creating Business_Customers linker table
CREATE TABLE Business_Customer(
    Business_ID INT,
    Customer_ID INT,
    PRIMARY KEY (Business_ID, Customer_ID),
    FOREIGN KEY (Business_ID) REFERENCES Business(Business_ID),
    FOREIGN KEY (Customer_ID) REFERENCES Customer_Profile(Customer_ID)
);


-- Creating Business_Order table
CREATE TABLE Business_Order (
    Business_ID INT,
    Order_ID SERIAL,
    Customer_ID INT,
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
    FOREIGN KEY (Business_ID, Customer_ID) REFERENCES Business_Customer(Business_ID, Customer_ID)
);


-- Creating Address table
CREATE TABLE Address (
    Address_ID SERIAL PRIMARY KEY,
    Country VARCHAR(32),
    State VARCHAR(16),
    Zip VARCHAR(16),
    Line1 VARCHAR(64),
    Line2 VARCHAR(64),
    Updated_At TIMESTAMP
);


-- Creating Business_Order_Address table
CREATE TABLE Business_Order_Address (
    Address_ID INT,
    Type VARCHAR(8),
    Business_ID INT,
    Order_ID INT,
    PRIMARY KEY (Address_ID, Type, Business_ID, Order_ID),
    FOREIGN KEY (Address_ID) REFERENCES Address(Address_ID),
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
