# articles.py

from flask import jsonify, request
from App import get_db_connection
from datetime import datetime
import base64

# Return all articles
def returnAllArticles():
    # Connect to DB
    conn = get_db_connection()
    cur = conn.cursor()

    # Execute queries
    cur.execute('SELECT * FROM articulo;',)
    articles = cur.fetchall()

    # Convert to JSON format
    articles_list = [{'id': row[0],
                     'tipo': row[1],
                     'titulo': row[2],
                     'subtitulo': row[3],
                     'fchPublicacion': row[4],
                     'portada': base64.b64encode(row[5]).decode('utf-8') if row[5] else None,
                     'stock': row[6],
                     'disponible': row[7]} for row in articles]
    
    # Disconnect from DB
    cur.close()
    conn.close()
    
    # Return results
    return jsonify(articles_list)

# Return an article by ID
def returnArticleByID(id):
    # Connect to DB
    conn = get_db_connection()
    cur = conn.cursor()
    
    # Execute queries
    cur.execute('SELECT * FROM articulo WHERE id = %s;',(id,))
    article = cur.fetchone()
    
    # Disconnect from DB
    cur.close()
    conn.close()
    
    # Check if article is not found
    if article is None:
        return jsonify({'error': f'articulo con ID {id} no encontrado'}), 404
    
    # Return results
    return jsonify({'id': article[0],
                     'tipo': article[1],
                     'titulo': article[2],
                     'subtitulo': article[3],
                     'fchPublicacion': article[4],
                     'portada': base64.b64encode(article[5]).decode('utf-8') if article[5] else None,
                     'stock': article[6],
                     'disponible': article[7]})

# Return an article by title
def returnArticleByTitle(title):
    # Connect to DB
    conn = get_db_connection()
    cur = conn.cursor()
    
    # Execute queries
    cur.execute('SELECT * FROM articulo WHERE titulo = %s;',(title,))
    article = cur.fetchone()
    
    # Disconnect from DB
    cur.close()
    conn.close()
    
    # Check if article is not found
    if article is None:
        return jsonify({'error': f'articulo con titulo {title} no encontrado'}), 404
    
    # Return results
    return jsonify({'id': article[0],
                     'tipo': article[1],
                     'titulo': article[2],
                     'subtitulo': article[3],
                     'fchPublicacion': article[4],
                     'portada': base64.b64encode(article[5]).decode('utf-8') if article[5] else None,
                     'stock': article[6],
                     'disponible': article[7]})

# Remove an article by ID
def removeArticleByID(id):
    # Connect to DB
    conn = get_db_connection()
    cur = conn.cursor()
    
    # Execute queries
    cur.execute('DELETE FROM articulo WHERE id = %s RETURNING *;',(id,))
    article = cur.fetchone()

    # Commit the transaction
    conn.commit()
    
    # Disconnect from DB
    cur.close()
    conn.close()
    
    # Check if article is not found
    if article is None:
        return jsonify({'error': f'articulo con ID {id} no encontrado'}), 404
    
    # Return results
    return jsonify({'mensaje': 'articulo borrado satisfactoriamente',
                    'articulo': {'id': article[0],
                                 'tipo': article[1],
                                 'titulo': article[2],
                                 'subtitulo': article[3],
                                 'fchPublicacion': article[4],
                                 'portada': base64.b64encode(article[5]).decode('utf-8') if article[5] else None,
                                 'stock': article[6],
                                 'disponible': article[7]}})