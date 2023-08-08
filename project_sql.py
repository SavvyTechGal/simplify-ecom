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
    ## Load data from a CSV file into a raq table
    load_query = """
    COPY raw_table FROM '/Users/savana/Desktop/Clean Desktop/school/project/dummy_data.csv' WITH CSV HEADER;
    """
    cursor.execute(load_query)
    print("CSV data loaded successfully.")

########################################

# ########################################
#     ## Example: drop a table
#     drop_table_query = """
#     DROP TABLE person_table;
#     """
#     cursor.execute(drop_table_query)
#     print("Table dropped successfully.")
# ########################################

# ########################################
#     ## Example: insert a row
#     insert_row_query = """
#     INSERT INTO person_table (name, age, is_parent)
#     VALUES ('Dan', 14, FALSE), ('Mary', 20, FALSE)
#     ;
#     """
#     cursor.execute(insert_row_query)
#     print("Row inserted successfully.")
# ########################################

# ########################################
#     ## Example: update a row
#     update_row_query = """
#     UPDATE person_table
#     SET age = 36
#     WHERE name = 'John';
#     """
#     cursor.execute(update_row_query)
#     print("Row updated successfully.")
# ########################################

# ########################################
#     ## Example: delete a row
#     delete_row_query = """
#     DELETE FROM person_table
#     WHERE name = 'John';
#     """
#     cursor.execute(delete_row_query)
#     print("Row deleted successfully.")
# ########################################

# ########################################
#     ## Example: select rows
#     select_rows_query = """
#     SELECT * FROM person_table;
#     """
#     cursor.execute(select_rows_query)
#     rows = cursor.fetchall()
    
#     for row in rows:
#         print(row)
########################################


    # Commit the changes
    connection.commit()
    # Close the cursor and connection
    cursor.close()
    connection.close()

except psycopg2.Error as e:
    print("Error connecting to the PostgreSQL database:", e)

