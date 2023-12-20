# authors.py

from flask import jsonify, request
from App import get_db_connection
from datetime import datetime

# Return all authors
def returnAllAuthors():
    # Connect to DB
    conn = get_db_connection()
    cur = conn.cursor()

    # Execute queries
    cur.execute('SELECT * FROM autor;',)
    author = cur.fetchall()

    # Convert to JSON format
    authors_list = [{'id': row[0],
                     'nombre': row[1],
                     'apellido1': row[2],
                     'apellido2': row[3],
                     'fchNacimiento': row[4],
                     'fchMuerte': row[5],
                     'sexo': row[6],
                     'edad': row[7]} for row in author]
    
    # Disconnect from DB
    cur.close()
    conn.close()
    
    # Return results
    return jsonify(authors_list)

# Return an author by ID
def returnAuthorByID(id):
    # Connect to DB
    conn = get_db_connection()
    cur = conn.cursor()
    
    # Execute queries
    cur.execute('SELECT * FROM autor WHERE id = %s;',(id,))
    author = cur.fetchone()
    
    # Disconnect from DB
    cur.close()
    conn.close()
    
    # Check if author is not found
    if author is None:
        return jsonify({'error': f'Autor con ID {id} no encontrado'}), 404
    
    # Return results
    return jsonify({'id': author[0],
                     'nombre': author[1],
                     'apellido1': author[2],
                     'apellido2': author[3],
                     'fchNacimiento': author[4],
                     'fchMuerte': author[5],
                     'sexo': author[6],
                     'edad': author[7]})

# Create an author
def createAuthor():
    # Get data from the request
    data = request.get_json()
    
    # Extract data
    nombre = data.get('nombre')
    apellido1 = data.get('apellido1')
    apellido2 = data.get('apellido2')
    fchNacimiento = data.get('fchNacimiento')
    fchMuerte = data.get('fchMuerte')
    sexo = data.get('sexo')
    
    # Validate data
    if nombre is None or apellido1 is None:
        return jsonify({'error': 'el nombre y el primer apellido del autor deben especificarse'}), 400
    
    if data.get('fchNacimiento') is not None and data.get('fchNacimiento') > datetime.now().strftime('%Y-%m-%d'):
        return jsonify({'error': 'La fecha de nacimiento no puede ser posterior a la fecha actual'}), 400
    
    if data.get('fchMuerte') is not None and data.get('fchMuerte') > datetime.now().strftime('%Y-%m-%d'):
        return jsonify({'error': 'La fecha de muerte no puede ser posterior a la fecha actual'}), 400
    
    if data.get('fchNacimiento') is not None and data.get('fchMuerte') is not None and data.get('fchNacimiento') > data.get('fchMuerte'):
        return jsonify({'error': 'La fecha de nacimiento no puede ser posterior a la fecha de muerte'}), 400

    allowed_sexos = ['M', 'F', 'O']
    if data.get('sexo') is not None and data.get('sexo') not in allowed_sexos:
        return jsonify({'error': f'El valor de sexo debe ser uno de los siguientes: {", ".join(allowed_sexos)}'}), 400
    
    # Connect to DB
    conn = get_db_connection()
    cur = conn.cursor()
    
    # Execute queries
    cur.execute('INSERT INTO autor (nombre, apellido1, apellido2, fchnacimiento, fchmuerte, sexo) VALUES (%s, %s, %s, %s, %s, %s) RETURNING *;',(nombre, apellido1, apellido2, fchNacimiento, fchMuerte, sexo,))
    author = cur.fetchone()
    
    # Commit the transaction
    conn.commit()
    
    # Disconnect from DB
    cur.close()
    conn.close()
    
    # Return results
    return jsonify({'id': author[0],
                    'nombre': author[1],
                    'apellido1': author[2],
                    'apellido2': author[3],
                    'fchNacimiento': author[4],
                    'fchMuerte': author[5],
                    'sexo': author[6],
                    'edad': author[7]}), 201

# Update an author by ID
def updateAuthor(id):
    # Get data from the request
    data = request.get_json()
    
    # Connect to DB
    conn = get_db_connection()
    cur = conn.cursor()

    # Validate data
    if data.get('fchNacimiento') is not None and data.get('fchNacimiento') > datetime.now().strftime('%Y-%m-%d'):
        return jsonify({'error': 'La fecha de nacimiento no puede ser posterior a la fecha actual'}), 400
    
    if data.get('fchMuerte') is not None and data.get('fchMuerte') > datetime.now().strftime('%Y-%m-%d'):
        return jsonify({'error': 'La fecha de muerte no puede ser posterior a la fecha actual'}), 400
    
    if data.get('fchNacimiento') is not None and data.get('fchMuerte') is not None and data.get('fchNacimiento') > data.get('fchMuerte'):
        return jsonify({'error': 'La fecha de nacimiento no puede ser posterior a la fecha de muerte'}), 400

    allowed_sexos = ['M', 'F', 'O']
    if data.get('sexo') is not None and data.get('sexo') not in allowed_sexos:
        return jsonify({'error': f'El valor de sexo debe ser uno de los siguientes: {", ".join(allowed_sexos)}'}), 400
    
    cur.execute('SELECT * FROM autor WHERE id = %s;', (id,))
    autorIfExists = cur.fetchone()
    if not autorIfExists:
        return jsonify({'error': f'El autor que se intenta actualizar no existe'}), 400

    # Build the SQL query dynamically based on provided values
    query = 'UPDATE autor SET '
    parameters = []
    
    if data.get('nombre') is not None:
        query += 'nombre = %s, '
        parameters.append(data.get('nombre'))

    if data.get('apellido1') is not None:
        query += 'apellido1 = %s, '
        parameters.append(data.get('apellido1'))

    if data.get('apellido2') is not None:
        query += 'apellido2 = %s, '
        parameters.append(data.get('apellido2'))

    if data.get('fchNacimiento') is not None:
        query += 'fchNacimiento = %s, '
        parameters.append(data.get('fchNacimiento'))

    if data.get('fchMuerte') is not None:
        query += 'fchMuerte = %s, '
        parameters.append(data.get('fchMuerte'))

    if data.get('sexo') is not None:
        query += 'sexo = %s, '
        parameters.append(data.get('sexo'))
    
    author = None
    if parameters:
        # Remove the trailing comma and space
        query = query.rstrip(', ')
        # Add the WHERE clause for the specific author_id
        query += ' WHERE id = %s RETURNING *;'
        parameters.append(id)
        # Execute the dynamically built query with parameters
        cur.execute(query, tuple(parameters))
        author = cur.fetchone()
    
    # Commit the transaction
    conn.commit()
   
   # Disconnect from DB
    cur.close()
    conn.close()
    
    # Return results
    if author:
        return jsonify({'id': author[0],
                        'nombre': author[1],
                        'apellido1': author[2],
                        'apellido2': author[3],
                        'fchNacimiento': author[4],
                        'fchMuerte': author[5],
                        'sexo': author[6],
                        'edad': author[7]}), 200
    else:
        return jsonify({"mensaje": "ningun cambio efectuado"}), 200

# Remove an author by ID
def removeAuthorByID(id):
    # Connect to DB
    conn = get_db_connection()
    cur = conn.cursor()
    
    # Execute queries
    cur.execute('DELETE FROM autor WHERE id = %s RETURNING *;',(id,))
    author = cur.fetchone()

    # Commit the transaction
    conn.commit()
    
    # Disconnect from DB
    cur.close()
    conn.close()
    
    # Check if author is not found
    if author is None:
        return jsonify({'error': f'Autor con ID {id} no encontrado'}), 404
    
    # Return results
    return jsonify({'mensaje': 'Autor borrado satisfactoriamente',
                    'autor': {'id': author[0],
                     'nombre': author[1],
                     'apellido1': author[2],
                     'apellido2': author[3],
                     'fchNacimiento': author[4],
                     'fchMuerte': author[5],
                     'sexo': author[6],
                     'edad': author[7]}})