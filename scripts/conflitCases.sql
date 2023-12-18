-- Tabla articulo
INSERT INTO articulo (titulo, tipo, subtitulo, fchPublicacion, portada, stock) 
VALUES 
-- Stock Negativo
('Articulo_1','libro','Subtitulo_1', '2022-10-01', E'\\x89504e470d0a1a0a0000', -1);

INSERT INTO articulo (titulo, tipo, subtitulo, fchPublicacion, portada, stock) 
VALUES 
-- Tipo de Articulo erroneo
('Articulo_1','OtherType','Subtitulo_1', '2022-10-01', E'\\x89504e470d0a1a0a0000', 1);

INSERT INTO articulo (titulo, tipo, subtitulo, fchPublicacion, portada, stock) 
VALUES 
-- Fecha de publicacion de articulo mayor que fecha actual
('Articulo_1','libro','Subtitulo_1', '2099-10-01', E'\\x89504e470d0a1a0a0000', 1);
