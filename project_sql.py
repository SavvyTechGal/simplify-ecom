#created by chatgpt
import psycopg2
import sys


# Replace these variables with your PostgreSQL credentials
db_host = "127.0.0.1"
db_name = "simplify_db"
db_user = "postgres"
db_password = "postgres"

try:
    # Connect to the PostgreSQL database
    connection = psycopg2.connect(
        host=db_host,
        database=db_name,
        user=db_user,
        password=db_password
    )

    # Create a cursor to execute SQL queries
    cursor = connection.cursor()
########################################
## Create Raw Table
#     create_table_query = """
# CREATE TABLE raw_table (
#     Business_ID INT,
#     Business_Name VARCHAR(32),
#     Business_URL VARCHAR(32),
#     Business_Avg_Monthly_Sales DOUBLE PRECISION,
#     Business_Avg_Net_Revenue DOUBLE PRECISION,
#     Business_Sub_Start_Date TIMESTAMP,
#     Business_Sub_End_Date TIMESTAMP,
#     Subscription_ID INT,
#     Subscription_Name VARCHAR(32),
#     Subscription_Order_Max INT,
#     Subscription_Monthly_Price INT,
#     Subscription_Yearly_Price INT,
#     Order_ID INT,
#     Order_Total DOUBLE PRECISION,
#     Order_Subtotal DOUBLE PRECISION,
#     Order_Tax DOUBLE PRECISION,
#     Order_Shipping_Amount_paid DOUBLE PRECISION,
#     Order_Shipping_Cost DOUBLE PRECISION,
#     Order_Product_Cost DOUBLE PRECISION,
#     Order_Total_Refund DOUBLE PRECISION,
#     Order_Creation_Date TIMESTAMP,
#     Order_Fulfilled_Date TIMESTAMP,
#     Order_Cancellation_Date TIMESTAMP,
#     Order_Financial_Status VARCHAR(16),
#     Order_Discount_Amount DOUBLE PRECISION,
#     Order_Discount_Code VARCHAR(16),
#     Order_Country VARCHAR(3),
#     Order_State VARCHAR(64),
#     Order_Zip VARCHAR(16),
#     Order_Address1 VARCHAR(64),
#     Order_Address2 VARCHAR(64),
#     Order_Billing_Country VARCHAR(3),
#     Order_Billing_State VARCHAR(16),
#     Order_Billing_Zip VARCHAR(16),
#     Order_Billing_Address1 VARCHAR(64),
#     Order_Billing_Address2 VARCHAR(64),
#     Lineitem_ID INT,
#     Lineitem_Title VARCHAR(32),
#     Lineitem_Sku VARCHAR(16),
#     Lineitem_Gross_Revenue DOUBLE PRECISION,
#     Lineitem_Net_Revenue DOUBLE PRECISION,
#     Lineitem_Discount_Amount DOUBLE PRECISION,
#     Lineitem_Quantity INT,
#     Linetem_Tax DOUBLE PRECISION,
#     Lineitem_Cost DOUBLE PRECISION,
#     Customer_ID INT,
#     Customer_Name VARCHAR(32),
#     Customer_Email VARCHAR(32),
#     Customer_Phone VARCHAR(32),
#     Customer_First_Order_Date TIMESTAMP,
#     Customer_Last_Order_Date TIMESTAMP,
#     Customer_AVG_LTV DOUBLE PRECISION,
#     Customer_Created_At TIMESTAMP,
#     Customer_Updated_At TIMESTAMP,
#     Customer_Address1 VARCHAR(64),
#     Customer_Address2 VARCHAR(64),
#     Product_ID INT,
#     Product_Title VARCHAR(32),
#     Product_Amount DOUBLE PRECISION,
#     Product_Cost DOUBLE PRECISION,
#     Product_Description VARCHAR(256),
#     Product_Sku VARCHAR(16),
#     Product_Created_At TIMESTAMP,
#     Product_Updated_At TIMESTAMP
# );

#     """ 
#     cursor.execute(create_table_query)
#     print("Table created successfully.")
########################################

########################################
    # ## Load data from a CSV file into a raq table
    # load_query = """
    # COPY raw_table FROM '/Users/savana/Desktop/Clean Desktop/school/project/dummy_data.csv' WITH CSV HEADER;
    # """
    # cursor.execute(load_query)
    # print("CSV data loaded successfully.")

########################################


########################################
# Create Raw Table
    create_table_query = """
CREATE TABLE Business (
    Business_ID INT PRIMARY KEY,
    Name VARCHAR(32),
    URL VARCHAR(32)
);

    """ 
    cursor.execute(create_table_query)
    print("Table created successfully.")

    create_table_query = """
-- Creating Subscription_Type table
CREATE TABLE Subscription_Type (
    Subscription_Type_ID INT PRIMARY KEY,
    Name VARCHAR(32),
    Order_Max INT,
    Monthly_Price INT,
    Yearly_Price INT
);

    """ 
    cursor.execute(create_table_query)
    print("Table created successfully.")

    create_table_query = """
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

    """ 
    cursor.execute(create_table_query)
    print("Table created successfully.")


    create_table_query = """
-- Creating Customer_Profile table
CREATE TABLE Customer_Profile (
    Customer_ID INT PRIMARY KEY,
    Name VARCHAR(32),
    Email VARCHAR(32),
    Phone VARCHAR(32),
    Created_At TIMESTAMP,
    Updated_At TIMESTAMP
);

    """ 
    cursor.execute(create_table_query)
    print("Table created successfully.")

    create_table_query = """
-- Creating Business_Customers linker table
CREATE TABLE Business_Customers (
    Business_ID INT,
    Customer_ID INT,
    PRIMARY KEY (Business_ID, Customer_ID),
    FOREIGN KEY (Business_ID) REFERENCES Business(Business_ID),
    FOREIGN KEY (Customer_ID) REFERENCES Customer_Profile(Customer_ID)
);

    """ 
    cursor.execute(create_table_query)
    print("Table created successfully.")
########################################

    # Commit the changes
    connection.commit()
    # Close the cursor and connection
    cursor.close()
    connection.close()

except psycopg2.Error as e:
    print("Error connecting to the PostgreSQL database:", e)

