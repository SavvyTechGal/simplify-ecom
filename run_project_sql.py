#created with help of chatgpt -> minor modifications by Savana Hughes
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

    # Read and execute SQL commands from a .sql file
    sql_file_path = '/Users/savana/Desktop/Clean Desktop/school/project/dml.sql'
    
    with open(sql_file_path, 'r') as sql_file:
        sql_commands = sql_file.read()
        cursor.execute(sql_commands)
    
    # Commit the changes and close the cursor and connection
    connection.commit()
    cursor.close()
    connection.close()

    print("SQL file executed successfully.")

except Exception as e:
    print("An error occurred:", str(e))
