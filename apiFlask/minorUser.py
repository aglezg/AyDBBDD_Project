from flask import jsonify, request
from App import get_db_connection
from datetime import datetime
import re

def returnMinorsUsers():
  conn = get_db_connection()
  cur = conn.cursor()

  cur.execute('SELECT * FROM usuariomenor;',)
  user = cur.fetchall()

  minor_users_list = [{'id': user[0],
                    'nombre': user[1],
                    'apellido1': user[2],
                    'apellido2': user[3],
                    'fecha_nacimiento': user[4],
                    'fecha_hora_registro': user[5],
                    'sexo': user[6],
                    'edad': user[7],
                    'idTarjetaSocio': user[8]} for user in user]

  cur.close()
  conn.close()

  return jsonify(minor_users_list)

def returnMinorsUsersByID(id):
  conn = get_db_connection()
  cur = conn.cursor()

  cur.execute('SELECT * FROM usuariomenor where id = %s;', (id,))
  user = cur.fetchone()

  cur.close()
  conn.close()

  if user is None:
        return jsonify({'error': f'Usuario menor con ID {id} no encontrado'}), 404
  
  return jsonify({'id': user[0],
                    'nombre': user[1],
                    'apellido1': user[2],
                    'apellido2': user[3],
                    'fecha_nacimiento': user[4],
                    'fecha_hora_registro': user[5],
                    'sexo': user[6],
                    'edad': user[7],
                    'idTarjetaSocio': user[8]}), 200

def returnMinorsUsersByIDTarjeta(idTarjeta):
  conn = get_db_connection()
  cur = conn.cursor()

  cur.execute('SELECT * FROM usuariomenor INNER JOIN tarjetasocio on usuariomenor.idtarjetasocio = tarjetasocio.id  WHERE idtarjetasocio = %s;', (idTarjeta,))
  user = cur.fetchone()

  cur.close()
  conn.close()

  if user is None:
        return jsonify({'error': f'Usuario menor con ID {idTarjeta} no encontrado'}), 404
  
  return jsonify({'id': user[0],
                    'nombre': user[1],
                    'apellido1': user[2],
                    'apellido2': user[3],
                    'fecha_nacimiento': user[4],
                    'fecha_hora_registro': user[5],
                    'sexo': user[6],
                    'edad': user[7],
                    'idTarjetaSocio': user[8]}), 200

def createMinorUser():
  data = request.get_json()

  nombre = data.get('nombre')
  apellido1 = data.get('apellido1')
  apellido2 = data.get('apellido2')
  fchNacimiento = data.get('fchNacimiento')
  sexo = data.get('sexo')
  colorTarjetaSocio = "Rojo"
  if data.get('colorTarjetaSocio') is not None:
    colorTarjetaSocio = data.get('colorTarjetaSocio')

  conn = get_db_connection()
  cur = conn.cursor()


  if nombre is None or apellido1 is None or fchNacimiento is None: 
     return jsonify({'ERROR':'ALgunos de los campos nombre, primer apellido, fecha de nacimiento no fueron especificados'}), 400
  
  dateNow = datetime.now()
  dateFormat = "%Y-%m-%d"
  CURRENT_DATE = dateNow.strftime(dateFormat)
  if (fchNacimiento > CURRENT_DATE):
     return jsonify({'ERROR': 'Fecha de Nacimiento inválida'})

  cur.execute('INSERT INTO tarjetaSocio (color) VALUES(%s) RETURNING id;', (colorTarjetaSocio,))
  idTarjetaSocio = cur.fetchone()[0]

  conn.commit()
  
  cur.execute('INSERT INTO usuariomenor (nombre, apellido1, apellido2, fchNacimiento, sexo, idtarjetasocio) VALUES (%s, %s, %s, %s, %s, %s) RETURNING*;', (nombre, apellido1, apellido2, fchNacimiento, sexo, idTarjetaSocio))
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
                    'idTarjetaSocio': user[8]}), 200

def updateMinorUser(id):
  data = request.get_json()

  conn = get_db_connection()
  cur = conn.cursor()

  dateNow = datetime.now()
  dateFormat = "%Y-%m-%d"
  CURRENT_DATE = dateNow.strftime(dateFormat)
  if data.get('fchNacimiento') is not None and data.get('fchNacimiento') > CURRENT_DATE:
     return jsonify({'ERROR': 'fecha nacimiento no valida'}), 400
  
  allowed_gender = ['M', 'F', 'O']
  if data.get('sexo') is not None and data.get('sexo') not in allowed_gender:
     return jsonify({'ERROR': f'el valor del genero tiene que ser uno de los siguientes: {", ".join(allowed_gender)}'}), 400
  
  cur.execute('SELECT * FROM usuariomenor WHERE id = %s', (id,))
  userCheckByID = cur.fetchone()
  if not userCheckByID:
     return jsonify({'ERROR': 'El usuario no existe'}), 400
  
  query = 'UPDATE usuariomenor SET '
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
  
  if parameters:
        # Remove the trailing comma and space
        query = query.rstrip(', ')
        # Add the WHERE clause for the specific book_id
        query += ' WHERE id = %s RETURNING id;'
        parameters.append(id)
        cur.execute(query, tuple(parameters))
        # Commit the transaction
        conn.commit()

  cur.execute('SELECT * from usuariomenor WHERE id = %s;', (id,))
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
                    'idTarjetaSocio': user[8]}), 200
  else:
    return jsonify({'mensaje': 'No se ha efectuado ningun cambio'}), 200
  
def removeMinorUser(id):
  conn = get_db_connection()
  cur = conn.cursor()
  
  cur.execute('DELETE FROM usuariomenor WHERE id = %s RETURNING *;',(id,))
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
                    'idTarjetaSocio': user[8]})

def removeMinorUserByCardID(idTarjeta):
  conn = get_db_connection()
  cur = conn.cursor()
  
  cur.execute('DELETE FROM usuariomenor WHERE idtarjetasocio = %s RETURNING *;',(idTarjeta,))
  user = cur.fetchone()

  conn.commit()
  
  cur.close()
  conn.close()

  if user is None:
        return jsonify({'ERROR': f'usuario con ID de Tarjeta de Socio {idTarjeta} no encontrado'}), 404
  
  return jsonify({'mensaje': 'Usuario borrado satisfactoriamente',
                  'id': user[0],
                    'nombre': user[1],
                    'apellido1': user[2],
                    'apellido2': user[3],
                    'fecha_nacimiento': user[4],
                    'fecha_hora_registro': user[5],
                    'sexo': user[6],
                    'edad': user[7],
                    'idTarjetaSocio': user[8]})