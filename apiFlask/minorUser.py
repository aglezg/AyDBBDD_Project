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

  cur.execute('SELECT * FROM usuariomenor INNER JOIN tarjetasocio on usuariomenor.idtarjetasocio = tarjetasocio.id %s;', (id,))
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