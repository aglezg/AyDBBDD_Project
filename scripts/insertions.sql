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
   1);

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
INSERT INTO autor (nombre, apellido1, apellido2, fchNacimiento, fchMuerte, sexo, edad)
VALUES 
  ('Juan', 'Pérez', 'González', '1980-05-15', NULL, 'M', NULL),
  ('María', 'López', 'Martínez', '1992-11-28', NULL, 'F', NULL),
  ('Carlos', 'Ruiz', 'Fernández', '1975-07-10', '2022-06-30', 'M', NULL),
  ('Ana', 'García', 'Sánchez', '1988-03-20', NULL, 'F', NULL),
  ('Pedro', 'Rodríguez', 'Vega', '1960-09-05', '2018-12-18', 'M', NULL),
  ('Isabel', 'Fernández', 'Hernández', '1978-12-12', NULL, 'F', NULL),
  ('Manuel', 'Martínez', 'Díaz', '1985-06-03', NULL, 'M', NULL),
  ('Laura', 'Gómez', 'Jiménez', '1915-02-17', '2001-12-18', 'F', NULL),
  ('Javier', 'Serrano', 'Muñoz', '1972-08-22', NULL, 'M', NULL),
  ('Elena', 'Moreno', 'Alonso', '1983-04-08', NULL, 'F', NULL);


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
