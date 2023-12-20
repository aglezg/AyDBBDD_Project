# workers.py

from flask import jsonify
from App import get_db_connection


# Return all workers
def returnAllWorkers():

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
                     # 'contrasena': row[7], Password censored
                     'contrasena': '[no disponible]',
                     'edad': row[8],
                     'fecha_hora_registro': row[9],
                     'activo': row[10]} for row in workers]

    # Disconnect from DB
    cur.close()
    conn.close()

    # Return results
    return jsonify(workers_list)

# Return a worker by DNI
def returnWorkerByDNI(dni):

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
        return jsonify({'error': f'trabajador con DNI {dni} no encontrado'}), 404

    # Return results
    return jsonify({'dni': worker[0],
                     'nombre': worker[1],
                     'apellido1': worker[2],
                     'apellido2': worker[3],
                     'fecha_nacimiento': worker[4],
                     'nombre_usuario': worker[5],
                     'sexo': worker[6],
                     # 'contrasena': row[7], Password censored
                     'contrasena': '[no disponible]',
                     'edad': worker[8],
                     'fecha_hora_registro': worker[9],
                     'activo': worker[10]})
