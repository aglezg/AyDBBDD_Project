# books.py

from flask import jsonify, request
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
                     'numPaginas': row[10],
                     'estilo': row[11],
                     'sinopsis': row[12],
                     'idAutor': row[13]} for row in books]
    
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
                     'numPaginas': book[10],
                     'estilo': book[11],
                     'sinopsis': book[12],
                     'idAutor': book[13]})

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
                     'numPaginas': book[10],
                     'estilo': book[11],
                     'sinopsis': book[12],
                     'idAutor': book[13]})

# Return an book by autor ID
def returnBookByAutorId(id):
    # Connect to DB
    conn = get_db_connection()
    cur = conn.cursor()
    
    # Execute queries
    cur.execute('SELECT * FROM articulo INNER JOIN libro ON articulo.id = libro.idarticulo WHERE idAutor = %s;',(id,))
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
                     'numPaginas': row[10],
                     'estilo': row[11],
                     'sinopsis': row[12],
                     'idAutor': row[13]} for row in books]
    
    # Disconnect from DB
    cur.close()
    conn.close()
    
    # Return results
    return jsonify(books_list)

# Create a book
def createBook():
    # Get data from the request
    data = request.get_json()
    
    # Extract article data
    tipo = 'libro'
    titulo = data.get('titulo')
    subtitulo = data.get('subtitulo')
    fchPublicacion = data.get('fchPublicacion')
    portada = data.get('portada')
    stock = data.get('stock')

    # Extract book data
    editorial = data.get('editorial')
    numPaginas = data.get('numPaginas')
    sinopsis = data.get('sinopsis')
    estilo = data.get('estilo')
    idAutor = data.get('idAutor')

    # Validate data
    if titulo is None or stock is None or editorial is None or numPaginas is None:
        return jsonify({'error': 'el titulo, el stock, la editorial, el numero de paginas y el estilo del libro deben especificarse'}), 400
    
    if stock < 0:
        return jsonify({'error': 'el stock de un articulo no puede ser negativo'})

    if numPaginas < 0:
        return jsonify({'error': 'el numero de paginas de un articulo no puede ser negativo'})

    allowed_estilos = ['Narrativo', 'Poetico', 'Dramatico', 'Epico', 'Lirico', 'Didactico', 'Satirico']
    if data.get('estilo') is not None and data.get('estilo') not in allowed_estilos:
        return jsonify({'error': f'El valor de estilo debe ser uno de los siguientes: {", ".join(allowed_estilos)}'}), 400
    
    # Connect to DB
    conn = get_db_connection()
    cur = conn.cursor()
    
    # Execute queries
    cur.execute('INSERT INTO articulo (tipo, titulo, subtitulo, fchpublicacion, portada, stock) VALUES (%s, %s, %s, %s, %s, %s) RETURNING id;', (tipo, titulo, subtitulo, fchPublicacion, portada, stock))
    idArticle = cur.fetchone()[0]
    
    cur.execute('INSERT into libro (idarticulo, editorial, numpaginas, estilo, sinopsis, idautor) VALUES (%s, %s, %s, %s, %s, %s) RETURNING *;', (idArticle, editorial, numPaginas, estilo, sinopsis, idAutor))
    book = cur.fetchone()

    # Execute queries
    cur.execute('SELECT * FROM articulo INNER JOIN libro ON articulo.id = libro.idarticulo WHERE id = %s;',(idArticle,))
    book = cur.fetchone()
    
    # Commit the transaction
    conn.commit()
    
    # Disconnect from DB
    cur.close()
    conn.close()
    
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
                     'numPaginas': book[10],
                     'estilo': book[11],
                     'sinopsis': book[12],
                     'idAutor': book[13]}), 201