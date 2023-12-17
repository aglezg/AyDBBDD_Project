-- Inserciones para la tabla 'articulo'
INSERT INTO articulo (titulo, tipo, subtitulo, fchPublicacion, portada, stock)) 
VALUES 
  ('Historia del Arte Moderno','libro','Una exploración de las corrientes artísticas del siglo XX', '2022-10-15',
   E'\\x89504e470d0a1a0a0000',
   1),
  ('Recetas de Cocina Tradicional','libro', 'Platos caseros y deliciosos', '2021-08-25',
   E'\\x89504e470d0a1a0a0000',
   1),
  ('Viaje al Centro de la Tierra','libro', 'Una emocionante novela de aventuras', '2020-05-12',
   E'\\x89504e470d0a1a0a0000',
   1),
  ('Guía Práctica de Programación','libro', 'Conceptos esenciales para aprender a programar', '2023-01-30',
   E'\\x89504e470d0a1a0a0000',
   1),
  ('Misterios del Universo','libro', 'Explorando los secretos del cosmos', '2022-06-08',
   E'\\x89504e470d0a1a0a0000',
   1),
  ('Aventuras en la Selva','libro', 'Descubre la fauna y flora de la jungla', '2019-12-05',
   E'\\x89504e470d0a1a0a0000',
   1),
  ('Economía Global','libro', 'Análisis de los mercados y tendencias económicas', '2021-04-20',
   E'\\x89504e470d0a1a0a0000',
   1),
  ('Arquitectura Contemporánea','libro', 'Explorando los diseños innovadores', '2020-09-15',
   E'\\x89504e470d0a1a0a0000',
   1),
  ('Cocina Internacional','libro', 'Sabores del mundo en tu mesa', '2018-07-03',
   E'\\x89504e470d0a1a0a0000',
   1),
  ('El Misterio de la Isla Perdida','libro', 'Una novela de intriga y suspense', '2023-03-10',
   E'\\x89504e470d0a1a0a0000',
   1),
  ('Noticias del Día','materialPeriodico', 'Resumen de los eventos actuales', '2023-11-18', E'\\x89504e470d0a1a0a0096', 1),
  ('El Periódico Semanal','materialPeriodico', 'Recopilación de noticias destacadas', '2023-11-17', E'\\x89504e470d0a1a0a0025', 1),
  ('Economía Hoy','materialPeriodico', 'Análisis financiero y económico', '2023-11-16', E'\\xABC2DE', 120),
  ('Cultura y Espectáculos','materialPeriodico', 'Lo último en arte y entretenimiento', '2023-11-15', E'\\x89504e470d0a1a0a0034', 1),
  ('Ciencia y Tecnología','materialPeriodico', 'Avances y descubrimientos científicos', '2023-11-14', E'\\x89504e470d0a1a0a0023', 1),
  ('Revista de Ciencia','materialPeriodico', 'Explorando los avances científicos', '2023-11-18', E'\\x89504e470d0a1a0a0043', 80),
  ('Revista de Moda','materialPeriodico', 'Tendencias y estilos de la temporada', '2023-11-17', E'\\x89504e470d0a3a0a0023', 100),
  ('Revista de Viajes','materialPeriodico', 'Destinos increíbles y consejos de viaje', '2023-11-16', E'\\x89504e470d0a1a0a0043', 120),
  ('Revista de Tecnología','materialPeriodico', 'Lo último en gadgets y novedades tecnológicas', '2023-11-15', E'\\x89504e470d0a1a0a0021', 90),
  ('Revista de Cine','materialPeriodico', 'Críticas y novedades del mundo del cine', '2023-11-14', E'\\x89504e470d0a1a0a0022', 70),
  ('Interstellar','materialAudiovisual', 'Explorando el espacio profundo', '2014-11-07', E'\\x895043B70d0a1a0a0022', 5),
  ('Planet Earth II','materialAudiovisual', 'Una exploración visual de la naturaleza', '2016-11-06', E'\\x895043470A0a1a0a0022', 3),
  ('Stranger Things','materialAudiovisual', 'Aventuras sobrenaturales en los años 80', '2016-07-15', E'\\x895043460d0a1a0a0022', 8),
  ('The Shawshank Redemption','materialAudiovisual', 'La esperanza prevalece en prisión', '1994-09-23', E'\\x895053470d0a1a0a0022', 2),
  ('Blue Planet II','materialAudiovisual', 'Explorando los océanos del mundo', '2017-11-18', E'\\x892043470d0a1a0a0022', 6);



-- Inserciones para la tabla 'generoArticulo'
INSERT INTO generoArticulo (idArticulo, genero) 
VALUES 
  (7, 'Historia'),
  (8, 'Fantasia'),
  (8, 'Aventura'),
  (9, 'Suspense'),
  (9, 'Aventura'),
  (10, 'Romance'),
  (11, 'Ciencia-Ficcion'),
  (12, 'Misterio'),
  (12, 'Historia'),
  (13, 'Accion'),
  (14, 'Comedia'),
  (15, 'Romance'),
  (16, 'Fantasia'),
  (16, 'Distopia');

-- Inserciones para la tabla 'autor'
INSERT INTO autor (nombre, apellido1, apellido2, fchNacimiento, fchMuerte, sexo)
VALUES 
  ('Juan', 'Pérez', 'González', '1980-05-15', NULL, 'M'),
  ('María', 'López', 'Martínez', '1992-11-28', NULL, 'F'),
  ('Carlos', 'Ruiz', 'Fernández', '1975-07-10', '2022-06-30', 'M'),
  ('Ana', 'García', 'Sánchez', '1988-03-20', NULL, 'F'),
  ('Pedro', 'Rodríguez', 'Vega', '1960-09-05', '2018-12-18', 'M'),
  ('Isabel', 'Fernández', 'Hernández', '1978-12-12', NULL, 'F'),
  ('Manuel', 'Martínez', 'Díaz', '1985-06-03', NULL, 'M'),
  ('Laura', 'Gómez', 'Jiménez', '1915-02-17', '2001-12-18', 'F'),
  ('Javier', 'Serrano', 'Muñoz', '1972-08-22', NULL, 'M'),
  ('Elena', 'Moreno', 'Alonso', '1983-04-08', NULL, 'F');


-- Inserciones para la tabla 'libro'
INSERT INTO libro (idArticulo, editorial, numPaginas, estilo, sinopsis, idAutor)
VALUES 
  (7, 'Editorial1', 300, 'Narrativo', 'Sinopsis del libro 1', 22),
  (8, 'Editorial2', 250, 'Dramatico', 'Sinopsis del libro 2', 23),
  (9, 'Editorial3', 280, 'Lirico', 'Sinopsis del libro 3', 24),
  (10, 'Editorial4', 320, 'Epico', 'Sinopsis del libro 4', 25),
  (11, 'Editorial5', 200, 'Narrativo', 'Sinopsis del libro 5', 26),
  (12, 'Editorial6', 180, 'Poetico', 'Sinopsis del libro 6', 27),
  (13, 'Editorial7', 240, 'Didactico', 'Sinopsis del libro 7', 28),
  (14, 'Editorial8', 300, 'Satirico', 'Sinopsis del libro 8', 29),
  (15, 'Editorial9', 260, 'Lirico', 'Sinopsis del libro 9', 30),
  (16, 'Editorial10', 220, 'Dramatico', 'Sinopsis del libro 10', 31);

-- Inserciones para la tabla 'materialPeriodico'
INSERT INTO materialPeriodico (idArticulo, editorial, numPaginas, tipo)
VALUES 
  (7, 'Editorial3', 20, 'Periodico'),
  (9, 'Editorial4', 15, 'Revista'),
  (11, 'Editorial6', 15, 'Revista'),
  (13, 'Editorial7', 20, 'Periodico'),
  (15, 'Editorial8', 25, 'Periodico'),
  (16, 'Editorial9', 18, 'Revista');

-- Inserciones para la tabla 'materialAudiovisual'
INSERT INTO materialAudiovisual (idArticulo, duracion, categoria, tipo)
VALUES 


-- Inserciones para la tabla 'autor_materialAudiovisual'
INSERT INTO autor_materialAudiovisual (idMaterialAudiovisual, idAutor)
VALUES 

INSERT INTO trabajador (dni, nombre, apellido1, apellido2, fchNacimiento, nombreUsuario, sexo, contrasena, edad, fchHoraRegistro)
VALUES 
  ('12345678A', 'Juan', 'Pérez', 'Gómez', '1990-05-15', 'juanito123', 'M', 'contraseña123', 32, '2013-11-18 09:30:00'),
  ('98765432B', 'María', 'González', 'Fernández', '1985-08-20', 'maria85', 'F', 'claveSegura', 37, '2017-11-18 10:15:00'),
  ('45678901C', 'Pedro', 'López', 'Martínez', '1988-12-10', 'pedrito', 'M', 'password1234', 34, '2020-11-18 11:00:00'),
  ('78901234D', 'Ana', 'Ruiz', 'Sánchez', '1992-03-25', 'anita92', 'F', 'segura123', 30, '2022-11-18 11:45:00'),
  ('23456789E', 'Luis', 'Fernández', 'Hernández', '1980-07-05', 'luisito', 'M', 'miClave', 43, '2014-11-18 12:30:00'),
  ('34567890F', 'Elena', 'Díaz', 'Ramírez', '1995-01-08', 'elenita', 'F', 'clave123', 28, '2019-11-18 13:15:00'),
  ('89012345G', 'Carlos', 'Jiménez', 'Álvarez', '1983-09-12', 'carlitos', 'M', 'contraseñaSegura', 38, '2022-11-18 14:00:00'),
  ('01234567H', 'Laura', 'Vega', 'Gutiérrez', '1987-11-30', 'lau87', 'F', 'claveLarga', 36, '2021-11-18 14:45:00'),
  ('56789012I', 'Javier', 'Morales', 'Ortega', '1998-06-18', 'javi98', 'M', 'miPassword', 25, '2022-11-18 15:30:00'),
  ('67890123J', 'Sara', 'Pérez', 'Rodríguez', '1993-04-03', 'sara93', 'F', 'clave1234', 30, '2019-11-18 16:15:00');

-- Inserciones para telefonoTrabajador
INSERT INTO telefonoTrabajador (dniTrabajador, telefono)
VALUES
  ('12345678A', '123456789'),
  ('98765432B', '987654321'),
  ('45678901C', '456789012'),
  ('78901234D', '789012345'),
  ('23456789E', '234567890'),
  ('34567890F', '345678901'),
  ('89012345G', '890123456'),
  ('01234567H', '012345678'),
  ('56789012I', '567890123'),
  ('67890123J', '678901234');

-- Inserciones para emailTrabajador
INSERT INTO emailTrabajador (dniTrabajador, email)
VALUES
  ('12345678A', 'juan.perez@example.com'),
  ('98765432B', 'maria.gonzalez@example.com'),
  ('45678901C', 'pedro.lopez@example.com'),
  ('78901234D', 'ana.ruiz@example.com'),
  ('23456789E', 'luis.fernandez@example.com'),
  ('34567890F', 'elena.diaz@example.com'),
  ('89012345G', 'carlos.jimenez@example.com'),
  ('01234567H', 'laura.vega@example.com'),
  ('56789012I', 'javier.morales@example.com'),
  ('67890123J', 'sara.perez@example.com');

-- Inserciones para usuarioAdulto
INSERT INTO usuarioAdulto (nombre, apellido1, apellido2, fchNacimiento, sexo, edad, dni, estudiante)
VALUES
  ('Ana', 'Martínez', 'López', '1990-03-15', 'F', 32, '16552678K', false),
  ('Carlos', 'García', 'Fernández', '1965-06-22', 'M', 37, '23456789B', false),
  ('Elena', 'Sánchez', 'Ramírez', '1978-11-10', 'F', 44, '34567890C', true),
  ('Javier', 'López', 'Gómez', '1980-08-05', 'M', 41, '45678901D', false),
  ('María', 'Fernández', 'Gutiérrez', '1945-02-18', 'F', 27, '56789012E', true),
  ('Pedro', 'Gómez', 'López', '1962-09-30', 'M', 39, '67890123F', false),
  ('Sara', 'López', 'Hernández', '1975-12-03', 'F', 46, '78901234G', true),
  ('Daniel', 'Hernández', 'Sánchez', '1972-04-28', 'M', 30, '89012345H', false),
  ('Laura', 'Martínez', 'Fernández', '1968-07-15', 'F', 33, '90123456I', false),
  ('Alberto', 'Ramírez', 'Gómez', '1967-10-20', 'M', 34, '01234567J', true);

-- Inserciones para usuarioMenor
INSERT INTO usuarioMenor (nombre, apellido1, apellido2, fchNacimiento, sexo, edad, idTarjetaSocio)
VALUES
  ('Lucía', 'García', 'Martínez', '2010-05-12', 'F', 13, 1),
  ('Juan', 'López', 'Gómez', '2012-09-18', 'M', 11, 2),
  ('Marina', 'Fernández', 'Gutiérrez', '2011-03-25', 'F', 12, 3),
  ('Pablo', 'Sánchez', 'Hernández', '2009-11-30', 'M', 14, 4),
  ('Sofía', 'Martínez', 'Fernández', '2013-02-08', 'F', 9, 5),
  ('Diego', 'Ramírez', 'Gómez', '2010-07-20', 'M', 12, 6),
  ('Isabel', 'López', 'Hernández', '2014-04-28', 'F', 8, 7),
  ('Manuel', 'Hernández', 'Sánchez', '2012-08-15', 'M', 10, 8),
  ('Ana', 'Gómez', 'López', '2011-11-03', 'F', 11, 9),
  ('David', 'Martínez', 'Fernández', '2013-06-22', 'M', 8, 10);

-- Inserciones para tutorUsuarioMenor
INSERT INTO tutorUsuarioMenor (idUsuarioMenor, dniTutor)
VALUES
  (1, '12345678A'),
  (2, '87654321B'),
  (3, '56789012C'),
  (4, '90123456D'),
  (5, '34567890E'),
  (6, '67890123F'),
  (7, '23456789G'),
  (8, '78901234H'),
  (9, '45678901I'),
  (10, '01234567J');

-- Inserciones para telefonoUsuario
INSERT INTO telefonoUsuario (idUsuarioAdulto, idUsuarioMenor, telefono)
VALUES
  (1, 1, '123456789'),
  (2, 2, '987654321'),
  (3, 3, '567890123'),
  (4, 4, '901234567'),
  (5, 5, '345678901'),
  (6, 6, '678901234'),
  (7, 7, '234567890'),
  (8, 8, '789012345'),
  (9, 9, '456789012'),
  (10, 10, '012345678');

-- Inserciones para emailUsuario
INSERT INTO emailUsuario (idUsuarioAdulto, idUsuarioMenor, email)
VALUES
  (1, 1, 'usuario1@dominio.com'),
  (2, 2, 'usuario2@dominio.com'),
  (3, 3, 'usuario3@dominio.com'),
  (4, 4, 'usuario4@dominio.com'),
  (5, 5, 'usuario5@dominio.com'),
  (6, 6, 'usuario6@dominio.com'),
  (7, 7, 'usuario7@dominio.com'),
  (8, 8, 'usuario8@dominio.com'),
  (9, 9, 'usuario9@dominio.com'),
  (10, 10, 'usuario10@dominio.com');

-- Inserciones para provincia
INSERT INTO provincia (nombreProvincia) VALUES
  ('Provincia1'),
  ('Provincia2'),
  ('Provincia3'),
  ('Provincia4'),
  ('Provincia5'),
  ('Provincia6'),
  ('Provincia7'),
  ('Provincia8'),
  ('Provincia9'),
  ('Provincia10');

-- Inserciones para isla
INSERT INTO isla (nombreIsla, latitud, longitud, idProvincia) VALUES
  ('Isla1', POINT(28.123, -16.987), POINT(28.123, -16.987), 1),
  ('Isla2', POINT(27.456, -15.789), POINT(27.456, -15.789), 2),
  ('Isla3', POINT(26.789, -14.567), POINT(26.789, -14.567), 3),
  ('Isla4', POINT(25.012, -13.345), POINT(25.012, -13.345), 4),
  ('Isla5', POINT(24.345, -12.123), POINT(24.345, -12.123), 5),
  ('Isla6', POINT(23.678, -10.901), POINT(23.678, -10.901), 6),
  ('Isla7', POINT(22.901, -9.789), POINT(22.901, -9.789), 7),
  ('Isla8', POINT(22.234, -8.567), POINT(22.234, -8.567), 8),
  ('Isla9', POINT(21.567, -7.345), POINT(21.567, -7.345), 9),
  ('Isla10', POINT(20.890, -6.123), POINT(20.890, -6.123), 10);

-- Inserciones para direccion
INSERT INTO direccion (ciudad, codigoPostal, direccion1, dniTrabajador, idUsuarioAdulto, idUsuarioMenor, idIsla) VALUES
  ('Ciudad1', '12345', 'Direccion1', '12345678A', 1, 1, 1),
  ('Ciudad2', '23456', 'Direccion2', '23456789B', 2, 2, 2),
  ('Ciudad3', '34567', 'Direccion3', '34567890C', 3, 3, 3),
  ('Ciudad4', '45678', 'Direccion4', '45678901D', 4, 4, 4),
  ('Ciudad5', '56789', 'Direccion5', '56789012E', 5, 5, 5),
  ('Ciudad6', '67890', 'Direccion6', '67890123F', 6, 6, 6),
  ('Ciudad7', '78901', 'Direccion7', '78901234G', 7, 7, 7),
  ('Ciudad8', '89012', 'Direccion8', '89012345H', 8, 8, 8),
  ('Ciudad9', '90123', 'Direccion9', '90123456I', 9, 9, 9),
  ('Ciudad10', '01234', 'Direccion10', '01234567J', 10, 10, 10);

INSERT INTO prestacion (idArticulo, dniTrabajador, idUsuarioAdulto, idUsuarioMenor, fchInicio, fchFin, fchDevolucion)
VALUES 
  (1, '12345678A', 1, NULL, '2022-10-01', '2022-10-15', NULL),
  (2, '87654321B', NULL, 2, '2022-09-15', '2022-09-30', NULL),
  (3, '11111111C', NULL, 3, '2022-08-01', '2022-08-15', NULL),
  (4, '22222222D', 4, NULL, '2022-11-01', '2022-11-15', NULL),
  (5, '33333333E', 5, NULL, '2022-12-01', '2022-12-15', NULL),
  (6, '44444444F', NULL, 6, '2022-07-01', '2022-07-15', NULL),
  (7, '55555555G', 7, NULL, '2022-06-01', '2022-06-15', NULL),
  (8, '66666666H', NULL, 8, '2022-05-01', '2022-05-15', NULL),
  (9, '77777777I', 9, NULL, '2022-04-01', '2022-04-15', NULL),
  (10, '88888888J', NULL, 10, '2022-03-01', '2022-03-15', NULL);
-- Inserciones para la tabla 'articulo'
INSERT INTO articulo (titulo, subtitulo, fchPublicacion, portada, stock) 
VALUES 
  ('Historia del Arte Moderno', 'Una exploración de las corrientes artísticas del siglo XX', '2022-10-15',
   E'\\x89504e470d0a1a0a0000',
   1),
  ('Recetas de Cocina Tradicional', 'Platos caseros y deliciosos', '2021-08-25',
   E'\\x89504e470d0a1a0a0000',
   1),
  ('Viaje al Centro de la Tierra', 'Una emocionante novela de aventuras', '2020-05-12',
   E'\\x89504e470d0a1a0a0000',
   1),
  ('Guía Práctica de Programación', 'Conceptos esenciales para aprender a programar', '2023-01-30',
   E'\\x89504e470d0a1a0a0000',
   1),
  ('Misterios del Universo', 'Explorando los secretos del cosmos', '2022-06-08',
   E'\\x89504e470d0a1a0a0000',
   1),
  ('Aventuras en la Selva', 'Descubre la fauna y flora de la jungla', '2019-12-05',
   E'\\x89504e470d0a1a0a0000',
   1),
  ('Economía Global', 'Análisis de los mercados y tendencias económicas', '2021-04-20',
   E'\\x89504e470d0a1a0a0000',
   1),
  ('Arquitectura Contemporánea', 'Explorando los diseños innovadores', '2020-09-15',
   E'\\x89504e470d0a1a0a0000',
   1),
  ('Cocina Internacional', 'Sabores del mundo en tu mesa', '2018-07-03',
   E'\\x89504e470d0a1a0a0000',
   1),
  ('El Misterio de la Isla Perdida', 'Una novela de intriga y suspense', '2023-03-10',
   E'\\x89504e470d0a1a0a0000',
   1),
  ('Noticias del Día', 'Resumen de los eventos actuales', '2023-11-18', E'\\x89504e470d0a1a0a0096', 1),
  ('El Periódico Semanal', 'Recopilación de noticias destacadas', '2023-11-17', E'\\x89504e470d0a1a0a0025', 1),
  ('Economía Hoy', 'Análisis financiero y económico', '2023-11-16', E'\\xABC2DE', 120),
  ('Cultura y Espectáculos', 'Lo último en arte y entretenimiento', '2023-11-15', E'\\x89504e470d0a1a0a0034', 1),
  ('Ciencia y Tecnología', 'Avances y descubrimientos científicos', '2023-11-14', E'\\x89504e470d0a1a0a0023', 1),
  ('Revista de Ciencia', 'Explorando los avances científicos', '2023-11-18', E'\\x89504e470d0a1a0a0043', 80),
  ('Revista de Moda', 'Tendencias y estilos de la temporada', '2023-11-17', E'\\x89504e470d0a3a0a0023', 100),
  ('Revista de Viajes', 'Destinos increíbles y consejos de viaje', '2023-11-16', E'\\x89504e470d0a1a0a0043', 120),
  ('Revista de Tecnología', 'Lo último en gadgets y novedades tecnológicas', '2023-11-15', E'\\x89504e470d0a1a0a0021', 90),
  ('Revista de Cine', 'Críticas y novedades del mundo del cine', '2023-11-14', E'\\x89504e470d0a1a0a0022', 70),
  ('Interstellar', 'Explorando el espacio profundo', '2014-11-07', E'\\x895043B70d0a1a0a0022', 5),
  ('Planet Earth II', 'Una exploración visual de la naturaleza', '2016-11-06', E'\\x895043470A0a1a0a0022', 3),
  ('Stranger Things', 'Aventuras sobrenaturales en los años 80', '2016-07-15', E'\\x895043460d0a1a0a0022', 8),
  ('The Shawshank Redemption', 'La esperanza prevalece en prisión', '1994-09-23', E'\\x895053470d0a1a0a0022', 2),
  ('Blue Planet II', 'Explorando los océanos del mundo', '2017-11-18', E'\\x892043470d0a1a0a0022', 6);




-- Inserciones para la tabla 'generoArticulo'
INSERT INTO generoArticulo (idArticulo, genero) 
VALUES 
  (1, 'Historia'),
  (2, 'Fantasia'),
  (3, 'Aventura'),
  (4, 'Suspense'),
  (5, 'Aventura'),
  (6, 'Romance'),
  (7, 'Ciencia-Ficcion'),
  (8, 'Misterio'),
  (9, 'Historia'),
  (10, 'Accion'),
  (11, 'Informativo'),
  (12, 'Informativo'),
  (13, 'Informativo'),
  (14, 'Informativo'),
  (15, 'Informativo'),
  (16, 'Informativo'),
  (17, 'Informativo'),
  (18, 'Informativo'),
  (19, 'Informativo'),
  (20, 'Informativo');

-- Inserciones para la tabla 'autor'
INSERT INTO autor (nombre, apellido1, apellido2, fchNacimiento, fchMuerte, sexo)
VALUES 
  ('Juan', 'Pérez', 'González', '1980-05-15', NULL, 'M'),
  ('María', 'López', 'Martínez', '1992-11-28', NULL, 'F'),
  ('Carlos', 'Ruiz', 'Fernández', '1975-07-10', '2022-06-30', 'M'),
  ('Ana', 'García', 'Sánchez', '1988-03-20', NULL, 'F'),
  ('Pedro', 'Rodríguez', 'Vega', '1960-09-05', '2018-12-18', 'M'),
  ('Isabel', 'Fernández', 'Hernández', '1978-12-12', NULL, 'F'),
  ('Manuel', 'Martínez', 'Díaz', '1985-06-03', NULL, 'M'),
  ('Laura', 'Gómez', 'Jiménez', '1945-02-17', '2001-12-18', 'F'),
  ('Javier', 'Serrano', 'Muñoz', '1972-08-22', NULL, 'M'),
  ('Elena', 'Moreno', 'Alonso', '1983-04-08', NULL, 'F'),
  ('Luis', 'Hernández', 'Rodríguez', '1968-10-30', '2021-07-15', 'M'),
  ('Carmen', 'Vega', 'Santos', '1995-12-01', NULL, 'F'),
  ('Alberto', 'Martínez', 'Gómez', '1982-06-14', '2020-04-25', 'M'),
  ('Sara', 'Gutiérrez', 'Díaz', '1977-09-18', NULL, 'F'),
  ('Alejandro', 'Ortega', 'Fernández', '1989-03-25', NULL, 'M'),
  ('Beatriz', 'Herrera', 'López', '1990-07-12', NULL, 'F'),
  ('Ricardo', 'Sánchez', 'Gómez', '1973-04-05', '2021-11-30', 'M'),
  ('Julia', 'Muñoz', 'Serrano', '1986-11-18', NULL, 'F'),
  ('Hugo', 'Fernández', 'Díaz', '1970-02-22', NULL, 'M'),
  ('Marta', 'Alonso', 'Martínez', '1998-08-09', NULL, 'F'),
  ('Raúl', 'Gómez', 'Fernández', '1981-01-30', NULL, 'M'),
  ('Luisa', 'Díaz', 'Santos', '1965-06-14', '2022-09-10', 'F'),
  ('José', 'Ortega', 'Hernández', '1978-03-25', NULL, 'M'),
  ('Cristina', 'Gutiérrez', 'Rodríguez', '1993-09-18', NULL, 'F'),
  ('Eduardo', 'Martínez', 'Gómez', '1972-11-30', '2020-05-15', 'M');


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
  (11, 'Editorial3', 20, 'Periodico'),
  (12, 'Editorial4', 15, 'Periodico'),
  (13, 'Editorial6', 15, 'Periodico'),
  (14, 'Editorial7', 20, 'Periodico'),
  (15, 'Editorial8', 25, 'Periodico'),
  (16, 'Editorial8', 25, 'Revista'),
  (17, 'Editorial8', 25, 'Revista'),
  (18, 'Editorial8', 25, 'Revista'),
  (19, 'Editorial8', 25, 'Revista'),
  (20, 'Editorial9', 18, 'Revista');

-- Inserciones para la tabla 'materialAudiovisual'
INSERT INTO materialAudiovisual (idArticulo, duracion, categoria, tipo)
VALUES 
  (21, '02:30:00', 'Pelicula', 'DVD'),
  (22, '01:45:00', 'Documental', 'CD'),
  (23, '04:00:00', 'Serie', 'DVD'),
  (24, '01:20:00', 'Pelicula', 'VHS'),
  (25, '03:15:00', 'Serie', 'Audiolibro');


-- Inserciones para la tabla 'autor_materialAudiovisual'
INSERT INTO autor_materialAudiovisual (idMaterialAudiovisual, idAutor)
VALUES 
(21, 25),
(22, 24),
(23, 23),
(24, 22),
(25, 21);

INSERT INTO trabajador (dni, nombre, apellido1, apellido2, fchNacimiento, nombreUsuario, sexo, contrasena, edad, fchHoraRegistro)
VALUES 
  ('12345678A', 'Juan', 'Pérez', 'Gómez', '1990-05-15', 'juanito123', 'M', 'contraseña123', 32, '2013-11-18 09:30:00'),
  ('98765432B', 'María', 'González', 'Fernández', '1985-08-20', 'maria85', 'F', 'claveSegura', 37, '2017-11-18 10:15:00'),
  ('45678901C', 'Pedro', 'López', 'Martínez', '1988-12-10', 'pedrito', 'M', 'password1234', 34, '2020-11-18 11:00:00'),
  ('78901234D', 'Ana', 'Ruiz', 'Sánchez', '1992-03-25', 'anita92', 'F', 'segura123', 30, '2022-11-18 11:45:00'),
  ('23456789E', 'Luis', 'Fernández', 'Hernández', '1980-07-05', 'luisito', 'M', 'miClave', 43, '2014-11-18 12:30:00'),
  ('34567890F', 'Elena', 'Díaz', 'Ramírez', '1995-01-08', 'elenita', 'F', 'clave123', 28, '2019-11-18 13:15:00'),
  ('89012345G', 'Carlos', 'Jiménez', 'Álvarez', '1983-09-12', 'carlitos', 'M', 'contraseñaSegura', 38, '2022-11-18 14:00:00'),
  ('01234567H', 'Laura', 'Vega', 'Gutiérrez', '1987-11-30', 'lau87', 'F', 'claveLarga', 36, '2021-11-18 14:45:00'),
  ('56789012I', 'Javier', 'Morales', 'Ortega', '1998-06-18', 'javi98', 'M', 'miPassword', 25, '2022-11-18 15:30:00'),
  ('67890123J', 'Sara', 'Pérez', 'Rodríguez', '1993-04-03', 'sara93', 'F', 'clave1234', 30, '2019-11-18 16:15:00');

-- Inserciones para telefonoTrabajador
INSERT INTO telefonoTrabajador (dniTrabajador, telefono)
VALUES
  ('12345678A', '123456789'),
  ('98765432B', '987654321'),
  ('45678901C', '456789012'),
  ('78901234D', '789012345'),
  ('23456789E', '234567890'),
  ('34567890F', '345678901'),
  ('89012345G', '890123456'),
  ('01234567H', '012345678'),
  ('56789012I', '567890123'),
  ('67890123J', '678901234');

-- Inserciones para emailTrabajador
INSERT INTO emailTrabajador (dniTrabajador, email)
VALUES
  ('12345678A', 'juan.perez@example.com'),
  ('98765432B', 'maria.gonzalez@example.com'),
  ('45678901C', 'pedro.lopez@example.com'),
  ('78901234D', 'ana.ruiz@example.com'),
  ('23456789E', 'luis.fernandez@example.com'),
  ('34567890F', 'elena.diaz@example.com'),
  ('89012345G', 'carlos.jimenez@example.com'),
  ('01234567H', 'laura.vega@example.com'),
  ('56789012I', 'javier.morales@example.com'),
  ('67890123J', 'sara.perez@example.com');

-- Inserciones para usuarioAdulto
INSERT INTO usuarioAdulto (nombre, apellido1, apellido2, fchNacimiento, sexo, edad, dni, estudiante)
VALUES
  ('Ana', 'Martínez', 'López', '1990-03-15', 'F', 32, '16552678K', false),
  ('Carlos', 'García', 'Fernández', '1965-06-22', 'M', 37, '23456789B', false),
  ('Elena', 'Sánchez', 'Ramírez', '1978-11-10', 'F', 44, '34567890C', true),
  ('Javier', 'López', 'Gómez', '1980-08-05', 'M', 41, '45678901D', false),
  ('María', 'Fernández', 'Gutiérrez', '1945-02-18', 'F', 27, '56789012E', true),
  ('Pedro', 'Gómez', 'López', '1962-09-30', 'M', 39, '67890123F', false),
  ('Sara', 'López', 'Hernández', '1975-12-03', 'F', 46, '78901234G', true),
  ('Daniel', 'Hernández', 'Sánchez', '1972-04-28', 'M', 30, '89012345H', false),
  ('Laura', 'Martínez', 'Fernández', '1968-07-15', 'F', 33, '90123456I', false),
  ('Alberto', 'Ramírez', 'Gómez', '1967-10-20', 'M', 34, '01234567J', true);

INSERT INTO tarjetaSocio (color) VALUES
  ('Azul'),
  ('Rojo'),
  ('Verde'),
  ('Azul'),
  ('Verde'),
  ('Rojo'),
  ('Azul'),
  ('Rojo'),
  ('Verde'),
  ('Azul');


-- Inserciones para usuarioMenor
INSERT INTO usuarioMenor (nombre, apellido1, apellido2, fchNacimiento, sexo, edad, idTarjetaSocio)
VALUES
  ('Lucía', 'García', 'Martínez', '2010-05-12', 'F', 13, 1),
  ('Juan', 'López', 'Gómez', '2012-09-18', 'M', 11, 2),
  ('Marina', 'Fernández', 'Gutiérrez', '2011-03-25', 'F', 12, 3),
  ('Pablo', 'Sánchez', 'Hernández', '2009-11-30', 'M', 14, 4),
  ('Sofía', 'Martínez', 'Fernández', '2013-02-08', 'F', 9, 5),
  ('Diego', 'Ramírez', 'Gómez', '2010-07-20', 'M', 12, 6),
  ('Isabel', 'López', 'Hernández', '2014-04-28', 'F', 8, 7),
  ('Manuel', 'Hernández', 'Sánchez', '2012-08-15', 'M', 10, 8),
  ('Ana', 'Gómez', 'López', '2011-11-03', 'F', 11, 9),
  ('David', 'Martínez', 'Fernández', '2013-06-22', 'M', 8, 10);

-- Inserciones para tutorUsuarioMenor
INSERT INTO tutorUsuarioMenor (idUsuarioMenor, dniTutor)
VALUES
  (1, '16552678K'),
  (2, '23456789B'),
  (3, '34567890C'),
  (4, '45678901D'),
  (5, '56789012E'),
  (6, '67890123F'),
  (7, '78901234G'),
  (8, '89012345H'),
  (9, '90123456I'),
  (10, '01234567J');

-- Inserciones para telefonoUsuario
INSERT INTO telefonoUsuario (idUsuarioAdulto, idUsuarioMenor, telefono)
VALUES
  (1, NULL, '123456789'),
  (NULL, 2, '987654321'),
  (NULL, 3, '567890123'),
  (4, NULL, '901234567'),
  (5, NULL, '345678901'),
  (6, NULL, '678901234'),
  (7, NULL, '234567890'),
  (8, NULL, '789012345'),
  (9, NULL, '456789012'),
  (NULL, 10, '012345678');

-- Inserciones para emailUsuario
INSERT INTO emailUsuario (idUsuarioAdulto, idUsuarioMenor, email)
VALUES
  (1, NULL, 'usuario1@dominio.com'),
  (2, NULL, 'usuario2@dominio.com'),
  (NULL, 3, 'usuario3@dominio.com'),
  (4, NULL, 'usuario4@dominio.com'),
  (5, NULL, 'usuario5@dominio.com'),
  (6, NULL, 'usuario6@dominio.com'),
  (7, NULL, 'usuario7@dominio.com'),
  (NULL, 8, 'usuario8@dominio.com'),
  (9, NULL, 'usuario9@dominio.com'),
  (10, NULL, 'usuario10@dominio.com');

-- Inserciones para provincia
INSERT INTO provincia (nombreProvincia) VALUES
  ('Santa Cruz de Tenerife'),
  ('Las Palmas de Gran Canaria');

-- Inserciones para isla
INSERT INTO isla (nombreIsla, latitud, longitud, idProvincia) VALUES
  ('Tenerife', POINT(28.123, -16.987), POINT(28.123, -16.987), 1),
  ('Gran Canaria', POINT(27.456, -15.789), POINT(27.456, -15.789), 2),
  ('Lanzarote', POINT(26.789, -14.567), POINT(26.789, -14.567), 2),
  ('Fuerteventura', POINT(25.012, -13.345), POINT(25.012, -13.345), 2),
  ('La Palma', POINT(24.345, -12.123), POINT(24.345, -12.123), 1),
  ('La Gomera', POINT(23.678, -10.901), POINT(23.678, -10.901), 1),
  ('El Hierro', POINT(22.901, -9.789), POINT(22.901, -9.789), 1);



-- Inserciones para direccion
INSERT INTO direccion (ciudad, codigoPostal, direccion1, dniTrabajador, idUsuarioAdulto, idUsuarioMenor, idIsla) VALUES
  ('Garachico', '12345', 'Direccion1', '12345678A', NULL, NULL, 1),
  ('Agaete', '23456', 'Direccion2', '98765432B', NULL, NULL, 2),
  ('Arrecife', '34567', 'Direccion3', '45678901C', NULL, NULL, 3),
  ('Jandía', '45678', 'Direccion4', '78901234D', NULL, NULL, 4),
  ('Barlovento', '56789', 'Direccion5', '23456789E', NULL, NULL, 5),
  ('Hermigua', '67890', 'Direccion6', '34567890F', NULL, NULL, 6),
  ('Valverde', '78901', 'Direccion7', '89012345G', NULL, NULL, 7),
  ('Garachico', '89012', 'Direccion8', '01234567H', NULL, NULL, 1),
  ('Agaete', '90123', 'Direccion9', '56789012I', NULL, NULL, 2),
  ('Arrecife', '01234', 'Direccion10', '67890123J', NULL, NULL, 3),
  ('Garachico', '12345', 'Direccion1', NULL, 1, NULL, 1),
  ('Agaete', '23456', 'Direccion2', NULL, 2, NULL, 2),
  ('Arrecife', '34567', 'Direccion3', NULL, 3, NULL, 3),
  ('Jandía', '45678', 'Direccion4', NULL, 4, NULL, 4),
  ('Barlovento', '56789', 'Direccion5', NULL, 5, NULL, 5),
  ('Hermigua', '67890', 'Direccion6', NULL, 5, NULL, 6),
  ('Valverde', '78901', 'Direccion7', NULL, 6, NULL, 7),
  ('Garachico', '89012', 'Direccion8', NULL, 7, NULL, 1),
  ('Agaete', '90123', 'Direccion9', NULL, 8, NULL, 2),
  ('Arrecife', '01234', 'Direccion10', NULL, 9, NULL, 3),
  ('Garachico', '12345', 'Direccion1', NULL, NULL, 1, 1),
  ('Agaete', '23456', 'Direccion2', NULL, NULL, 1, 2),
  ('Arrecife', '34567', 'Direccion3', NULL, NULL, 2, 3),
  ('Jandía', '45678', 'Direccion4', NULL, NULL, 3, 4),
  ('Barlovento', '56789', 'Direccion5', NULL, NULL, 4, 5),
  ('Hermigua', '67890', 'Direccion6', NULL, NULL, 5, 6),
  ('Valverde', '78901', 'Direccion7', NULL, NULL, 6, 7),
  ('Garachico', '89012', 'Direccion8', NULL, NULL, 7, 1),
  ('Agaete', '90123', 'Direccion9', NULL, NULL, 8, 2),
  ('Arrecife', '01234', 'Direccion10', NULL, NULL, 9, 3);

INSERT INTO prestacion (idArticulo, dniTrabajador, idUsuarioAdulto, idUsuarioMenor, fchInicio, fchFin, fchDevolucion)
VALUES 
  (1, '12345678A', 1, NULL, '2022-10-01', '2022-10-15', NULL),
  (2, '98765432B', NULL, 2, '2022-09-15', '2022-09-30', NULL),
  (3, '45678901C', NULL, 3, '2022-08-01', '2022-08-15', NULL),
  (4, '45678901C', 4, NULL, '2022-11-01', '2022-11-15', NULL),
  (5, '78901234D', 5, NULL, '2022-12-01', '2022-12-15', NULL),
  (6, '78901234D', NULL, 6, '2022-07-01', '2022-07-15', NULL),
  (7, '89012345G', 7, NULL, '2022-06-01', '2022-06-15', NULL),
  (8, '01234567H', NULL, 8, '2022-05-01', '2022-05-15', NULL),
  (9, '56789012I', 9, NULL, '2022-04-01', '2022-04-15', NULL),
  (10, '67890123J', NULL, 10, '2022-03-01', '2022-03-15', NULL);
