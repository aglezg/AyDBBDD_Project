/**
-- Inserciones para la tabla 'articulo'
INSERT INTO articulo (titulo, subtitulo, fchPublicacion, portada, stock) 
VALUES 
  ('Articulo 1', 'Subtitulo 1', '2023-11-18', E'\\x012345', true),
  ('Articulo 2', 'Subtitulo 2', '2022-11-17', E'\\x567890', true),
  ('Articulo 3', 'Subtitulo 3', '2014-11-16', E'\\xABCDE', true),
  ('Articulo 4', 'Subtitulo 4', '2019-11-15', E'\\xF1234', true),
  ('Articulo 5', 'Subtitulo 5', '2020-11-14', E'\\x56789', true),
  ('Articulo 6', 'Subtitulo 6', '2020-11-13', E'\\xABCDE', true),
  ('Articulo 7', 'Subtitulo 7', '2023-11-12', E'\\xF1234', false),
  ('Articulo 8', 'Subtitulo 8', '2023-11-11', E'\\x56789', false),
  ('Articulo 9', 'Subtitulo 9', '2011-11-10', E'\\xABCDE', false),
  ('Articulo 10', 'Subtitulo 10', '2010-11-09', E'\\xF1234', false),

-- Inserciones para la tabla 'generoArticulo'
INSERT INTO generoArticulo (idArticulo, genero) 
VALUES 
  (1, 'Novela'),
  (1, 'Fantasia'),
  (2, 'Aventura'),
  (2, 'Suspense'),
  (3, 'Aventura'),
  (3, 'Romance'),
  (4, 'Ciencia-Ficcion'),
  (4, 'Misterio'),
  (5, 'Historia'),
  (5, 'Accion'),
  (6, 'Comedia'),
  (6, 'Romance'),
  (7, 'Fantasia'),
  (7, 'Distopia'),
  (8, 'Suspense'),
  (8, 'Thriller'),
  (9, 'Melodrama'),
  (9, 'Ciencia-Ficcion'),
  (10, 'Terror'),
  (10, 'Infantil');

-- Inserciones para la tabla 'autor'
INSERT INTO autor (nombre, apellido1, apellido2, fchNacimiento, fchMuerte, sexo, edad)
VALUES 
  ('Autor1', 'Apellido1', 'Apellido2', '1990-01-01', NULL, 'M', 33),
  ('Autor2', 'Apellido1', 'Apellido2', '1985-02-15', NULL, 'F', 38),
  ('Autor3', 'Apellido1', 'Apellido2', '1970-03-20', NULL, 'M', 53),
  ('Autor4', 'Apellido1', 'Apellido2', '1982-04-25', NULL, 'F', 41),
  ('Autor5', 'Apellido1', 'Apellido2', '1965-06-10', '2015-08-30', 'M', 50),
  ('Autor6', 'Apellido1', 'Apellido2', '1995-09-15', NULL, 'F', 28),
  ('Autor7', 'Apellido1', 'Apellido2', '1988-10-01', NULL, 'M', 35),
  ('Autor8', 'Apellido1', 'Apellido2', '1975-11-12', '2010-12-31', 'F', 35),
  ('Autor9', 'Apellido1', 'Apellido2', '1986-12-03', NULL, 'M', 36),
  ('Autor10', 'Apellido1', 'Apellido2', '1990-02-28', NULL, 'F', 31);

-- Inserciones para la tabla 'libro'
INSERT INTO libro (idArticulo, editorial, numPaginas, estilo, sinopsis, idAutor)
VALUES 
  (1, 'Editorial1', 300, 'Narrativo', 'Sinopsis del libro 1', 1),
  (2, 'Editorial2', 250, 'Dramatico', 'Sinopsis del libro 2', 2),
  (3, 'Editorial3', 280, 'Lirico', 'Sinopsis del libro 3', 3),
  (4, 'Editorial4', 320, 'Epico', 'Sinopsis del libro 4', 4),
  (5, 'Editorial5', 200, 'Narrativo', 'Sinopsis del libro 5', 5),
  (6, 'Editorial6', 180, 'Poetico', 'Sinopsis del libro 6', 6),
  (7, 'Editorial7', 240, 'Didactico', 'Sinopsis del libro 7', 7),
  (8, 'Editorial8', 300, 'Satirico', 'Sinopsis del libro 8', 8),
  (9, 'Editorial9', 260, 'Lirico', 'Sinopsis del libro 9', 9),
  (10, 'Editorial10', 220, 'Dramatico', 'Sinopsis del libro 10', 10);

-- Inserciones para la tabla 'materialPeriodico'
INSERT INTO materialPeriodico (idArticulo, editorial, numPaginas, tipo)
VALUES 
  (3, 'Editorial3', 20, 'Periodico'),
  (4, 'Editorial4', 15, 'Revista'),
  (6, 'Editorial6', 15, 'Revista'),
  (7, 'Editorial7', 20, 'Periodico'),
  (8, 'Editorial8', 25, 'Periodico'),
  (9, 'Editorial9', 18, 'Revista'),
  (10, 'Editorial10', 22, 'Periodico');

-- Inserciones para la tabla 'materialAudiovisual'
INSERT INTO materialAudiovisual (idArticulo, duracion, categoria, tipo)
VALUES 
  (5, '02:30:00', 'Pelicula', 'DVD'),
  (6, '01:45:00', 'Serie', 'CD'),
  (8, '01:30:00', 'Serie', 'DVD'),
  (9, '02:15:00', 'Pelicula', 'CD'),
  (10, '01:45:00', 'Documental', 'DVD');

-- Inserciones para la tabla 'autor_materialAudiovisual'
INSERT INTO autor_materialAudiovisual (idMaterialAudiovisual, idAutor)
VALUES 
  (5, 3),
  (6, 4),
  (8, 4),
  (9, 5),
  (10, 6);
*/
