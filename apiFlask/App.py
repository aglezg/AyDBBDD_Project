import os
import psycopg2
from flask import Flask, render_template, request, url_for, redirect
from flask import jsonify

app = Flask(__name__)

# Get connection to DB 'mylibrary'
def get_db_connection():
    conn = psycopg2.connect(
            host='localhost',
        	database="mylibrary",
		    user="postgres",
            password="1234")
    return conn

# Default welcome route
@app.route('/mylibrary', methods=['GET', 'POST'])
def welcome():
  return "Hello World!"



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
        return jsonify({'error': f"Adult user with ID {id} not found"}), 404

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
        return jsonify({'error': f"Minor user with ID {id} not found"}), 404

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

# Get all workers
@app.route('/mylibrary/workers', methods=['GET'])
def getAllWorkers():

    # Connect to DB
    conn = get_db_connection()
    cur = conn.cursor()
    
    # Execute queries
    cur.execute('SELECT * FROM trabajador;',)
    workers = cur.fetchall()

    # Convert to JSON format
    workers_list = [{'dni': row[0],
                     'nombre': row[1],
                     'apellido1': row[2],
                     'apellido2': row[3],
                     'fecha_nacimiento': row[4],
                     'nombre_usuario': row[5],
                     'sexo': row[6],
                     'contrasena': row[7],
                     'edad': row[8],
                     'fecha_hora_registro': row[9],
                     'activo': row[10]} for row in workers]

    # Disconnect from DB
    cur.close()
    conn.close()

    # Return results
    return jsonify(workers_list)


# Get a worker by DNI
@app.route('/mylibrary/workers/<string:dni>', methods=['GET'])
def getWorkerByDNI(dni):

    # Connect to DB
    conn = get_db_connection()
    cur = conn.cursor()

    # Execute queries
    cur.execute('SELECT * FROM trabajador WHERE dni = %s;', (dni,))
    worker = cur.fetchone()

    # Disconnect from DB
    cur.close()
    conn.close()

    # Check if worker is not found
    if worker is None:
        return jsonify({'error': f"Worker with DNI {dni} not found"}), 404

    # Return results
    return jsonify({'dni': worker[0],
                     'nombre': worker[1],
                     'apellido1': worker[2],
                     'apellido2': worker[3],
                     'fecha_nacimiento': worker[4],
                     'nombre_usuario': worker[5],
                     'sexo': worker[6],
                     'contrasena': worker[7],
                     'edad': worker[8],
                     'fecha_hora_registro': worker[9],
                     'activo': worker[10]})


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
        return jsonify({'error': f"Delivery with ID {id} not found"}), 404

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











@app.route('/select')
def index():
    conn = get_db_connection()
    cur = conn.cursor()
    cur.execute('SELECT * FROM books;')
    books = cur.fetchall()
    cur.close()
    conn.close()
    return render_template('index.html', books=books)

@app.route('/create/', methods=('GET', 'POST'))
def create():
    if request.method == 'POST':
        title = request.form['title']
        author = request.form['author']
        pages_num = int(request.form['pages_num'])
        review = request.form['review']

        conn = get_db_connection()
        cur = conn.cursor()
        cur.execute('append INTO books (title, author, pages_num, review)'
                    'VALUES (%s, %s, %s, %s)',
                    (title, author, pages_num, review))
        conn.commit()
        cur.close()
        conn.close()
        return redirect(url_for('index'))

    return render_template('create.html')

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080)