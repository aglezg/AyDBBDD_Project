# articles.py

from flask import jsonify, request
from App import get_db_connection
from datetime import datetime

# Return all articles
def returnAllArticles():
    # Connect to DB
    conn = get_db_connection()
    cur = conn.cursor()

    # Execute queries
    cur.execute('SELECT * FROM articulo;',)
    article = cur.fetchall()

    # Convert to JSON format
    articles_list = [{'id': row[0],
                     'tipo': row[1],
                     'titulo': row[2],
                     'subtitulo': row[3],
                     'fchPublicacion': row[4],
                     'portada': row[5],
                     'stock': row[6],
                     'disponible': row[7]} for row in article]
    
    # Disconnect from DB
    cur.close()
    conn.close()
    
    # Return results
    return jsonify(articles_list)