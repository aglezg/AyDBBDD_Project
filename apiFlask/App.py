import psycopg2
from flask import Flask
from flask import jsonify

app = Flask(__name__)

# Get connection to DB 'mylibrary'
def get_db_connection():
    conn = psycopg2.connect(
            host='localhost',
        	database='mylibrary',
		    user='postgres',
            password='1234')
    return conn

# Default route
@app.route('/mylibrary', methods=['GET', 'POST', 'PUT', 'PATCH', 'DELETE'])
def welcome():
  return jsonify({'mensaje': 'Bienvenido al sistema de base de datos myLibrary!'})


# Author routes
@app.route('/mylibrary/autores', methods=['GET'])
def getAllAuthors():
    from authors import returnAllAuthors
    return returnAllAuthors()

@app.route('/mylibrary/autores/id/<int:id>', methods=['GET'])
def getAnAuthorById(id):
    from authors import returnAuthorByID
    return returnAuthorByID(id)

@app.route('/mylibrary/autores', methods=['POST'])
def postAnAuthor():
    from authors import createAuthor
    return createAuthor()

@app.route('/mylibrary/autores/id/<int:id>', methods=['PATCH'])
def patchAnAuthor(id):
    from authors import updateAuthor
    return updateAuthor(id)

@app.route('/mylibrary/autores/id/<int:id>', methods=['DELETE'])
def deleteAnAuthor(id):
    from authors import removeAuthorByID
    return removeAuthorByID(id)


# Article routes
@app.route('/mylibrary/articulos', methods=['GET'])
def getAllArticles():
    from articles import returnAllArticles
    return returnAllArticles()

@app.route('/mylibrary/articulos/id/<int:id>', methods=['GET'])
def getAnArticleById(id):
    from articles import returnArticleByID
    return returnArticleByID(id)

@app.route('/mylibrary/articulos/titulo/<string:title>', methods=['GET'])
def getAnArticleByTitle(title):
    from articles import returnArticleByTitle
    return returnArticleByTitle(title)

@app.route('/mylibrary/articulos/id/<int:id>', methods = ['DELETE'])
def deleteAnArticle(id):
    from articles import removeArticleByID
    return removeArticleByID(id)


# Book routes
@app.route('/mylibrary/articulos/libros', methods=['GET'])
def getAllBooks():
    from books import returnAllBooks
    return returnAllBooks()

@app.route('/mylibrary/articulos/libros/id/<int:id>', methods=['GET'])
def getABookById(id):
    from books import returnBookByID
    return returnBookByID(id)

@app.route('/mylibrary/articulos/libros/titulo/<string:title>', methods=['GET'])
def getABookByTitle(title):
    from books import returnBookByTitle
    return returnBookByTitle(title)

@app.route('/mylibrary/articulos/libros/autor/id/<int:id>', methods=['GET'])
def getABookByAutorId(id):
    from books import returnBookByAutorId
    return returnBookByAutorId(id)

@app.route('/mylibrary/articulos/libros', methods=['POST'])
def postABook():
    from books import createBook
    return createBook()

@app.route('/mylibrary/articulos/libros/id/<int:id>', methods=['PATCH'])
def patchABook(id):
    from books import updateBook
    return updateBook(id)

@app.route('/mylibrary/articulos/libros/id/<int:id>', methods=['DELETE'])
def deleteABook(id):
    from books import removeBookByID
    return removeBookByID(id)


# Workers routes
@app.route('/mylibrary/trabajadores', methods=['GET'])
def getAllWorkers():
    from workers import returnAllWorkers
    return returnAllWorkers()

@app.route('/mylibrary/trabajadores/dni/<string:dni>', methods=['GET'])
def getWorkerByDNI(dni):
    from workers import returnWorkerByDNI
    return returnWorkerByDNI(dni)














# Get all adult-users
@app.route('/mylibrary/adult_users', methods=['GET'])
def getAllAdultUsers():

    # Connect to DB
    conn = get_db_connection()
    cur = conn.cursor()
    
    # Execute queries
    cur.execute('SELECT * FROM usuarioadulto;',)
    workers = cur.fetchall()

    # Convert to JSON format
    adult_users_list = [{'id': row[0],
                     'nombre': row[1],
                     'apellido1': row[2],
                     'apellido2': row[3],
                     'fecha_nacimiento': row[4],
                     'fecha_hora_registro': row[5],
                     'sexo': row[6],
                     'edad': row[7],
                     'dni': row[8],
                     'estudiante': row[9]} for row in workers]

    # Disconnect from DB
    cur.close()
    conn.close()

    # Return results
    return jsonify(adult_users_list)

# Get an adult-user by id
@app.route('/mylibrary/adult_users/<int:id>', methods=['GET'])
def getAdultUserByID(id):

    # Connect to DB
    conn = get_db_connection()
    cur = conn.cursor()
    
    # Execute queries
    cur.execute('SELECT * FROM usuarioadulto WHERE id = %s;',(id,))
    adult_user = cur.fetchone()

    # Disconnect from DB
    cur.close()
    conn.close()

    # Check if worker is not found
    if adult_user is None:
        return jsonify({'error': f'Adult user with ID {id} not found'}), 404

    # Return results
    return jsonify({'id': adult_user[0],
                     'nombre': adult_user[1],
                     'apellido1': adult_user[2],
                     'apellido2': adult_user[3],
                     'fecha_nacimiento': adult_user[4],
                     'fecha_hora_registro': adult_user[5],
                     'sexo': adult_user[6],
                     'edad': adult_user[7],
                     'dni': adult_user[8],
                     'estudiante': adult_user[9]})


# Get all minor-users
@app.route('/mylibrary/minor_users', methods=['GET'])
def getAllMinorUsers():

    # Connect to DB
    conn = get_db_connection()
    cur = conn.cursor()
    
    # Execute queries
    cur.execute('SELECT * FROM usuariomenor;',)
    minor_users = cur.fetchall()

    # Convert to JSON format
    minor_users_list = [{'id': row[0],
                     'nombre': row[1],
                     'apellido1': row[2],
                     'apellido2': row[3],
                     'fecha_nacimiento': row[4],
                     'fecha_hora_registro': row[5],
                     'sexo': row[6],
                     'edad': row[7],
                     'id_tarjeta_socio': row[8]} for row in minor_users]

    # Disconnect from DB
    cur.close()
    conn.close()

    # Return results
    return jsonify(minor_users_list)

# Get an minor-user by id
@app.route('/mylibrary/minor_users/<int:id>', methods=['GET'])
def getMinorUserByID(id):

    # Connect to DB
    conn = get_db_connection()
    cur = conn.cursor()
    
    # Execute queries
    cur.execute('SELECT * FROM usuariomenor WHERE id = %s;',(id,))
    minor_user = cur.fetchone()

    # Disconnect from DB
    cur.close()
    conn.close()

    # Check if worker is not found
    if minor_user is None:
        return jsonify({'error': f'Minor user with ID {id} not found'}), 404

    # Return results
    return jsonify({'id': minor_user[0],
                     'nombre': minor_user[1],
                     'apellido1': minor_user[2],
                     'apellido2': minor_user[3],
                     'fecha_nacimiento': minor_user[4],
                     'fecha_hora_registro': minor_user[5],
                     'sexo': minor_user[6],
                     'edad': minor_user[7],
                     'id_tarjeta_socio': minor_user[8]})



# Get all deliveries
@app.route('/mylibrary/deliveries', methods=['GET'])
def getAllDeliveries():

    # Connect to DB
    conn = get_db_connection()
    cur = conn.cursor()
    
    # Execute queries
    cur.execute('SELECT * FROM prestacion;',)
    deliveries = cur.fetchall()


    # Convert to JSON format
    deliveries_list = []

    # Check what user id is null
    for row in deliveries:
        if (row[3] is not None):
            deliveries_list.append({'id': row[0],
                            'id_articulo': row[1],
                            'dni_trabajador': row[2],
                            'usuario_adulto_id': row[3],
                            'fecha_inicio': row[5],
                            'fecha_fin': row[6],
                            'fecha_devolucion': row[7],
                            'vigente': row[8]})
        else:
            deliveries_list.append({'id': row[0],
                            'id_articulo': row[1],
                            'dni_trabajador': row[2],
                            'usuario_menor_id': row[4],
                            'fecha_inicio': row[5],
                            'fecha_fin': row[6],
                            'fecha_devolucion': row[7],
                            'vigente': row[8]})

    # Disconnect from DB
    cur.close()
    conn.close()

    # Return results
    return jsonify(deliveries_list)


# Get a delivery by ID
@app.route('/mylibrary/deliveries/<int:id>', methods=['GET'])
def getDeliveryByID(id):

    # Connect to DB
    conn = get_db_connection()
    cur = conn.cursor()

    # Execute queries
    cur.execute('SELECT * FROM prestacion WHERE id = %s;', (id,))
    delivery = cur.fetchone()

    # Disconnect from DB
    cur.close()
    conn.close()

    # Check if worker is not found
    if delivery is None:
        return jsonify({'error': f'Delivery with ID {id} not found'}), 404

    # Return results
    return jsonify({'id': delivery[0],
                     'id_articulo': delivery[1],
                     'dni_trabajador': delivery[2],
                     'id_usuario_adulto': delivery[3],
                     'id_usuario_menor': delivery[4],
                     'fecha_inicio': delivery[5],
                     'fecha_fin': delivery[6],
                     'fecha_devolucion': delivery[7],
                     'vigente': delivery[8]})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)