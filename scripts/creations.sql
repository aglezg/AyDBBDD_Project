/**
 * * * TABLE CREATIONS
 */

-- TABLE 'articulo'                               -- Falta TRIGGER ' STOCK Prestación'
CREATE TABLE articulo (
  id SERIAL PRIMARY KEY,
  titulo VARCHAR(50) NOT NULL,
  subtitulo VARCHAR(100),
  fchPublicacion DATE CHECK (fchPublicacion <= CURRENT_DATE),
  portada BYTEA,
  stock INT NOT NULL CHECK (stock >= 0),
  disponible BOOLEAN GENERATED ALWAYS AS (stock > 0) STORED
);

-- TABLE 'generoArticulo'
CREATE TABLE generoArticulo (
  idArticulo INT REFERENCES articulo(id) ON UPDATE CASCADE ON DELETE CASCADE,
  genero VARCHAR(20) NOT NULL,
  CHECK(genero IN (
    'Novela', 
    'Cuento', 
    'Poesia', 
    'Ensayo', 
    'Biografia',
    'Historia',
    'Periodismo',
    'Tragedia',
    'Comedia',
    'Fantasia',
    'Distopia',
    'Viaje-en-el-Tiempo',
    'Misterio',
    'Suspense',
    'Detective',
    'Thriller',
    'Romance',
    'Accion',
    'Aventura',
    'Comedia-Romantica',
    'Drama',
    'Melodrama',
    'Ciencia-Ficcion',
    'Terror',
    'Infantil',
    'Anime')
  )
);


-- TABLE 'autor'
CREATE TABLE autor (
  id SERIAL PRIMARY KEY,
  nombre VARCHAR(50) NOT NULL,
  apellido1 VARCHAR(50) NOT NULL,
  apellido2 VARCHAR(50),
  fchNacimiento DATE CHECK (fchNacimiento <= CURRENT_DATE),
  fchMuerte DATE CHECK (fchMuerte <= CURRENT_DATE),
  sexo CHAR(1) CHECK (sexo IN ('M', 'F', 'O')),
  edad SMALLINT CHECK (edad > 0)
  CHECK (fchNacimiento <= fchMuerte)
);

-- CREATE FUNCTION 'actualiza_edad()'
CREATE OR REPLACE FUNCTION actualiza_edad() RETURNS TRIGGER AS $$
  BEGIN
    IF NEW.fchNacimiento IS NOT NULL THEN
      NEW.edad = DATE_PART('year', AGE(CURRENT_DATE, NEW.fchNacimiento));
    ELSE
      NEW.edad = NULL;
    END IF;
    RETURN NEW;
  END;
$$ LANGUAGE plpgsql;

-- CREATE TRIGGER 'trigger_edad_autor()'
CREATE TRIGGER trigger_edad_autor
BEFORE INSERT OR UPDATE
ON autor
FOR EACH ROW
EXECUTE FUNCTION actualiza_edad();


-- TABLE 'libro'
CREATE TABLE libro (
  idArticulo INT REFERENCES articulo(id) ON UPDATE CASCADE ON DELETE RESTRICT,
  editorial VARCHAR(50) NOT NULL,
  numPaginas INT NOT NULL CHECK (numPaginas > 0),
  estilo VARCHAR(9) NOT NULL CHECK (estilo IN ('Narrativo', 'Poetico', 'Dramatico', 'Epico', 'Lirico', 'Didactico', 'Satirico')),
  sinopsis TEXT,
  idAutor INT REFERENCES autor(id) ON UPDATE CASCADE ON DELETE RESTRICT,
  PRIMARY KEY (idArticulo)
);


-- Table 'materialPeriodico'
CREATE TABLE materialPeriodico (
  idArticulo INT REFERENCES articulo(id) ON UPDATE CASCADE ON DELETE RESTRICT,
  editorial VARCHAR(50) NOT NULL,
  numPaginas INT NOT NULL CHECK (numPaginas > 0),
  tipo VARCHAR(9) NOT NULL CHECK (tipo IN ('Periodico', 'Revista')),
  PRIMARY KEY (idArticulo)
);


-- Table 'materialAudiovisual'
CREATE TABLE materialAudiovisual (
  idArticulo INT REFERENCES articulo(id) ON UPDATE CASCADE ON DELETE RESTRICT,
  duracion INTERVAL CHECK (duracion > '00:00:00'),
  categoria VARCHAR(10) NOT NULL CHECK (categoria IN ('Pelicula', 'Documental', 'Serie')),
  tipo VARCHAR(10) NOT NULL CHECK (tipo IN ('DVD', 'CD', 'CD_ROM', 'VHS', 'Audiolibro')),
  PRIMARY KEY (idArticulo)
);


-- Table 'autor_materialAudiovisual'
CREATE TABLE autor_materialAudiovisual (
  idMaterialAudiovisual INT REFERENCES materialAudiovisual(idArticulo) ON UPDATE CASCADE ON DELETE CASCADE,
  idAutor INT REFERENCES autor(id) ON UPDATE CASCADE ON DELETE RESTRICT
);


-- Table 'trabajador'
CREATE TABLE trabajador (
  dni CHAR(9) PRIMARY KEY CHECK (dni ~ '\d{8}[A-Za-z]$'),
  nombre VARCHAR(50) NOT NULL,
  apellido1 VARCHAR(50) NOT NULL,
  apellido2 VARCHAR(50),
  fchNacimiento DATE NOT NULL CHECK (fchNacimiento BETWEEN '1900-01-01' AND CURRENT_DATE),
  nombreUsuario VARCHAR(50) NOT NULL UNIQUE,
  sexo CHAR(1) CHECK (sexo IN ('M', 'F', 'O')),
  contrasena VARCHAR(255) NOT NULL,
  edad SMALLINT CHECK (edad > 0),
  -- Creo que lo de 'activo' puede hacerse con un trigger mejor y bueno, hay que hacer la tabla periodo antes
  -- activo BOOLEAN GENERATED ALWAYS AS (EXISTS (SELECT 1 FROM Periodo WHERE trabajador.dni = Periodo.dni AND Fecha_Fin IS NULL)) STORED,
  fchHoraRegistro TIMESTAMP WITHOUT TIME ZONE NOT NULL -- Creo que puede hacerse con un trigger mejor. En la práctica 5 el profe uso uno
  --CONSTRAINT chk_activo_fecha_hora CHECK (NOT (activo AND fchHoraRegistro IS NULL)),
  --CONSTRAINT chk_fchNacimiento_registro CHECK (fchNacimiento <= fchHoraRegistro)
);

-- CREATE TRIGGER 'trigger_edad_trabajador()'
CREATE TRIGGER trigger_edad_trabajador
BEFORE INSERT OR UPDATE
ON trabajador
FOR EACH ROW
EXECUTE FUNCTION actualiza_edad();


-- Table 'telefonoTrabajador'
CREATE TABLE telefonoTrabajador (
  dniTrabajador CHAR(9) REFERENCES trabajador(dni) ON UPDATE CASCADE ON DELETE CASCADE,
  telefono VARCHAR(9) NOT NULL CHECK (telefono ~ '^\d{9}$')
);


-- Table 'emailTrabajador'
CREATE TABLE emailTrabajador (
  dniTrabajador CHAR(9) REFERENCES trabajador(dni) ON UPDATE CASCADE ON DELETE CASCADE,
  email VARCHAR(255) NOT NULL
);


-- Table 'usuarioAdulto'
CREATE TABLE usuarioAdulto (
  id SERIAL PRIMARY KEY,
  nombre VARCHAR(50) NOT NULL,
  apellido1 VARCHAR(50) NOT NULL,
  apellido2 VARCHAR(50),
  fchNacimiento DATE NOT NULL CHECK (fchNacimiento BETWEEN '1900-01-01' AND CURRENT_DATE),
  fchHoraRegistro TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, -- Creo que puede hacerse con un trigger mejor
  sexo CHAR(1) CHECK (sexo IN ('M', 'F', 'O')),
  edad SMALLINT CHECK (edad > 0),
  dni CHAR(9) NOT NULL UNIQUE CHECK (dni ~ '\d{8}[A-Za-z]$'),
  estudiante BOOLEAN NOT NULL
);

-- CREATE TRIGGER 'trigger_edad_adulto()'
CREATE TRIGGER trigger_edad_adulto
BEFORE INSERT OR UPDATE
ON usuarioAdulto
FOR EACH ROW
EXECUTE FUNCTION actualiza_edad();

-- Table 'tarjetaSocio'
CREATE TABLE tarjetaSocio (
  id SERIAL PRIMARY KEY,
  color VARCHAR(5) NOT NULL CHECK (color IN ('Azul', 'Rojo', 'Verde'))
);

-- Table 'usuarioMenor'
CREATE TABLE usuarioMenor (
  id SERIAL PRIMARY KEY,
  nombre VARCHAR(50) NOT NULL,
  apellido1 VARCHAR(50) NOT NULL,
  apellido2 VARCHAR(50),
  fchNacimiento DATE NOT NULL CHECK (fchNacimiento BETWEEN '1900-01-01' AND CURRENT_DATE),
  fchHoraRegistro TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, -- Creo que puede hacerse con un trigger mejor
  sexo CHAR(1) CHECK (sexo IN ('M', 'F', 'O')),
  edad SMALLINT CHECK (edad > 0),
  idTarjetaSocio INT REFERENCES tarjetaSocio(id) ON UPDATE CASCADE ON DELETE RESTRICT
);

-- CREATE TRIGGER 'trigger_edad_menor()'
CREATE TRIGGER trigger_edad_menor
BEFORE INSERT OR UPDATE
ON usuarioMenor
FOR EACH ROW
EXECUTE FUNCTION actualiza_edad();

-- Table 'tutorUsuarioMenor'
CREATE TABLE tutorUsuarioMenor (
  idUsuarioMenor INT REFERENCES usuarioMenor(id) ON UPDATE CASCADE ON DELETE CASCADE,
  dniTutor CHAR(9) NOT NULL CHECK (dniTutor ~ '\d{8}[A-Za-z]$')
);

-- Table 'telefonoUsuario'
CREATE TABLE telefonoUsuario (
  idUsuarioAdulto INT REFERENCES usuarioAdulto(id) ON UPDATE CASCADE ON DELETE CASCADE,
  idUsuarioMenor INT REFERENCES usuarioMenor(id) ON UPDATE CASCADE ON DELETE CASCADE,
  telefono VARCHAR(20) NOT NULL CHECK (LENGTH(telefono) = 9 AND telefono ~ '\d+')
);

-- CREATE FUNCTION 'un_idUsuario_debe_ser_nulo()'
CREATE OR REPLACE FUNCTION un_idUsuario_debe_ser_nulo() RETURNS TRIGGER AS $$
  BEGIN
    IF NEW.idUsuarioAdulto IS NULL AND NEW.idUsuarioMenor IS NULL THEN
      RAISE EXCEPTION 'idUsuarioAdulto OR idUsuarioMenor: ONE MUST HAVE A VALUE';
    END IF;
    IF NEW.idUsuarioAdulto IS NOT NULL AND NEW.idUsuarioMenor IS NOT NULL THEN
      RAISE EXCEPTION 'idUsuarioAdulto plus OR idUsuarioMenor: ONE MUST HAVE A NULL VALUE';
    END IF;
    RETURN NEW;
  END;
$$ LANGUAGE plpgsql;

-- CREATE TRIGGER 'trigger_telefono_usuario()'
CREATE TRIGGER trigger_telefono_usuario
BEFORE INSERT OR UPDATE 
ON telefonoUsuario
FOR EACH ROW 
EXECUTE PROCEDURE un_idUsuario_debe_ser_nulo();

-- Table 'emailUsuario'
CREATE TABLE emailUsuario (
  idUsuarioAdulto INT REFERENCES usuarioAdulto(id) ON UPDATE CASCADE ON DELETE CASCADE,
  idUsuarioMenor INT REFERENCES usuarioMenor(id) ON UPDATE CASCADE ON DELETE CASCADE,
  email VARCHAR(50) NOT NULL
);

-- CREATE TRIGGER 'email()'
CREATE TRIGGER trigger_email_usuario
BEFORE INSERT OR UPDATE 
ON emailUsuario
FOR EACH ROW 
EXECUTE PROCEDURE un_idUsuario_debe_ser_nulo();

-- Table 'provincia'
CREATE TABLE provincia (
    id serial PRIMARY KEY,
    nombreProvincia VARCHAR(255) NOT NULL
);


-- Table 'isla'
CREATE TABLE Isla (
    id serial PRIMARY KEY,
    nombreIsla VARCHAR(255) NOT NULL,
    latitud POINT NOT NULL,
    longitud POINT NOT NULL,
    idProvincia INT REFERENCES provincia(id) ON UPDATE CASCADE ON DELETE RESTRICT
);


-- Table 'direccion'
CREATE TABLE direccion (
    id serial PRIMARY KEY,
    ciudad VARCHAR(255) NOT NULL,
    codigoPostal CHAR(5) NOT NULL CHECK (codigoPostal ~ '\d+'),
    direccion1 TEXT NOT NULL,
    direccion2 TEXT,
    dniTrabajador CHAR(9) REFERENCES trabajador(dni) ON UPDATE CASCADE ON DELETE CASCADE,
    idUsuarioAdulto INT REFERENCES usuarioAdulto(id) ON UPDATE CASCADE ON DELETE CASCADE,
    idUsuarioMenor INT REFERENCES usuarioMenor(id) ON UPDATE CASCADE ON DELETE CASCADE,
    idIsla INT REFERENCES isla(id) ON UPDATE CASCADE ON DELETE RESTRICT
);

-- CREATE FUNCTION 'idUsuario_o_dniTrabajador_debe_ser_nulo()'
CREATE OR REPLACE FUNCTION idUsuario_o_dniTrabajador_debe_ser_nulo() RETURNS TRIGGER AS $$
  BEGIN
    IF NOT (
      (NEW.idUsuarioAdulto IS NULL AND NEW.idUsuarioMenor IS NULL AND NEW.dniTrabajador IS NOT NULL) OR
      (NEW.idUsuarioAdulto IS NULL AND NEW.idUsuarioMenor IS NOT NULL AND NEW.dniTrabajador IS NULL) OR
      (NEW.idUsuarioAdulto IS NOT NULL AND NEW.idUsuarioMenor IS NULL AND NEW.dniTrabajador IS NULL)
    ) THEN
      RAISE EXCEPTION 'Exactly one of idUsuarioAdulto, idUsuarioMenor or dniTrabajador must have a value, and the others must be NULL';
    END IF;
    RETURN NEW;
  END;
$$ LANGUAGE plpgsql;

-- CREATE TRIGGER 'trigger_direccion_idUsuario_dniTrabajador()'
CREATE TRIGGER trigger_direccion_idUsuario_dniTrabajador
BEFORE INSERT OR UPDATE 
ON direccion
FOR EACH ROW 
EXECUTE PROCEDURE idUsuario_o_dniTrabajador_debe_ser_nulo();