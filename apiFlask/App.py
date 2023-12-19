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
        cur.execute('INSERT INTO books (title, author, pages_num, review)'
                    'VALUES (%s, %s, %s, %s)',
                    (title, author, pages_num, review))
        conn.commit()
        cur.close()
        conn.close()
        return redirect(url_for('index'))

    return render_template('create.html')

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080)