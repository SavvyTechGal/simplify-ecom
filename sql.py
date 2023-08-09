#created by chatgpt
import psycopg2
import sys


# Replace these variables with your PostgreSQL credentials
db_host = "127.0.0.1"
db_name = "postgres"
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
    ## Example: create a new table
    # create_table_query = """
    # CREATE TABLE person_table (
    #     id SERIAL PRIMARY KEY,
    #     name VARCHAR(32),
    #     age INTEGER,
    #     is_parent BOOLEAN
    # );
    # """ 
    # cursor.execute(create_table_query)
    # print("Table created successfully.")

########################################

########################################
    # Load data from a CSV file into a table
    # load_query = """
    # COPY franchise FROM '/Users/savana/Desktop/Clean Desktop/school/project/franchise.csv' WITH CSV HEADER;
    # """
    # cursor.execute(load_query)
    # print("CSV data loaded successfully.")

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

