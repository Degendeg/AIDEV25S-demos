import os
from dotenv import load_dotenv
import mysql.connector

load_dotenv()

def fetch_all_from_table(table):
    try:
        # Skapa en conn till db
        connection = mysql.connector.connect(
            host=os.getenv('DB_HOST'),
            user=os.getenv('DB_USER'),
            password=os.getenv('DB_PASSWORD'),
            database=os.getenv('DB_NAME')
        )
        
        # Skapa cursor objekt för att köra SQL-frågor
        cursor = connection.cursor()
        
        # SQL-fråga för att hämta allt från tabellen
        cursor.execute(f"SELECT * FROM {table}")
        
        # Hämta alla rader
        rows = cursor.fetchall()
        
        # Stäng anslutningen
        cursor.close()
        connection.close()
        
        return rows

    except mysql.connector.Error as err:
        print(f"Error: {err}")
        return None

# Fånga input
table_name = input("Enter table name: ")

# Hämta alla rader baserat på input
res = fetch_all_from_table(table_name)

# Loopa igenom raderna
if res:
    for r in res:
        print(r)