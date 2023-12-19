# books.py

from flask import jsonify
from App import get_db_connection
import base64

# Return all books
def returnAllBooks():
    # Connect to DB
    conn = get_db_connection()
    cur = conn.cursor()

    # Execute queries
    cur.execute('SELECT * FROM articulo INNER JOIN libro ON articulo.id = libro.idarticulo;',)
    books = cur.fetchall()

    # Convert to JSON format
    books_list = [{'id': row[0],
                     'tipo': row[1],
                     'titulo': row[2],
                     'subtitulo': row[3],
                     'fchPublicacion': row[4],
                     'portada': base64.b64encode(row[5]).decode('utf-8') if row[5] else None,
                     'stock': row[6],
                     'disponible': row[7],
                     'editorial': row[9],
                     'numpaginas': row[10],
                     'estilo': row[11],
                     'sinopsis': row[12],
                     'idautor': row[13]} for row in books]
    
    # Disconnect from DB
    cur.close()
    conn.close()
    
    # Return results
    return jsonify(books_list)

# Return an book by ID
def returnBookByID(id):
    # Connect to DB
    conn = get_db_connection()
    cur = conn.cursor()
    
    # Execute queries
    cur.execute('SELECT * FROM articulo INNER JOIN libro ON articulo.id = libro.idarticulo WHERE id = %s;',(id,))
    book = cur.fetchone()
    
    # Disconnect from DB
    cur.close()
    conn.close()
    
    # Check if book is not found
    if book is None:
        return jsonify({'error': f'libro con ID {id} no encontrado'}), 404
    
    # Return results
    return jsonify({'id': book[0],
                     'tipo': book[1],
                     'titulo': book[2],
                     'subtitulo': book[3],
                     'fchPublicacion': book[4],
                     'portada': base64.b64encode(book[5]).decode('utf-8') if book[5] else None,
                     'stock': book[6],
                     'disponible': book[7],
                     'editorial': book[9],
                     'numpaginas': book[10],
                     'estilo': book[11],
                     'sinopsis': book[12],
                     'idautor': book[13]})

# Return an book by title
def returnBookByTitle(title):
    # Connect to DB
    conn = get_db_connection()
    cur = conn.cursor()
    
    # Execute queries
    cur.execute('SELECT * FROM articulo INNER JOIN libro ON articulo.id = libro.idarticulo WHERE titulo = %s;',(title,))
    book = cur.fetchone()
    
    # Disconnect from DB
    cur.close()
    conn.close()
    
    # Check if book is not found
    if book is None:
        return jsonify({'error': f'libro con titulo {title} no encontrado'}), 404
    
    # Return results
    return jsonify({'id': book[0],
                     'tipo': book[1],
                     'titulo': book[2],
                     'subtitulo': book[3],
                     'fchPublicacion': book[4],
                     'portada': base64.b64encode(book[5]).decode('utf-8') if book[5] else None,
                     'stock': book[6],
                     'disponible': book[7],
                     'editorial': book[9],
                     'numpaginas': book[10],
                     'estilo': book[11],
                     'sinopsis': book[12],
                     'idautor': book[13]})