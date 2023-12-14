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
