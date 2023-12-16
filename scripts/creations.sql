/**
 * * * TABLE CREATIONS
 */

-- TABLE 'articulo'                                             -- Falta TRIGGER 'Prestación'
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
  sexo CHAR(1) CHECK (sexo in ('M', 'F', 'O')),
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
  idMaterialAudiovisual INT REFERENCES materialAudiovisual(idArticulo) ON UPDATE CASCADE ON DELETE RESTRICT,
  idAutor INT REFERENCES autor(id) ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE Trabajador (
  DNI VARCHAR(9) PRIMARY KEY CHECK (DNI ~ '\d{8}[A-Za-z]$'),
  Nombre VARCHAR(50) NOT NULL,
  Apellido_1 VARCHAR(50) NOT NULL,
  Apellido_2 VARCHAR(50),
  Fecha_Nacimiento DATE NOT NULL CHECK (Fecha_Nacimiento BETWEEN '1900-01-01' AND CURRENT_DATE),
  Nombre_Usuario VARCHAR(50) NOT NULL UNIQUE,
  Sexo CHAR(1) CHECK (Sexo IN ('M', 'F', 'O')),
  Contraseña VARCHAR(255) NOT NULL,
  Edad SMALLINT CHECK (Edad > 0),
  Activo BOOLEAN GENERATED ALWAYS AS (EXISTS (SELECT 1 FROM Periodo WHERE Trabajador.DNI = Periodo.DNI AND Fecha_Fin IS NULL)) STORED,
  Fecha_Hora_Registro TIMESTAMP WITHOUT TIME ZONE NOT NULL,
  CONSTRAINT chk_activo_fecha_hora CHECK (NOT (Activo AND Fecha_Hora_Registro IS NULL)),
  CONSTRAINT chk_fecha_nacimiento_registro CHECK (Fecha_Nacimiento <= Fecha_Hora_Registro)
  
);

-- REVISAR CONSTRAINTS UNA FORMA QUE LO SAQUE DE GPT Y ACTIVO 

-- CREATE FUNCTION 'actualiza_edad_trabajador()'
CREATE OR REPLACE FUNCTION actualiza_edad_trabajador() RETURNS TRIGGER AS $$
  BEGIN
    IF NEW.Fecha_Nacimiento IS NOT NULL THEN
      NEW.Edad = DATE_PART('year', AGE(CURRENT_DATE, NEW.Fecha_Nacimiento));
    ELSE
      NEW.Edad = NULL;
    END IF;
    RETURN NEW;
  END;
$$ LANGUAGE plpgsql;

-- CREATE TRIGGER 'trigger_edad_trabajador)'
CREATE TRIGGER trigger_edad_trabajador
BEFORE INSERT OR UPDATE
ON Trabajador
FOR EACH ROW
EXECUTE FUNCTION actualiza_edad_trabajador();

CREATE TABLE TeléfonoTrabajador (
  DNI_Trabajador VARCHAR(9) REFERENCES Trabajador(DNI),
  Teléfono VARCHAR(9) NOT NULL CHECK (Teléfono ~ '^\d{9}$'),
  PRIMARY KEY (DNI_Trabajador, Teléfono)
);

CREATE TABLE EmailTrabajador (
  DNI_Trabajador VARCHAR(9) REFERENCES Trabajador(DNI),
  Email VARCHAR(255) NOT NULL,
  PRIMARY KEY (DNI_Trabajador, Email)
);

CREATE TABLE Usuario_Adulto (
  ID SERIAL PRIMARY KEY,
  Nombre VARCHAR(50) NOT NULL,
  Apellido_1 VARCHAR(50) NOT NULL,
  Apellido_2 VARCHAR(50),
  Fecha_Nacimiento DATE NOT NULL CHECK (Fecha_Nacimiento BETWEEN '1900-01-01' AND CURRENT_DATE),
  Fecha_Hora_Registro TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  Sexo CHAR(1) CHECK (Sexo IN ('M', 'F', 'O')),
  Edad SMALLINT CHECK (Edad > 0),
  DNI VARCHAR(9) NOT NULL UNIQUE CHECK (DNI ~ '\d{8}[A-Za-z]$'),
  Estudiante BOOLEAN NOT NULL
);

-- CREATE FUNCTION 'actualiza_edad_adulto()'
CREATE OR REPLACE FUNCTION actualiza_edad_adulto() RETURNS TRIGGER AS $$
  BEGIN
    IF NEW.Fecha_Nacimiento IS NOT NULL THEN
      NEW.Edad = DATE_PART('year', AGE(CURRENT_DATE, NEW.Fecha_Nacimiento));
    ELSE
      NEW.Edad = NULL;
    END IF;
    RETURN NEW;
  END;
$$ LANGUAGE plpgsql;

-- CREATE TRIGGER 'trigger_edad_adulto)'
CREATE TRIGGER trigger_edad_adulto
BEFORE INSERT OR UPDATE
ON Usuario_Adulto
FOR EACH ROW
EXECUTE FUNCTION actualiza_edad_adulto();

-- Edad SMALLINT GENERATED ALWAYS AS (EXTRACT(YEAR FROM AGE(CURRENT_DATE, Fecha_Nacimiento))) STORED,

CREATE TABLE Usuario_Menor (
  ID SERIAL PRIMARY KEY,
  Nombre VARCHAR(50) NOT NULL,
  Apellido_1 VARCHAR(50) NOT NULL,
  Apellido_2 VARCHAR(50),
  Fecha_Nacimiento DATE NOT NULL CHECK (Fecha_Nacimiento BETWEEN '1900-01-01' AND CURRENT_DATE),
  Fecha_Hora_Registro TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  Sexo VARCHAR(10) CHECK (Sexo IN ('Masculino', 'Femenino', 'Otros')),
  Edad SMALLINT CHECK (Edad > 0)
);

-- CREATE FUNCTION 'actualiza_edad_menor()'
CREATE OR REPLACE FUNCTION actualiza_edad_menor() RETURNS TRIGGER AS $$
  BEGIN
    IF NEW.Fecha_Nacimiento IS NOT NULL THEN
      NEW.Edad = DATE_PART('year', AGE(CURRENT_DATE, NEW.Fecha_Nacimiento));
    ELSE
      NEW.Edad = NULL;
    END IF;
    RETURN NEW;
  END;
$$ LANGUAGE plpgsql;

-- CREATE TRIGGER 'trigger_edad_menor)'
CREATE TRIGGER trigger_edad_menor
BEFORE INSERT OR UPDATE
ON Usuario_Adulto
FOR EACH ROW
EXECUTE FUNCTION actualiza_edad_menor();

-- Tabla TutorUsuario_Menor
CREATE TABLE TutorUsuario_Menor (
  ID_Usuario_Menor SERIAL,
  DNI_Tutor VARCHAR(20) NOT NULL,
  PRIMARY KEY (ID_Usuario_Menor),
  FOREIGN KEY (ID_Usuario_Menor) REFERENCES Usuario_Menor(ID),
  CHECK (DNI_Tutor ~ '\d{8}[A-Za-z]$')
);

-- Tabla TeléfonoUsuario
CREATE TABLE TeléfonoUsuario (
  ID_Usuario_Adulto SERIAL,
  ID_Usuario_Menor SERIAL,
  Teléfono VARCHAR(20) NOT NULL,
  PRIMARY KEY (ID_Usuario_Adulto, ID_Usuario_Menor),
  FOREIGN KEY (ID_Usuario_Adulto) REFERENCES Usuario_Adulto(ID),
  FOREIGN KEY (ID_Usuario_Menor) REFERENCES Usuario_Menor(ID),
  CHECK (LENGTH(Teléfono) = 9 AND Teléfono ~ '\d+')
);

-- Tabla EmailUsuario
CREATE TABLE EmailUsuario (
  ID_Usuario_Adulto SERIAL,
  ID_Usuario_Menor SERIAL,
  Email VARCHAR(50) NOT NULL,
  PRIMARY KEY (ID_Usuario_Adulto, ID_Usuario_Menor),
  FOREIGN KEY (ID_Usuario_Adulto) REFERENCES Usuario_Adulto(ID),
  FOREIGN KEY (ID_Usuario_Menor) REFERENCES Usuario_Menor(ID)
);

-- Tabla Tarjeta_Socio
CREATE TABLE Tarjeta_Socio (
  ID SERIAL PRIMARY KEY,
  Color VARCHAR(10) NOT NULL CHECK (Color IN ('AZUL', 'ROJO', 'VERDE')),
  ID_Menor SERIAL,
  FOREIGN KEY (ID_Menor) REFERENCES Usuario_Menor(ID)
);

CREATE TABLE Provincia (
    ID serial PRIMARY KEY,
    Nombre_Provincia varchar(255) NOT NULL
);

CREATE TABLE Isla (
    ID serial PRIMARY KEY,
    Nombre_Isla varchar(255) NOT NULL,
    Latitud numeric NOT NULL,
    Longitud numeric NOT NULL,
    ID_Provincia integer REFERENCES Provincia(ID)
);

-- REVISAR DIRECCION

CREATE TABLE Dirección (
    ID serial PRIMARY KEY,
    Ciudad varchar(255) NOT NULL,
    CP varchar(10) NOT NULL,
    Dirección1 varchar(255) NOT NULL,
    Dirección2 varchar(255) NOT NULL,
    DNI_Trabajador varchar(9) REFERENCES Trabajador(DNI),
    CHECK (DNI_Trabajador ~ '\d{8}[A-Za-z]$'),
    ID_Usuario integer REFERENCES Usuario(ID),
    ID_Isla integer REFERENCES Isla(ID),
    CHECK (
        (DNI_Trabajador IS NOT NULL AND ID_Usuario IS NULL) OR
        (DNI_Trabajador IS NULL AND ID_Usuario IS NOT NULL)
    )
);

-- FALTA PRESTACION HORARIO DIA PERIODO 