import os
import psycopg2

conn = psycopg2.connect(
        host="localhost",
        database="myLibrary",
		user='postgres',
        password='1234')

# Open a cursor to perform database operations
cur = conn.cursor()

# A lo mejor podemos llamar aqui a los scripts e inicializar la base de datos!!

cur.close()
conn.close()