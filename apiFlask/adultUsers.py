from flask import jsonify, request
from App import get_db_connection
from datetime import datetime
import re

def returnAllAdultUsers():
  conn = get_db_connection()
  cur = conn.cursor()

  cur.execute('SELECT * FROM usuarioadulto;',)
  user = cur.fetchall()

  adult_users_list = [{'id': user[0],
                    'nombre': user[1],
                    'apellido1': user[2],
                    'apellido2': user[3],
                    'fecha_nacimiento': user[4],
                    'fecha_hora_registro': user[5],
                    'sexo': user[6],
                    'edad': user[7],
                    'dni': user[8],
                    'estudiante': user[9]} for user in user]

  cur.close()
  conn.close()

  return jsonify(adult_users_list)

def returnUserByID(id):
  conn = get_db_connection()
  cur = conn.cursor()

  cur.execute('SELECT * FROM usuarioadulto where id = %s;', (id,))
  user = cur.fetchone()

  cur.close()
  conn.close()

  if user is None:
        return jsonify({'error': f'Adulto con ID {id} no encontrado'}), 404
  
  return jsonify({'id': user[0],
                    'nombre': user[1],
                    'apellido1': user[2],
                    'apellido2': user[3],
                    'fecha_nacimiento': user[4],
                    'fecha_hora_registro': user[5],
                    'sexo': user[6],
                    'edad': user[7],
                    'dni': user[8],
                    'estudiante': user[9]}), 200

def returnUserByDNI(dni):
  conn = get_db_connection()
  cur = conn.cursor()

  cur.execute('SELECT * FROM usuarioadulto WHERE dni = %s;', (dni,))
  user = cur.fetchone()

  cur.close()
  conn.close()

  if user is None:
      return jsonify({'error': f'usuario con DNI {dni} no encontrado'}), 404
  
  return jsonify({'id': user[0],
                    'nombre': user[1],
                    'apellido1': user[2],
                    'apellido2': user[3],
                    'fecha_nacimiento': user[4],
                    'fecha_hora_registro': user[5],
                    'sexo': user[6],
                    'edad': user[7],
                    'dni': user[8],
                    'estudiante': user[9]}), 200

def createUser():
  data = request.get_json()
  nombre = data.get('nombre')
  apellido1 = data.get('apellido1')
  apellido2 = data.get('apellido2')
  fchNacimiento = data.get('fchNacimiento')
  sexo = data.get('sexo')
  edad = data.get('edad')
  dni = data.get('dni')
  estudiante = data.get('estudiante')

  conn = get_db_connection()
  cur = conn.cursor()

  if nombre is None or apellido1 is None or fchNacimiento is None or dni is None or estudiante is None: 
     return jsonify({'ERROR':'ALgunos de los campos nombre, primer apellido, fecha de nacimiento, dni o estudiante no fueron especificados'}), 400
  
  dateNow = datetime.now()
  dateFormat = "%Y-%m-%d"
  CURRENT_DATE = dateNow.strftime(dateFormat)
  if (fchNacimiento > CURRENT_DATE):
     return jsonify({'ERROR': 'Fecha de Nacimiento inválida'})
  
  pattern = r'\d{8}[A-Za-z]$'
  evaluateDNI = re.match(pattern, dni)
  if not evaluateDNI:
     return jsonify({'ERROR': 'Formato DNI no válido'})

  cur.execute('INSERT INTO usuarioAdulto (nombre, apellido1, apellido2, fchNacimiento, sexo, dni, estudiante) VALUES (%s, %s, %s, %s, %s, %s, %s) RETURNING*;', (nombre, apellido1, apellido2, fchNacimiento, sexo, dni, estudiante))
  
  user = cur.fetchone()

  conn.commit()

  cur.close()
  conn.close()

  return jsonify({'id': user[0],
                    'nombre': user[1],
                    'apellido1': user[2],
                    'apellido2': user[3],
                    'fecha_nacimiento': user[4],
                    'fecha_hora_registro': user[5],
                    'sexo': user[6],
                    'edad': user[7],
                    'dni': user[8],
                    'estudiante': user[9]}), 200

def updateUser(id):
  data = request.get_json()

  conn = get_db_connection()
  cur = conn.cursor()

  #validate data
  dateNow = datetime.now()
  dateFormat = "%Y-%m-%d"
  CURRENT_DATE = dateNow.strftime(dateFormat)
  if data.get('fchNacimiento') is not None and data.get('fchNacimiento') > CURRENT_DATE:
     return jsonify({'ERROR': 'fecha nacimiento no valida'}), 400
  
  pattern = r'\d{8}[A-Za-z]$'
  if data.get('dni') is not None and not re.match(pattern, data.get('dni')):
     return jsonify({'ERROR': 'formato de DNI no valido'}), 400
     
  allowed_gender = ['M', 'F', 'O']
  if data.get('sexo') is not None and data.get('sexo') not in allowed_gender:
     return jsonify({'ERROR': f'el valor del genero tiene que ser uno de los siguientes: {", ".join(allowed_gender)}'}), 400
  
  cur.execute('SELECT * FROM usuarioadulto WHERE id = %s', (id,))
  userCheckByID = cur.fetchone()
  if not userCheckByID:
     return jsonify({'ERROR': 'El usuario no existe'}), 400
  
  query = 'UPDATE usuarioadulto SET '
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

  if data.get('sexo') is not None:
     query += 'sexo = %s, '
     parameters.append(data.get('sexo'))

  if data.get('dni') is not None:
     query += 'dni = %s, '
     parameters.append(data.get('dni'))

  if data.get('estudiante') is not None:
     query += 'estudiante = %s, '
     parameters.append(data.get('estudiante'))

  if parameters:
        # Remove the trailing comma and space
        query = query.rstrip(', ')
        # Add the WHERE clause for the specific book_id
        query += ' WHERE id = %s RETURNING id;'
        parameters.append(id)
        cur.execute(query, tuple(parameters))
        # Commit the transaction
        conn.commit()

  cur.execute('SELECT * from usuarioadulto WHERE id = %s;', (id,))
  user = cur.fetchone()

  conn.commit()

  cur.close()
  conn.close()

  if user: 
     return jsonify({'id': user[0],
                    'nombre': user[1],
                    'apellido1': user[2],
                    'apellido2': user[3],
                    'fecha_nacimiento': user[4],
                    'fecha_hora_registro': user[5],
                    'sexo': user[6],
                    'edad': user[7],
                    'dni': user[8],
                    'estudiante': user[9]}), 200
  else:
    return jsonify({'mensaje': 'No se ha efectuado ningun cambio'}), 200

def removeAdultUser(id):
  conn = get_db_connection()
  cur = conn.cursor()
  
  cur.execute('DELETE FROM usuarioadulto WHERE id = %s RETURNING *;',(id,))
  user = cur.fetchone()

  conn.commit()
  
  cur.close()
  conn.close()

  if user is None:
        return jsonify({'ERROR': f'usuario con ID {id} no encontrado'}), 404
  
  return jsonify({'mensaje': 'Usuario borrado satisfactoriamente',
                  'id': user[0],
                    'nombre': user[1],
                    'apellido1': user[2],
                    'apellido2': user[3],
                    'fecha_nacimiento': user[4],
                    'fecha_hora_registro': user[5],
                    'sexo': user[6],
                    'edad': user[7],
                    'dni': user[8],
                    'estudiante': user[9]})

def removeUserByDNI(dni):
  conn = get_db_connection()
  cur = conn.cursor()
  
  cur.execute('DELETE FROM usuarioadulto WHERE dni = %s RETURNING *;',(dni,))
  user = cur.fetchone()

  conn.commit()
  
  cur.close()
  conn.close()

  if user is None:
        return jsonify({'ERROR': f'usuario con ID {dni} no encontrado'}), 404
  
  return jsonify({'mensaje': 'Usuario borrado satisfactoriamente',
                  'id': user[0],
                    'nombre': user[1],
                    'apellido1': user[2],
                    'apellido2': user[3],
                    'fecha_nacimiento': user[4],
                    'fecha_hora_registro': user[5],
                    'sexo': user[6],
                    'edad': user[7],
                    'dni': user[8],
                    'estudiante': user[9]})