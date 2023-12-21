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

# Newspapers routes
@app.route('/mylibrary/articulos/newspapers', methods=['GET'])
def getAllNewspapers():
    from newspapers import returnAllNewspapers
    return returnAllNewspapers()

@app.route('/mylibrary/articulos/newspapers/id/<int:id>', methods=['GET'])
def getNewspaperByID(id):
    from newspapers import returnNewspaperByID
    return returnNewspaperByID(id)

@app.route('/mylibrary/articulos/newspapers/titulo/<string:title>', methods=['GET'])
def getNewspaperByTitle(title):
    from newspapers import returnNewspaperByTitle
    return returnNewspaperByTitle(title)

# Workers routes
@app.route('/mylibrary/trabajadores', methods=['GET'])
def getAllWorkers():
    from workers import returnAllWorkers
    return returnAllWorkers()

@app.route('/mylibrary/trabajadores/dni/<string:dni>', methods=['GET'])
def getWorkerByDNI(dni):
    from workers import returnWorkerByDNI
    return returnWorkerByDNI(dni)

# Adult Users
@app.route('/mylibrary/usuarioAdulto', methods=['GET'])
def getAllAdultUsers():
    from adultUsers import returnAllAdultUsers
    return returnAllAdultUsers()

@app.route('/mylibrary/usuarioAdulto/id/<int:id>', methods=['GET'])
def getAdultUserByID(id):
    from adultUsers import returnUserByID
    return returnUserByID(id)

@app.route('/mylibrary/usuarioAdulto/dni/<string:dni>', methods=['GET'])
def getAdultUserByDNI(dni):
    from adultUsers import returnUserByDNI
    return returnUserByDNI(dni)

@app.route('/mylibrary/usuarioAdulto', methods=['POST'])
def postAdultUser():
    from adultUsers import createUser
    return createUser()

@app.route('/mylibrary/usuarioAdulto/id/<int:id>', methods=['PATCH'])
def patchAdultUser(id):
    from adultUsers import updateUser
    return updateUser(id)

@app.route('/mylibrary/usuarioAdulto/id/<int:id>', methods=['DELETE'])
def deleteAdultUser(id):
    from adultUsers import removeAdultUser
    return removeAdultUser(id)

@app.route('/mylibrary/usuarioAdulto/dni/<string:dni>', methods=['DELETE'])
def deleteAdultUserByDNI(dni):
    from adultUsers import removeUserByDNI
    return removeUserByDNI(dni)

# Minor Users routes

@app.route('/mylibrary/usuarioMenor', methods=['GET'])
def getAllMinorUsers():
    from minorUser import returnMinorsUsers
    return returnMinorsUsers()


@app.route('/mylibrary/usuarioMenor/id/<int:id>', methods=['GET'])
def getAllMinorByID(id):
    from minorUser import returnMinorsUsersByID
    return returnMinorsUsersByID(id)

@app.route('/mylibrary/usuarioMenor/id_TarjetaSocio/<int:idTarjeta>', methods=['GET'])
def getUserByIDCard(idTarjeta):
    from minorUser import returnMinorsUsersByIDTarjeta
    return returnMinorsUsersByIDTarjeta(idTarjeta)

@app.route('/mylibrary/usuarioMenor', methods=['POST'])
def postMinorUser():
    from minorUser import createMinorUser
    return createMinorUser()

@app.route('/mylibrary/usuarioMenor/id/<int:id>', methods=['PATCH'])
def patchMinorUser(id):
    from minorUser import updateMinorUser
    return updateMinorUser(id)

@app.route('/mylibrary/usuarioMenor/id/<int:id>', methods=['DELETE'])
def deleteMinorUser(id):
    from minorUser import removeMinorUser
    return removeMinorUser(id)

@app.route('/mylibrary/usuarioMenor/idTarjeta/<int:idTarjeta>', methods=['DELETE'])
def deleteMinorUserByCardID(idTarjeta):
    from minorUser import removeMinorUserByCardID
    return removeMinorUserByCardID(idTarjeta)




# Delivery routes
@app.route('/mylibrary/prestaciones', methods=['GET'])
def getAllDeliveries():
    from deliveries import returnAllDeliveries
    return returnAllDeliveries()

@app.route('/mylibrary/prestaciones/id/<int:id>', methods=['GET'])
def getADeliveryById(id):
    from deliveries import returnADeliveryById
    return returnADeliveryById(id)

@app.route('/mylibrary/prestaciones/articulo/id/<int:id>', methods=['GET'])
def getADeliveryByArticleId(id):
    from deliveries import returnAllDeliveryByArticleId
    return returnAllDeliveryByArticleId(id)

@app.route('/mylibrary/prestaciones/trabajador/dni/<string:dni>', methods=['GET'])
def getADeliveryByWorkerDNI(dni):
    from deliveries import returnAllDeliveryByWorkerDNI
    return returnAllDeliveryByWorkerDNI(dni)

@app.route('/mylibrary/prestaciones', methods=['POST'])
def postADelivery():
    from deliveries import createDelivery
    return createDelivery()

@app.route('/mylibrary/prestaciones/id/<int:id>', methods=['PATCH'])
def patchADeliveryReturnDate(id):
    from deliveries import updateADeliveryReturnDate
    return updateADeliveryReturnDate(id)







if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080)