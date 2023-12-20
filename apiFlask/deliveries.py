# deliveries.py

from flask import jsonify, request
from App import get_db_connection
import re
from psycopg2 import Error


# Return All deliveries
def returnAllDeliveries():
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
                            'idArticulo': row[1],
                            'dniTrabajador': row[2],
                            'idUsuarioAdulto': row[3],
                            'fchInicio': row[5],
                            'fchFin': row[6],
                            'fchDevolucion': row[7],
                            'vigente': row[8]})
        else:
            deliveries_list.append({'id': row[0],
                            'idArticulo': row[1],
                            'dniTrabajador': row[2],
                            'idiUsuarioMenor': row[4],
                            'fchInicio': row[5],
                            'fchFin': row[6],
                            'fchDevolucion': row[7],
                            'vigente': row[8]})

    # Disconnect from DB
    cur.close()
    conn.close()

    # Return results
    return jsonify(deliveries_list)

# Return a delivery By ID
def returnADeliveryById(id):

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
        return jsonify({'error': f'prestacion con ID {id} no encontrada'}), 404

    # Return results
    return jsonify({'id': delivery[0],
                     'idArticulo': delivery[1],
                     'dniTrabajador': delivery[2],
                     'idUsuarioAdulto': delivery[3],
                     'idUsuarioMenor': delivery[4],
                     'fchInicio': delivery[5],
                     'fchFin': delivery[6],
                     'fchDevolucion': delivery[7],
                     'vigente': delivery[8]})

# Return all deliveries by Article ID
def returnAllDeliveryByArticleId(id):

    # Connect to DB
    conn = get_db_connection()
    cur = conn.cursor()

    # Execute queries
    cur.execute('SELECT * FROM prestacion WHERE idArticulo = %s;', (id,))
    deliveries = cur.fetchall()

    # Convert to JSON format
    deliveries_list = []

    # Check what user id is null
    for row in deliveries:
        if (row[3] is not None):
            deliveries_list.append({'id': row[0],
                            'idArticulo': row[1],
                            'dniTrabajador': row[2],
                            'idUsuarioAdulto': row[3],
                            'fchInicio': row[5],
                            'fchFin': row[6],
                            'fchDevolucion': row[7],
                            'vigente': row[8]})
        else:
            deliveries_list.append({'id': row[0],
                            'idArticulo': row[1],
                            'dniTrabajador': row[2],
                            'idiUsuarioMenor': row[4],
                            'fchInicio': row[5],
                            'fchFin': row[6],
                            'fchDevolucion': row[7],
                            'vigente': row[8]})

    # Disconnect from DB
    cur.close()
    conn.close()

    # Return results
    return jsonify(deliveries_list)

# Return all deliveries by Worker DNI
def returnAllDeliveryByWorkerDNI(dni):

    # Connect to DB
    conn = get_db_connection()
    cur = conn.cursor()

    # Execute queries
    cur.execute('SELECT * FROM prestacion WHERE dniTrabajador = %s;', (dni,))
    deliveries = cur.fetchall()

    # Convert to JSON format
    deliveries_list = []

    # Check what user id is null
    for row in deliveries:
        if (row[3] is not None):
            deliveries_list.append({'id': row[0],
                            'idArticulo': row[1],
                            'dniTrabajador': row[2],
                            'idUsuarioAdulto': row[3],
                            'fchInicio': row[5],
                            'fchFin': row[6],
                            'fchDevolucion': row[7],
                            'vigente': row[8]})
        else:
            deliveries_list.append({'id': row[0],
                            'idArticulo': row[1],
                            'dniTrabajador': row[2],
                            'idiUsuarioMenor': row[4],
                            'fchInicio': row[5],
                            'fchFin': row[6],
                            'fchDevolucion': row[7],
                            'vigente': row[8]})

    # Disconnect from DB
    cur.close()
    conn.close()

    # Return results
    return jsonify(deliveries_list)

# Create a delivery
def createDelivery():
    # Get data from the request
    data = request.get_json()
    
    # Extract data
    idArticulo = data.get('idArticulo')
    dniTrabajador = data.get('dniTrabajador')
    idUsuarioAdulto = data.get('idUsuarioAdulto')
    idUsuarioMenor = data.get('idUsuarioMenor')

    # Connect to DB
    conn = get_db_connection()
    cur = conn.cursor()
    
    # Validate data
    if idArticulo is None or dniTrabajador is None or (idUsuarioAdulto is None and idUsuarioMenor is None):
        return jsonify({'error': 'el id del articulo, el dni del trabajador y el id de algun usuario deben especificarse'}), 400
    
    if not isinstance(idArticulo, int) or idArticulo <= 0:
        return jsonify({'error': 'idArticulo debe ser un entero mayor que cero'}), 400
    
    dni_pattern = re.compile(r'^\d{8}[A-Za-z]$')
    if not dni_pattern.match(dniTrabajador):
        return jsonify({'error': 'dniTrabajador debe tener 8 dígitos seguidos por una letra mayúscula o minúscula'}), 400

    if idUsuarioAdulto is not None and (not isinstance(idUsuarioAdulto, int) or idUsuarioAdulto <= 0):
        return jsonify({'error': 'idUsuarioAdulto debe ser un entero mayor que cero'}), 400
    
    if idUsuarioMenor is not None and (not isinstance(idUsuarioMenor, int) or idUsuarioMenor <= 0):
        return jsonify({'error': 'idUsuarioMenor debe ser un entero mayor que cero'}), 400
    
    cur.execute('SELECT id FROM articulo WHERE id = %s', (idArticulo,))
    articleData = cur.fetchone()
    if not articleData:
        return jsonify({'error': f'el articulo introducido no existe'}), 404
    
    cur.execute('SELECT dni FROM trabajador WHERE dni = %s', (dniTrabajador,))
    workerData = cur.fetchone()
    if not workerData:
        return jsonify({'error': f'el trabajador introducido no existe'}), 404
    
    if idUsuarioMenor is not None:
        cur.execute('SELECT id FROM usuarioMenor WHERE id = %s', (idUsuarioAdulto,))
        adultUsereData = cur.fetchone()
        if not adultUsereData:
            return jsonify({'error': f'el usuario adulto introducido no existe'}), 404
    
    if idUsuarioMenor is not None:
        cur.execute('SELECT id FROM usuarioAdulto WHERE id = %s', (idUsuarioMenor,))
        minorUserData = cur.fetchone()
        if not minorUserData:
            return jsonify({'error': f'el usuario menor introducido no existe'}), 404
    
    # Execute queries
    try:
        cur.execute('INSERT INTO prestacion (idArticulo, dniTrabajador, idUsuarioAdulto, idUsuarioMenor) VALUES (%s, %s, %s, %s) RETURNING *;',(idArticulo, dniTrabajador, idUsuarioAdulto, idUsuarioMenor))
        delivery = cur.fetchone()
        
        # Commit the transaction
        conn.commit()
    except Error as e:
        error_message = str(e)
        return jsonify({'error': error_message}), 400

    # Disconnect from DB
    cur.close()
    conn.close()
    
    # Return results
    return jsonify({'id': delivery[0],
                     'idArticulo': delivery[1],
                     'dniTrabajador': delivery[2],
                     'idUsuarioAdulto': delivery[3],
                     'idUsuarioMenor': delivery[4],
                     'fchInicio': delivery[5],
                     'fchFin': delivery[6],
                     'fchDevolucion': delivery[7],
                     'vigente': delivery[8]}), 201