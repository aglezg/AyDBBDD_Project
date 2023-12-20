# books.py

from flask import jsonify, request
from App import get_db_connection
import base64
from articles import removeArticleByID

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

    # Connect to DB
    conn = get_db_connection()
    cur = conn.cursor()

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
    
    if idAutor is not None:
        cur.execute('SELECT * FROM autor WHERE id = %s;', (idAutor,))
        autorData = cur.fetchall()
        if not autorData:
            return jsonify({'error': f'El autor del libro que se intenta introducir no existe'}), 400
    
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

# Update a book by ID
def updateBook(id):
    # Get data from the request
    data = request.get_json()
    
    # Connect to DB
    conn = get_db_connection()
    cur = conn.cursor()

    # Validate data    
    if data.get('stock') is not None and data.get('stock') < 0:
        return jsonify({'error': 'el stock de un articulo no puede ser negativo'})

    if data.get('numPaginas') is not None and data.get('numPaginas') < 0:
        return jsonify({'error': 'el numero de paginas de un articulo no puede ser negativo'})

    allowed_estilos = ['Narrativo', 'Poetico', 'Dramatico', 'Epico', 'Lirico', 'Didactico', 'Satirico']
    if data.get('estilo') is not None and data.get('estilo') not in allowed_estilos:
        return jsonify({'error': f'El valor de estilo debe ser uno de los siguientes: {", ".join(allowed_estilos)}'}), 400
    
    if data.get('idAutor') is not None:
        cur.execute('SELECT * FROM autor WHERE id = %s;', (data.get('idAutor'),))
        autorData = cur.fetchall()
        if not autorData:
            return jsonify({'error': f'El autor del libro que se intenta introducir no existe'}), 400
    
    cur.execute('SELECT * FROM libro WHERE idArticulo = %s;', (id,))
    bookIdIfExists = cur.fetchone()
    if not bookIdIfExists:
        return jsonify({'error': f'El libro que se intenta actualizar no existe'}), 404
    
    # Build the SQL query dynamically based on provided values (articulo)
    query = 'UPDATE articulo SET '
    parameters = []
    
    if data.get('titulo') is not None:
        query += 'titulo = %s, '
        parameters.append(data.get('titulo'))

    if data.get('subtitulo') is not None:
        query += 'subtitulo = %s, '
        parameters.append(data.get('subtitulo'))

    if data.get('fchPublicacion') is not None:
        query += 'fchPublicacion = %s, '
        parameters.append(data.get('fchPublicacion'))

    if data.get('portada') is not None:
        query += 'portada = %s, '
        parameters.append(data.get('portada'))

    if data.get('stock') is not None:
        query += 'stock = %s, '
        parameters.append(data.get('stock'))
   
    # Execute the dynamically built query with parameters
    if parameters:
        # Remove the trailing comma and space
        query = query.rstrip(', ')
        # Add the WHERE clause for the specific book_id
        query += ' WHERE id = %s RETURNING id;'
        parameters.append(id)
        cur.execute(query, tuple(parameters))
        # Commit the transaction
        conn.commit()
    
    # Build the SQL query dynamically based on provided values (libro)
    query = 'UPDATE libro SET '
    parameters = []
    
    if data.get('editorial') is not None:
        query += 'editorial = %s, '
        parameters.append(data.get('editorial'))

    if data.get('numPaginas') is not None:
        query += 'numPaginas = %s, '
        parameters.append(data.get('numPaginas'))

    if data.get('estilo') is not None:
        query += 'estilo = %s, '
        parameters.append(data.get('estilo'))

    if data.get('sinopsis') is not None:
        query += 'sinopsis = %s, '
        parameters.append(data.get('sinopsis'))

    if data.get('idAutor') is not None:
        query += 'idAutor = %s, '
        parameters.append(data.get('idAutor'))
    
    # Execute the dynamically built query with parameters
    if parameters:
        # Remove the trailing comma and space
        query = query.rstrip(', ')
        # Add the WHERE clause for the specific book_id
        query += ' WHERE id = %s RETURNING id;'
        parameters.append(id)
        cur.execute(query, tuple(parameters))
        # Commit the transaction
        conn.commit()
    
    cur.execute('SELECT * FROM articulo INNER JOIN libro ON articulo.id = libro.idarticulo WHERE id = %s;',(id,))
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
                     'idAutor': book[13]}), 200

# Remove an book by ID
def removeBookByID(id):
    # Connect to DB
    conn = get_db_connection()
    cur = conn.cursor()

    # Validate if the article is a book
    cur.execute('SELECT * FROM libro WHERE idArticulo = %s;', (id,))
    bookIdIfExists = cur.fetchone()
    if not bookIdIfExists:
        return jsonify({'error': f'El articulo a borrar no es un libro o no existe'}), 400
    
    # Disconnect from DB
    cur.close()
    conn.close()

    # Execute queries and return results
    return removeArticleByID(id)