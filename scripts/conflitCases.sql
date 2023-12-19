-- Tabla articulo
-- Stock Negativo
INSERT INTO articulo (titulo, tipo, subtitulo, fchPublicacion, portada, stock) 
VALUES 
  ('Articulo_1','libro','Subtitulo_1', '2022-10-01', E'\\x89504e470d0a1a0a0000', -1);

-- Tipo de Articulo erroneo
INSERT INTO articulo (titulo, tipo, subtitulo, fchPublicacion, portada, stock) 
VALUES 
  ('Articulo_1','OtroTipo','Subtitulo_1', '2022-10-01', E'\\x89504e470d0a1a0a0000', 1);

-- Fecha de publicacion de articulo mayor que fecha actual
INSERT INTO articulo (titulo, tipo, subtitulo, fchPublicacion, portada, stock) 
VALUES 
  ('Articulo_1','libro','Subtitulo_1', '2099-10-01', E'\\x89504e470d0a1a0a0000', 1);


-- Tabla generoArticulo
-- Genero no Existente
INSERT INTO generoArticulo (idArticulo, genero) 
VALUES
  (2, 'OtroGenero');

-- Evitar Duplicidad de Datos
INSERT INTO generoArticulo (idArticulo, genero) 
VALUES 
  (1, 'Historia'),
  (1, 'Historia');

-- Tabla libro
-- Introducir un libro cuyo idArticulo no se encuentre en Articulo
INSERT INTO libro (idArticulo, editorial, numPaginas, estilo, sinopsis, idAutor)
VALUES 
  (0, 'Editorial1', 300, 'Narrativo', 'Sinopsis del libro 1', 1);

-- Evitar Duplicidad de Datos
INSERT INTO libro (idArticulo, editorial, numPaginas, estilo, sinopsis, idAutor)
VALUES 
  (1, 'Editorial1', 300, 'Narrativo', 'Sinopsis del libro 1', 1),
  (1, 'Editorial1', 300, 'Narrativo', 'Sinopsis del libro 1', 1);

-- Insertar un articulo que no sea de tipo libro en la tabla libro
INSERT INTO libro (idArticulo, editorial, numPaginas, estilo, sinopsis, idAutor)
VALUES 
  (11, 'Editorial1', 300, 'Lirico', 'Recopilación de noticias ', 1);

-- Tabla materialPeriodico
-- Insertar un Libro en la tabla materialPeriodico
INSERT INTO materialPeriodico (idArticulo, editorial, numPaginas, tipo)
VALUES 
  (1, 'Editorial3', 20, 'Libro');

-- Tabla materialAudiovisual
-- Insertar cualquier artículo que no sea audiovisual (Pelicula, Documental, Serie)
INSERT INTO materialAudiovisual (idArticulo, duracion, categoria, tipo)
VALUES 
  (1, '02:30:00', 'Libro', 'DVD');

-- Tabla autor_materialAudiovisual
-- Evitar Duplicidad de Datos
INSERT INTO autor_materialAudiovisual (idMaterialAudiovisual, idAutor)
VALUES 
  (21, 25),
  (21, 25);

-- Tabla trabajadores
-- Evitar Introducir un DNI con un formato no aceptado
INSERT INTO trabajador (dni, nombre, apellido1, apellido2, fchNacimiento, nombreUsuario, sexo, contrasena, edad, fchHoraRegistro)
VALUES 
  ('X999BX', 'Tester', 'Tester', 'Tester', '1990-05-15', 'userTester', 'M', 'psswdTester', 32, '2013-11-18 09:30:00');

-- No existe un trabajador cuya fecha de registro sea superior a su fecha de nacimiento
INSERT INTO trabajador (dni, nombre, apellido1, apellido2, fchNacimiento, nombreUsuario, sexo, contrasena, edad, fchHoraRegistro)
VALUES 
  ('99999999X', 'Tester', 'Tester', 'Tesster', '2000-05-15', 'userTester', 'M', 'psswdTester', 32, '1950-11-18 09:30:00');

-- Trabajador con contraseña vacía
INSERT INTO trabajador (dni, nombre, apellido1, apellido2, fchNacimiento, nombreUsuario, sexo, contrasena, edad, fchHoraRegistro)
VALUES 
  ('99999999X', 'Tester', 'Tester', 'Tesster', '1990-05-15', 'userTester', 'M', NULL, 32, '2013-11-18 09:30:00');

-- Evitar nombres de usuarios repetidos;
INSERT INTO trabajador (dni, nombre, apellido1, apellido2, fchNacimiento, nombreUsuario, sexo, contrasena, edad, fchHoraRegistro)
VALUES 
  ('09999999X', 'Tester', 'Tester', 'Tesster', '1990-05-15', 'juanito123', 'M', 'psswdTester', 32, '2013-11-18 09:30:00');

-- Tabla Teléfonos 
-- No existen dos números repetidos 
INSERT INTO telefonoTrabajador (dniTrabajador, telefono)
VALUES
  ('12345678A', '987654321'),
  ('34567890F', '987654321');