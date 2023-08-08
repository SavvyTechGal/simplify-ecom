CREATE TABLE Business (
    Business_ID INT PRIMARY KEY,
    Name VARCHAR(32),
    URL VARCHAR(32)
);

-- Creating Subscription_Type table
CREATE TABLE Subscription_Type (
    Subscription_Type_ID INT PRIMARY KEY,
    Name VARCHAR(32),
    Order_Max INT,
    Monthly_Price INT,
    Yearly_Price INT
);

-- Creating Subscription table
CREATE TABLE Subscription (
    Subscription_ID INT PRIMARY KEY,
    Business_ID INT,
    Subscription_Type_ID INT,
    Start_Date TIMESTAMP,
    End_Date TIMESTAMP,
    FOREIGN KEY (Business_ID) REFERENCES Business(Business_ID),
    FOREIGN KEY (Subscription_Type_ID) REFERENCES Subscription_Type(Subscription_Type_ID)
);

