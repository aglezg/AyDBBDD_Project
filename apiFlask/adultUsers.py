from flask import jsonify, request
from App import get_db_connection

def returnAllAdultUsers():
  conn = get_db_connection()
  cur = conn.cursor()

  cur.execute('SELECT * FROM usuarioadulto;',)
  workers = cur.fetchall()

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

  cur.close()
  conn.close()

  return jsonify(adult_users_list)