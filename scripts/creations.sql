/**
 * Table creations
 */

-- Table 'provincias'
CREATE TABLE provincias (
  id SERIAL PRIMARY KEY,
  nombre VARCHAR(50) NOT NULL
);

-- Table 'islas'
CREATE TABLE islas (
  id_provincia INT REFERENCES provincias(id) ON UPDATE CASCADE ON DELETE RESTRICT,
  id SERIAL PRIMARY KEY,
  nombre VARCHAR(50) NOT NULL,
  latitud GEOGRAPHY(POINT) NOT NULL,
  longitud GEOGRAPHY(POINT) NOT NULL,
);

-- Table 'direcciones'
CREATE TABLE direcciones (
  id_isla INT REFERENCES islas(id) ON UPDATE CASCADE ON DELETE RESTRICT,
  id SERIAL PRIMARY KEY,
  ciudad VARCHAR(50) NOT NULL,
  codPostal CHAR(5) NOT NULL CHECK (codPostal ~ '^[0-9]+$'),
  direccion1 text NOT NULL, 
  direccion2 text
);

-- Table 'bibliotecas'
CREATE TABLE bibliotecas (
  id SERIAL PRIMARY KEY,
  nombre VARCHAR(50) NOT NULL,
  sitioWeb text
  -- emails
  -- tlfns
);

-- Table 'horarios'
CREATE TABLE horarios (
  id SERIAL PRIMARY KEY
);

-- Table 'dias'
CREATE TABLE dias (
  id_horario INT REFERENCES horarios(id) ON UPDATE CASCADE ON DELETE RESTRICT,
  nombre VARCHAR(9) CHECK (nombre IN ('Lunes', 'Martes', 'Miercoles', 'Jueves', 'Viernes', 'Sabado', 'Domingo')),
  PRIMARY KEY (id_horario, nombre)
);

-- Table 'periodos'
CREATE TABLE periodos (
  id SERIAL PRIMARY KEY,
  inicio TIME,
  fin TIME
  -- Dia asociado?
);

-- Table 'usuarios'
CREATE TABLE usuarios (
  id SERIAL PRIMARY KEY,
  nombre VARCHAR(50) NOT NULL,
  apellido1 VARCHAR(50) NOT NULL,
  apellido2 VARCHAR(50),
  fchNacimiento DATE NOT NULL CHECK (fchNacimiento > '1900-01-01'),
  sexo CHAR(1) CHECK (sexo in ('M', 'F'))
  -- edad (generada automáticamente a partir de la fecha de nacimiento 'int')
  -- fecha de registro (generado automáticamente a la hora de la creación 'timestamp')
  -- teléfono y email
  tipo VARCHAR(6) CHECK (tipo in ('Adulto', 'Menor')), -- Restricción para no rellenar campos si el tipo es uno u es otro?
  dni CHAR(9) CHECK (dni ~ '\d{8}[A-Za-z]$'),
  esEstudiante BOOLEAN
);

-- Table 'dniTutores'
CREATE TABLE dniTutores ( -- Restricción no poder rellenar si el tipo es "Adulto"
  id_usuario INT REFERENCES usuarios(id) ON UPDATE CASCADE ON DELETE CASCADE,
  dniTutor CHAR(9) CHECK (dni ~ '\d{8}[A-Za-z]$')
);

-- Table 'Tarjetas Socio'
CREATE TABLE tarjetasSocio (
  id SERIAL PRIMARY KEY,
  color VARCHAR(50) CHECK (color in ('green', 'red', 'blue'))
  -- id usuario al que pertenece
);

-- Table 'trabajadores'
CREATE TABLE trabajadores (
  dni CHAR(9) CHECK (dni ~ '\d{8}[A-Za-z]$') PRIMARY KEY,
  nombre VARCHAR(50) NOT NULL,
  apellido_1 VARCHAR(50) NOT NULL,
  apellido_2 VARCHAR(50),
  fchNacimiento DATE NOT NULL CHECK (fchNacimiento > '1900-01-01'),
  sexo CHAR(1) CHECK (sexo in ('M', 'F')),
  username VARCHAR(50) UNIQUE NOT NULL, -- Podemos complicarlo generandolo automáticamente
  passwd VARCHAR(50) CHECK (
    passwd ~ '[a-z]' AND
    passwd ~ '[A-Z]' AND
    passwd ~ '\d' AND
    passwd ~ '[!@#$%^&*()_+{}|:"<>?~=\/`[\]'';,.]'
  )
  -- edad (generada automáticamente a partir de la fecha de nacimiento 'int')
  -- fecha de registro (generado automáticamente a la hora de la creación 'timestamp')
  -- teléfono y email
  -- activo? (Generado a partir del checko de periodos en los que trabaja)

);

-- Table 'articulos'
CREATE TABLE articulos (
  id SERIAL PRIMARY KEY,
  titulo VARCHAR(50) NOT NULL,
  subtitulo VARCHAR(100),
  fchPublicacion DATE, -- Puede ser NULL: La biblia no tiene fecha de publicación
  -- portada (link a imagen)
  -- generos
);

-- Table 'materialesAudiovisuales'
CREATE TABLE materialesAudiovisuales (
  id_articulo INT REFERENCES articulos(id) ON UPDATE CASCADE ON DELETE RESTRICT,
  duracion INTERVAL NOT NULL, -- Checkear que no sea negativa
  categoria VARCHAR(10) CHECK (categoria in ('Documental', 'Serie', 'Pelicula')),
  tipo VARCHAR(10) CHECK (tipo in ('DVD', 'CD', 'CD-ROOM', 'VHS', 'Audiolibro'))
  PRIMARY KEY (id_articulo)
);

-- Table 'libros'
CREATE TABLE libros (
  id_articulo INT REFERENCES articulos(id) ON UPDATE CASCADE ON DELETE RESTRICT,
  numPaginas INT NOT NULL CHECK (numPaginas > 0),
  editorial VARCHAR(50) NOT NULL,
  sinopsis TEXT,
  estiloLiterario VARCHAR(9) CHECK (estiloLiterario IN ('Narrativo', 'Lirico', 'Teatral')),
  PRIMARY KEY (id_articulo)
);

-- Table 'materialesPeriodicos'
CREATE TABLE materialesPeriodicos (
  id_articulo INT REFERENCES articulos(id) ON UPDATE CASCADE ON DELETE RESTRICT,
  numPaginas INT NOT NULL CHECK (numPaginas > 0),
  editorial VARCHAR(50) NOT NULL,
  tipo VARCHAR(9) CHECK (tipo IN ('Periodico', 'Revista')),
  PRIMARY KEY (id_articulo)
);

-- Table 'autores'
CREATE TABLE autores (
  id SERIAL PRIMARY KEY,
  nombre VARCHAR(50) NOT NULL,
  apellido_1 VARCHAR(50) NOT NULL,
  apellido_2 VARCHAR(50),
  nacionalidad VARCHAR(50), -- autores de nacionalidad desconocida, pueden tener varias nacionalidades?, Check in (español, ingles, frances...)?
  sexo CHAR(1) CHECK (sexo in ('M', 'F')),
  fchNacimiento DATE,
  fchMuerte DATE
  -- edad (generada automáticamente a partir de la fecha de nacimiento 'int')
);

-- Table 'inventarios'
CREATE TABLE inventarios (
  id SERIAL PRIMARY KEY,
  stock INT CHECK (stock >= 0),
  disponible BOOLEAN -- Disparador: stock == 0 <==> disponible == TRUE
)