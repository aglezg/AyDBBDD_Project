from flask import jsonify, request
from App import get_db_connection
import base64
from articles import removeArticleByID

def returnAllNewspapers():
  conn = get_db_connection()
  cur = conn.cursor()
  #code 
  cur.execute('SELECT * FROM articulo INNER JOIN materialperiodico ON articulo.id = materialperiodico.idarticulo;')
  newspaper = cur.fetchall()

  newspaper_list = [{'id': row[0],
                      'tipo': row[1],
                      'titulo': row[2],
                      'subtitulo': row[3],
                      'fchPublicacion': row[4],
                      'portada': base64.b64encode(row[5]).decode('utf-8') if row[5] else None,
                      'stock': row[6],
                      'disponible': row[7],
                      'editorial': row[9],
                      'numPaginas': row[10],
                      'tipo': row[11]} for row in newspaper]
  cur.close()
  conn.close()
  return jsonify( newspaper_list )

def returnNewspaperByID(id):

  conn = get_db_connection()
  cur = conn.cursor()

  cur.execute('SELECT * FROM articulo INNER JOIN materialperiodico ON articulo.id = materialperiodico.idarticulo where id = %s;',(id,))
  newspaper = cur.fetchone()

  if newspaper is None:
        return jsonify({'error': f'articulo periodico con ID {id} no encontrado'}), 404

  return jsonify({'id': newspaper[0],
                      'tipo': newspaper[1],
                      'titulo': newspaper[2],
                      'subtitulo': newspaper[3],
                      'fchPublicacion': newspaper[4],
                      'portada': base64.b64encode(newspaper[5]).decode('utf-8') if newspaper[5] else None,
                      'stock': newspaper[6],
                      'disponible': newspaper[7],
                      'editorial': newspaper[9],
                      'numPaginas': newspaper[10],
                      'tipo': newspaper[11]})

def returnNewspaperByTitle(title):

  conn = get_db_connection()
  cur = conn.cursor()

  cur.execute('SELECT * FROM articulo INNER JOIN materialperiodico ON articulo.id = materialperiodico.idarticulo where titulo = %s;',(title,))
  newspaper = cur.fetchone()

  if newspaper is None:
        return jsonify({'error': f'articulo periodico titulado {title} no encontrado'}), 404
  
  return jsonify({'id': newspaper[0],
                      'tipo': newspaper[1],
                      'titulo': newspaper[2],
                      'subtitulo': newspaper[3],
                      'fchPublicacion': newspaper[4],
                      'portada': base64.b64encode(newspaper[5]).decode('utf-8') if newspaper[5] else None,
                      'stock': newspaper[6],
                      'disponible': newspaper[7],
                      'editorial': newspaper[9],
                      'numPaginas': newspaper[10],
                      'tipo': newspaper[11]})