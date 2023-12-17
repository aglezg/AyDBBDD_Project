/**
 * * * TABLE CREATIONS
 */

-- TABLE 'articulo'
CREATE TABLE articulo (
  id SERIAL PRIMARY KEY,
  tipo VARCHAR(19) CHECK (tipo in ('libro', 'materialPeriodico', 'materialAudiovisual')),
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

-- CREATE FUNCTION 'check_tipo_libro()'
CREATE OR REPLACE FUNCTION check_tipo_libro() RETURNS TRIGGER AS $$
  BEGIN
    IF (SELECT tipo FROM articulo WHERE id = NEW.idArticulo) != 'libro' THEN
      RAISE EXCEPTION 'article to insert in table book has no type book';
    END IF;
    RETURN NEW;
  END;
$$ LANGUAGE plpgsql;

-- CREATE TRIGGER 'trigger_check_tipo_libro'
CREATE TRIGGER trigger_check_tipo_libro
BEFORE INSERT OR UPDATE
ON libro
FOR EACH ROW
EXECUTE FUNCTION check_tipo_libro();


-- Table 'materialPeriodico'
CREATE TABLE materialPeriodico (
  idArticulo INT REFERENCES articulo(id) ON UPDATE CASCADE ON DELETE RESTRICT,
  editorial VARCHAR(50) NOT NULL,
  numPaginas INT NOT NULL CHECK (numPaginas > 0),
  tipo VARCHAR(9) NOT NULL CHECK (tipo IN ('Periodico', 'Revista')),
  PRIMARY KEY (idArticulo)
);

-- CREATE FUNCTION 'check_tipo_materialPeriodico()'
CREATE OR REPLACE FUNCTION check_tipo_materialPeriodico() RETURNS TRIGGER AS $$
  BEGIN
    IF (SELECT tipo FROM articulo WHERE id = NEW.idArticulo) != 'materialPeriodico' THEN
      RAISE EXCEPTION 'article to insert in table newspaper has no type newspaper';
    END IF;
    RETURN NEW;
  END;
$$ LANGUAGE plpgsql;

-- CREATE TRIGGER 'trigger_check_tipo_materialPeriodico'
CREATE TRIGGER trigger_check_tipo_materialPeriodico
BEFORE INSERT OR UPDATE
ON materialPeriodico
FOR EACH ROW
EXECUTE FUNCTION check_tipo_materialPeriodico();


-- Table 'materialAudiovisual'
CREATE TABLE materialAudiovisual (
  idArticulo INT REFERENCES articulo(id) ON UPDATE CASCADE ON DELETE RESTRICT,
  duracion INTERVAL CHECK (duracion > '00:00:00'),
  categoria VARCHAR(10) NOT NULL CHECK (categoria IN ('Pelicula', 'Documental', 'Serie')),
  tipo VARCHAR(10) NOT NULL CHECK (tipo IN ('DVD', 'CD', 'CD_ROM', 'VHS', 'Audiolibro')),
  PRIMARY KEY (idArticulo)
);

-- CREATE FUNCTION 'check_tipo_materialAudiovisual()'
CREATE OR REPLACE FUNCTION check_tipo_materialAudiovisual() RETURNS TRIGGER AS $$
  BEGIN
    IF (SELECT tipo FROM articulo WHERE id = NEW.idArticulo) != 'materialAudiovisual' THEN
      RAISE EXCEPTION 'article to insert in table audiovisual has no type audiovisual';
    END IF;
    RETURN NEW;
  END;
$$ LANGUAGE plpgsql;

-- CREATE TRIGGER 'trigger_check_tipo_materialAudiovisual'
CREATE TRIGGER trigger_check_tipo_materialAudiovisual
BEFORE INSERT OR UPDATE
ON materialAudiovisual
FOR EACH ROW
EXECUTE FUNCTION check_tipo_materialAudiovisual();


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
    id SERIAL PRIMARY KEY,
    nombreProvincia VARCHAR(255) NOT NULL
);


-- Table 'isla'
CREATE TABLE Isla (
    id SERIAL PRIMARY KEY,
    nombreIsla VARCHAR(255) NOT NULL,
    latitud POINT NOT NULL,
    longitud POINT NOT NULL,
    idProvincia INT REFERENCES provincia(id) ON UPDATE CASCADE ON DELETE RESTRICT
);


-- Table 'direccion'
CREATE TABLE direccion (
    id SERIAL PRIMARY KEY,
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


-- Table 'Horario'
CREATE TABLE horario (
  id SERIAL PRIMARY KEY,
  dniTrabajador CHAR(9) REFERENCES trabajador(dni) ON UPDATE CASCADE ON DELETE SET NULL,
  fchInicio DATE NOT NULL,
  fchFin DATE,
  CHECK (fchInicio <= fchFin)
);

-- CREATE FUNCTION 'check_solapamiento_periodos()'
CREATE OR REPLACE FUNCTION check_solapamiento_periodos()
RETURNS TRIGGER AS $$
BEGIN
    IF EXISTS (
        SELECT 1
        FROM horario
        WHERE dniTrabajador = NEW.dniTrabajador
        AND (NEW.fchInicio, NEW.fchFin) OVERLAPS (fchInicio, fchFin)
    ) THEN
        RAISE EXCEPTION 'Started date and end date overlaps for the same employer';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- CREATE TRIGGER 'periodos_no_se_solapan_para_un_mismo_trabajador()'
CREATE TRIGGER periodos_no_se_solapan_para_un_mismo_trabajador
BEFORE INSERT OR UPDATE
ON horario
FOR EACH ROW
EXECUTE PROCEDURE check_solapamiento_periodos();

-- CREATE FUNCTION 'fchInicio_mayor_igual_fchRegistro()'
CREATE OR REPLACE FUNCTION fchInicio_mayor_igual_fchRegistro() RETURNS TRIGGER AS $$
  BEGIN
    IF (
      NEW.fchInicio < (SELECT fchHoraRegistro from trabajador WHERE dni = NEW.dniTrabajador)
    ) THEN
      RAISE EXCEPTION 'Init Date must be greater or equal than worker register date';
    END IF;
    RETURN NEW;
  END;
$$ LANGUAGE plpgsql;

-- CREATE TRIGGER 'fchInicio_mayor_igual_fchRegistro()'
CREATE TRIGGER fchInicio_mayor_igual_fchRegistro
BEFORE INSERT OR UPDATE 
ON horario
FOR EACH ROW 
EXECUTE PROCEDURE fchInicio_mayor_igual_fchRegistro();


-- Table 'dia'
CREATE TABLE dia (
  idHorario INT REFERENCES horario(id) ON UPDATE CASCADE ON DELETE CASCADE,
  nombre VARCHAR(9) NOT NULL CHECK (nombre in ('Lunes', 'Martes', 'Miercoles', 'Jueves', 'Viernes', 'Sabado', 'Domingo')),
  PRIMARY KEY (idHorario, nombre)
);

-- Table 'periodo'
CREATE TABLE periodo (
  id SERIAL PRIMARY KEY,
  horaInicio TIME NOT NULL,
  horaFin TIME NOT NULL,
  idHorario INT,
  nombreDia VARCHAR(9),
  FOREIGN KEY (idHorario, nombreDia) REFERENCES dia(idHorario, nombre) ON UPDATE CASCADE ON DELETE CASCADE,
  CHECK (horaInicio <= horaFin)
);

-- Table 'prestacion'
CREATE TABLE prestacion (
  id SERIAL PRIMARY KEY,
  idArticulo INT REFERENCES articulo(id) ON UPDATE CASCADE ON DELETE SET NULL,
  dniTrabajador CHAR(9) REFERENCES trabajador(dni) ON UPDATE CASCADE ON DELETE SET NULL,
  idUsuarioAdulto INT REFERENCES usuarioAdulto(id) ON UPDATE CASCADE ON DELETE SET NULL,
  idUsuarioMenor INT REFERENCES usuarioMenor(id) ON UPDATE CASCADE ON DELETE SET NULL,
  fchInicio DATE NULL DEFAULT CURRENT_DATE,
  fchFin DATE NULL,
  fchDevolucion DATE,
  vigente BOOLEAN GENERATED ALWAYS AS (fchDevolucion IS NULL) STORED,
  CHECK (fchInicio <= fchFin)
);

-- CREATE FUNCTION 'set_fchFin_default()'
CREATE OR REPLACE FUNCTION set_fchFin_default()
RETURNS TRIGGER AS $$
BEGIN
  NEW.fchFin = NEW.fchInicio + INTERVAL '14 days';
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- CREATE TRIGGER 'set_fchFin_default'
CREATE TRIGGER set_fchFin_default
BEFORE INSERT ON prestacion
FOR EACH ROW EXECUTE FUNCTION set_fchFin_default();

-- CREATE TRIGGER 'trigger_prestacion_usuario()'
CREATE TRIGGER trigger_prestacion_usuario
BEFORE INSERT OR UPDATE 
ON prestacion
FOR EACH ROW 
EXECUTE PROCEDURE un_idUsuario_debe_ser_nulo();

-- CREATE FUNCTION 'numero_prestaciones_menor_o_igual_a_5_o_7()'
CREATE OR REPLACE FUNCTION numero_prestaciones_menor_o_igual_a_5_o_7() RETURNS TRIGGER AS $$
  BEGIN
    IF (NEW.idUsuarioAdulto IS NOT NULL AND NEW.idUsuarioMenor IS NULL) THEN
      IF (
          TRUE = (SELECT estudiante FROM usuarioAdulto WHERE idUsuarioAdulto = NEW.idUsuarioAdulto)
        ) THEN
          IF (
            7 <= (SELECT COUNT(*) FROM prestacion WHERE idUsuarioMenor = NEW.idUsuarioMenor AND vigente = TRUE GROUP BY idUsuarioMenor) 
          ) THEN
          RAISE EXCEPTION 'Number of lendings for a adult student user cant be greater than 7';
          END IF;
      ELSE
        IF (
            5 <= (SELECT COUNT(*) FROM prestacion WHERE idUsuarioMenor = NEW.idUsuarioMenor AND vigente = TRUE GROUP BY idUsuarioMenor) 
          ) THEN
          RAISE EXCEPTION 'Number of lendings for a adult non student user cant be greater than 5';
          END IF;
      END IF;
    END IF;
    IF (NEW.idUsuarioAdulto IS NULL AND NEW.idUsuarioMenor IS NOT NULL) THEN
      IF (
        7 <= (SELECT COUNT(*) FROM prestacion WHERE idUsuarioMenor = NEW.idUsuarioMenor AND vigente = TRUE GROUP BY idUsuarioMenor) 
      ) THEN
        RAISE EXCEPTION 'Number of lendings for a minor age user cant be greater than 7';
      END IF;
    END IF;
    
    RETURN NEW;
  END;
$$ LANGUAGE plpgsql;

-- CREATE TRIGGER 'comprobacion_numero_prestaciones'
CREATE TRIGGER comprobacion_numero_prestaciones
BEFORE INSERT OR UPDATE 
ON horario
FOR EACH ROW 
EXECUTE PROCEDURE numero_prestaciones_menor_o_igual_a_5_o_7();

-- CREATE FUNCTION 'disminuye_articulo_stock()'
CREATE OR REPLACE FUNCTION disminuye_articulo_stock() RETURNS TRIGGER AS $$
  BEGIN
    UPDATE articulo
    SET stock = stock - 1
    WHERE id = NEW.idArticulo;

    RETURN NEW;
  END;
$$ LANGUAGE plpgsql;

-- CREATE FUNCTION 'aumenta_articulo_stock()'
CREATE OR REPLACE FUNCTION aumenta_articulo_stock() RETURNS TRIGGER AS $$
  BEGIN
    IF OLD.vigente = TRUE AND NEW.vigente = FALSE THEN
      UPDATE articulo
      SET stock = stock + 1
      WHERE id = NEW.idArticulo;
    END IF;
    RETURN NEW;
  END;
$$ LANGUAGE plpgsql;

-- CREATE TRIGGER 'disminuir_stock_al_crear_prestacion'
CREATE TRIGGER disminuir_stock_al_crear_prestacion
BEFORE INSERT
ON prestacion
FOR EACH ROW
EXECUTE PROCEDURE disminuye_articulo_stock();

-- CREATE TRIGGER 'aumentar_stock_al_finalizar_prestacion'
CREATE TRIGGER aumentar_stock_al_finalizar_prestacion
AFTER UPDATE
ON prestacion
FOR EACH ROW
EXECUTE PROCEDURE aumenta_articulo_stock();