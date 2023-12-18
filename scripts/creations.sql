/**
 * * * TABLE CREATIONS
 */

-- Tabla de articulos
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

-- Tabla de géneros de articulos
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
    'Informativo',
    'Anime')
  ),
  PRIMARY KEY (idArticulo,genero)
);


-- Tabla de autores
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

-- Función para calcular la edad dada una fecha de nacimiento
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

-- Trigger para generar la edad al insertar un autor
CREATE TRIGGER trigger_edad_autor
BEFORE INSERT OR UPDATE
ON autor
FOR EACH ROW
EXECUTE FUNCTION actualiza_edad();


-- Tabla de libros
CREATE TABLE libro (
  idArticulo INT REFERENCES articulo(id) ON UPDATE CASCADE ON DELETE RESTRICT,
  editorial VARCHAR(50) NOT NULL,
  numPaginas INT NOT NULL CHECK (numPaginas > 0),
  estilo VARCHAR(9) NOT NULL CHECK (estilo IN ('Narrativo', 'Poetico', 'Dramatico', 'Epico', 'Lirico', 'Didactico', 'Satirico')),
  sinopsis TEXT,
  idAutor INT REFERENCES autor(id) ON UPDATE CASCADE ON DELETE RESTRICT,
  PRIMARY KEY (idArticulo)
);

-- Función que comprueba si un artículo es de tipo 'libro'
CREATE OR REPLACE FUNCTION check_tipo_libro() RETURNS TRIGGER AS $$
  BEGIN
    IF (SELECT tipo FROM articulo WHERE id = NEW.idArticulo) != 'libro' THEN
      RAISE EXCEPTION 'Error: el articulo a insertar en la tabla ''libro'' no posee el tipo ''libro''';
    END IF;
    RETURN NEW;
  END;
$$ LANGUAGE plpgsql;

-- Trigger para el evento de inserción en la tabla libro
CREATE TRIGGER trigger_check_tipo_libro
BEFORE INSERT OR UPDATE
ON libro
FOR EACH ROW
EXECUTE FUNCTION check_tipo_libro();


-- Tabla de materiales periódicos (periódicos o revistas)
CREATE TABLE materialPeriodico (
  idArticulo INT REFERENCES articulo(id) ON UPDATE CASCADE ON DELETE RESTRICT,
  editorial VARCHAR(50) NOT NULL,
  numPaginas INT NOT NULL CHECK (numPaginas > 0),
  tipo VARCHAR(9) NOT NULL CHECK (tipo IN ('Periodico', 'Revista')),
  PRIMARY KEY (idArticulo)
);

-- Función que comprueba si un artículo es de tipo 'materialPeriodico'
CREATE OR REPLACE FUNCTION check_tipo_materialPeriodico() RETURNS TRIGGER AS $$
  BEGIN
    IF (SELECT tipo FROM articulo WHERE id = NEW.idArticulo) != 'materialPeriodico' THEN
      RAISE EXCEPTION 'Error: el articulo a insertar en la tabla ''materialPeriodico'' no posee el tipo ''materialPeriodico''';
    END IF;
    RETURN NEW;
  END;
$$ LANGUAGE plpgsql;

-- Trigger para el evento de inserción en la tabla materialPeriodico
CREATE TRIGGER trigger_check_tipo_materialPeriodico
BEFORE INSERT OR UPDATE
ON materialPeriodico
FOR EACH ROW
EXECUTE FUNCTION check_tipo_materialPeriodico();


-- Tabla de materiales audiovisuales (peliculas, documentales o series)
CREATE TABLE materialAudiovisual (
  idArticulo INT REFERENCES articulo(id) ON UPDATE CASCADE ON DELETE RESTRICT,
  duracion INTERVAL CHECK (duracion > '00:00:00'),
  categoria VARCHAR(10) NOT NULL CHECK (categoria IN ('Pelicula', 'Documental', 'Serie')),
  tipo VARCHAR(10) NOT NULL CHECK (tipo IN ('DVD', 'CD', 'CD_ROM', 'VHS', 'Audiolibro')),
  PRIMARY KEY (idArticulo)
);

-- Función que comprueba si un artículo es de tipo 'materialAudiovisual'
CREATE OR REPLACE FUNCTION check_tipo_materialAudiovisual() RETURNS TRIGGER AS $$
  BEGIN
    IF (SELECT tipo FROM articulo WHERE id = NEW.idArticulo) != 'materialAudiovisual' THEN
      RAISE EXCEPTION 'Error: el articulo a insertar en la tabla ''materialAudiovisual'' no posee el tipo ''materialAudiovisual''';
    END IF;
    RETURN NEW;
  END;
$$ LANGUAGE plpgsql;

-- Trigger para el evento de inserción en la tabla materialAudiovisual
CREATE TRIGGER trigger_check_tipo_materialAudiovisual
BEFORE INSERT OR UPDATE
ON materialAudiovisual
FOR EACH ROW
EXECUTE FUNCTION check_tipo_materialAudiovisual();


-- Tabla de los posibles autores de materiales audiovisuales
CREATE TABLE autor_materialAudiovisual (
  idMaterialAudiovisual INT REFERENCES materialAudiovisual(idArticulo) ON UPDATE CASCADE ON DELETE CASCADE,
  idAutor INT REFERENCES autor(id) ON UPDATE CASCADE ON DELETE RESTRICT,
  PRIMARY KEY (idMaterialAudiovisual, idAutor)
);


-- Tabla de trabajadores
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
  fchHoraRegistro TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  activo BOOLEAN NOT NULL DEFAULT FALSE,
  CONSTRAINT chk_fchNacimiento_registro CHECK (fchNacimiento <= fchHoraRegistro)
);

-- Trigger para generar la edad al insertar un trabajador
CREATE TRIGGER trigger_edad_trabajador
BEFORE INSERT OR UPDATE
ON trabajador
FOR EACH ROW
EXECUTE FUNCTION actualiza_edad();


-- Tabla de teléfonos de trabajadores
CREATE TABLE telefonoTrabajador (
  dniTrabajador CHAR(9) REFERENCES trabajador(dni) ON UPDATE CASCADE ON DELETE CASCADE,
  telefono VARCHAR(9) NOT NULL CHECK (telefono ~ '^\d{9}$'),
  PRIMARY KEY (dniTrabajador, telefono)
);


-- Tabla de email's de trabajadores
CREATE TABLE emailTrabajador (
  dniTrabajador CHAR(9) REFERENCES trabajador(dni) ON UPDATE CASCADE ON DELETE CASCADE,
  email VARCHAR(255) NOT NULL,
  PRIMARY KEY (dniTrabajador, email)
);


-- Tabla de usuarios adultos
CREATE TABLE usuarioAdulto (
  id SERIAL PRIMARY KEY,
  nombre VARCHAR(50) NOT NULL,
  apellido1 VARCHAR(50) NOT NULL,
  apellido2 VARCHAR(50),
  fchNacimiento DATE NOT NULL CHECK (fchNacimiento BETWEEN '1900-01-01' AND CURRENT_DATE),
  fchHoraRegistro TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  sexo CHAR(1) CHECK (sexo IN ('M', 'F', 'O')),
  edad SMALLINT CHECK (edad >= 18),
  dni CHAR(9) NOT NULL UNIQUE CHECK (dni ~ '\d{8}[A-Za-z]$'),
  estudiante BOOLEAN NOT NULL
);

-- Trigger para generar la edad al insertar un adulto
CREATE TRIGGER trigger_edad_adulto
BEFORE INSERT OR UPDATE
ON usuarioAdulto
FOR EACH ROW
EXECUTE FUNCTION actualiza_edad();

-- Tabla de tarjetas de socio
CREATE TABLE tarjetaSocio (
  id SERIAL PRIMARY KEY,
  color VARCHAR(5) NOT NULL CHECK (color IN ('Azul', 'Rojo', 'Verde'))
);

-- Tabla de usuarios menores
CREATE TABLE usuarioMenor (
  id SERIAL PRIMARY KEY,
  nombre VARCHAR(50) NOT NULL,
  apellido1 VARCHAR(50) NOT NULL,
  apellido2 VARCHAR(50),
  fchNacimiento DATE NOT NULL CHECK (fchNacimiento BETWEEN '1900-01-01' AND CURRENT_DATE),
  fchHoraRegistro TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  sexo CHAR(1) CHECK (sexo IN ('M', 'F', 'O')),
  edad SMALLINT CHECK (edad > 0 AND edad < 18),
  idTarjetaSocio INT UNIQUE REFERENCES tarjetaSocio(id) ON UPDATE CASCADE ON DELETE RESTRICT
);

-- Trigger para generar la edad al insertar un usuario menor
CREATE TRIGGER trigger_edad_menor
BEFORE INSERT OR UPDATE
ON usuarioMenor
FOR EACH ROW
EXECUTE FUNCTION actualiza_edad();

-- Tabla de posibles tutores de usuarios menores
CREATE TABLE tutorUsuarioMenor (
  idUsuarioMenor INT REFERENCES usuarioMenor(id) ON UPDATE CASCADE ON DELETE CASCADE,
  dniTutor CHAR(9) NOT NULL CHECK (dniTutor ~ '\d{8}[A-Za-z]$'),
  PRIMARY KEY(idUsuarioMenor, dniTutor)
);

-- Tabla de telefonos de usuarios (adultos y menores)
CREATE TABLE telefonoUsuario (
  idUsuarioAdulto INT REFERENCES usuarioAdulto(id) ON UPDATE CASCADE ON DELETE CASCADE,
  idUsuarioMenor INT REFERENCES usuarioMenor(id) ON UPDATE CASCADE ON DELETE CASCADE,
  telefono VARCHAR(20) NOT NULL CHECK (LENGTH(telefono) = 9 AND telefono ~ '\d+'),
  UNIQUE(idUsuarioAdulto, idUsuarioMenor, telefono) 
);

-- Función que comprueba que un identificador de usuario (adulto o menor) deba ser nulo y el otro no
CREATE OR REPLACE FUNCTION un_idUsuario_debe_ser_nulo() RETURNS TRIGGER AS $$
  BEGIN
    IF NEW.idUsuarioAdulto IS NULL AND NEW.idUsuarioMenor IS NULL THEN
      RAISE EXCEPTION 'Error: un identificador de usuario (adulto o menor) debe tener un valor no nulo';
    END IF;
    IF NEW.idUsuarioAdulto IS NOT NULL AND NEW.idUsuarioMenor IS NOT NULL THEN
      RAISE EXCEPTION 'Error: un identificador de usuario (adulto o menor) debe tener un valor nulo';
    END IF;
    RETURN NEW;
  END;
$$ LANGUAGE plpgsql;

-- Trigger para el evento de inserción en la tabla 'telefonoUsuario'
CREATE TRIGGER trigger_telefono_usuario
BEFORE INSERT OR UPDATE 
ON telefonoUsuario
FOR EACH ROW 
EXECUTE PROCEDURE un_idUsuario_debe_ser_nulo();

-- Tabla de email's de usuarios (adultos y menores)
CREATE TABLE emailUsuario (
  idUsuarioAdulto INT REFERENCES usuarioAdulto(id) ON UPDATE CASCADE ON DELETE CASCADE,
  idUsuarioMenor INT REFERENCES usuarioMenor(id) ON UPDATE CASCADE ON DELETE CASCADE,
  email VARCHAR(50) NOT NULL,
  UNIQUE(idUsuarioAdulto, idUsuarioMenor, email) 
);

-- Trigger para el evento de inserción en la tabla 'emailUsuario'
CREATE TRIGGER trigger_email_usuario
BEFORE INSERT OR UPDATE 
ON emailUsuario
FOR EACH ROW 
EXECUTE PROCEDURE un_idUsuario_debe_ser_nulo();


-- Tabla de provincias
CREATE TABLE provincia (
    id SERIAL PRIMARY KEY,
    nombreProvincia VARCHAR(255) NOT NULL
);


-- Tabla de islas
CREATE TABLE Isla (
    id SERIAL PRIMARY KEY,
    idProvincia INT REFERENCES provincia(id) ON UPDATE CASCADE ON DELETE RESTRICT,
    nombreIsla VARCHAR(255) NOT NULL,
    latitud POINT NOT NULL,
    longitud POINT NOT NULL
);


-- Tabla de direcciones
CREATE TABLE direccion (
    id SERIAL PRIMARY KEY,
    idIsla INT REFERENCES isla(id) ON UPDATE CASCADE ON DELETE RESTRICT,
    ciudad VARCHAR(255) NOT NULL,
    codigoPostal CHAR(5) NOT NULL CHECK (codigoPostal ~ '\d+'),
    direccion1 TEXT NOT NULL,
    direccion2 TEXT,
    dniTrabajador CHAR(9) REFERENCES trabajador(dni) ON UPDATE CASCADE ON DELETE CASCADE,
    idUsuarioAdulto INT REFERENCES usuarioAdulto(id) ON UPDATE CASCADE ON DELETE CASCADE,
    idUsuarioMenor INT REFERENCES usuarioMenor(id) ON UPDATE CASCADE ON DELETE CASCADE
);

-- Funcion que comprueba si de los campos idUsuarioMenor, idUsuarioAdulto y dniTrabajador; al menos 2 de ellos son nulos y el otro no nulo
CREATE OR REPLACE FUNCTION idUsuario_o_dniTrabajador_debe_ser_nulo() RETURNS TRIGGER AS $$
  BEGIN
    IF NOT (
      (NEW.idUsuarioAdulto IS NULL AND NEW.idUsuarioMenor IS NULL AND NEW.dniTrabajador IS NOT NULL) OR
      (NEW.idUsuarioAdulto IS NULL AND NEW.idUsuarioMenor IS NOT NULL AND NEW.dniTrabajador IS NULL) OR
      (NEW.idUsuarioAdulto IS NOT NULL AND NEW.idUsuarioMenor IS NULL AND NEW.dniTrabajador IS NULL)
    ) THEN
      RAISE EXCEPTION 'Error: solamente uno de los campos ''idUsuarioMenor'', ''idUsuarioAdulto'' y ''dniTrabajador'' debe tener un valor y los otros no';
    END IF;
    RETURN NEW;
  END;
$$ LANGUAGE plpgsql;

-- Trigger para el evento de inserción en la tabla dirección
CREATE TRIGGER trigger_direccion_idUsuario_dniTrabajador
BEFORE INSERT OR UPDATE 
ON direccion
FOR EACH ROW 
EXECUTE PROCEDURE idUsuario_o_dniTrabajador_debe_ser_nulo();


-- Tabla de horarios
CREATE TABLE horario (
  id SERIAL PRIMARY KEY,
  dniTrabajador CHAR(9) REFERENCES trabajador(dni) ON UPDATE CASCADE ON DELETE SET NULL,
  fchInicio DATE NOT NULL,
  fchFin DATE,
  CHECK (fchInicio <= fchFin)
);

-- Función que comprueba que 2 periodos de trabajo no se solapen
CREATE OR REPLACE FUNCTION check_solapamiento_periodos()
RETURNS TRIGGER AS $$
BEGIN
    IF EXISTS (
        SELECT 1
        FROM horario
        WHERE dniTrabajador = NEW.dniTrabajador
        AND (NEW.fchInicio, NEW.fchFin) OVERLAPS (fchInicio, fchFin)
    ) THEN
        RAISE EXCEPTION 'Error: un mismo trabajador no puede haber trabajado o trabajar en periodos coincidentes';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger para el evento de inserción en la tabla horario para comprobar periodos
CREATE TRIGGER periodos_no_se_solapan_para_un_mismo_trabajador
BEFORE INSERT OR UPDATE
ON horario
FOR EACH ROW
EXECUTE PROCEDURE check_solapamiento_periodos();

-- Funcion que comprueba que no puedan haber mas de 2 periodos no finalizados para un mismo trabajador
CREATE OR REPLACE FUNCTION check_no_mas_de_2_periodos_con_fchFin_null()
RETURNS TRIGGER AS $$
BEGIN
  IF NEW.fchFin IS NULL AND (SELECT COUNT(*) FROM horario WHERE dniTrabajador = NEW.dniTrabajador AND fchFin = NULL) >= 1 THEN
    RAISE EXCEPTION 'Error: un empleado no puede tener más de un periodo no finalizado';
  END IF;
END;
$$ LANGUAGE plpgsql;

-- Trigger para el evento de inserción en la tabla horario para comprobar que no existan 2 periodos nulos
CREATE TRIGGER trigger_un_trabajador_solo_puede_tener_un_periodo_nulo
BEFORE INSERT OR UPDATE
ON horario
FOR EACH ROW
EXECUTE PROCEDURE check_no_mas_de_2_periodos_con_fchFin_null();

-- Función para actualizar el atributo 'activo' de un trabajador a 'true' si se establece un nuevo periodo no finalizado
CREATE OR REPLACE FUNCTION actualiza_campo_activo_a_true_en_trabajador()
RETURNS TRIGGER AS $$
BEGIN
  IF NEW.fchFin IS NULL THEN
    UPDATE trabajador
    SET activo = TRUE
    WHERE dni = NEW.dniTrabajador;
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger para el evento de inserción en la tabla horario para actualizar (si es el caso) el campo 'activo' de un trabajador
CREATE TRIGGER trigger_trabajador_comienza_periodo
BEFORE INSERT OR UPDATE
ON horario
FOR EACH ROW
EXECUTE PROCEDURE actualiza_campo_activo_a_true_en_trabajador();

-- Función para actualizar el atributo 'activo' de un trabajador a 'false' si se completa un periodo que estaba no finalizado
CREATE OR REPLACE FUNCTION actualiza_campo_activo_a_false_en_trabajador()
RETURNS TRIGGER AS $$
BEGIN
  IF OLD.fchFin IS NULL AND NEW.fchFin IS NOT NULL THEN
    UPDATE trabajador
    SET activo = FALSE
    WHERE dni = NEW.dniTrabajador;
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger para el evento de actualización en la tabla horario para actualizar (si es el caso) el campo 'activo' de un trabajador
CREATE TRIGGER trigger_trabajador_termina_periodo
AFTER UPDATE
ON horario
FOR EACH ROW
EXECUTE PROCEDURE actualiza_campo_activo_a_false_en_trabajador();

-- Función que comprueba que la fecha de inicio de un periodo de trabajo sea mayor q o igualue la fecha en la que se registró el trabajador
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

-- Trigger para el evento de inserción o actualización en la fecha horario que compara las fechas 'registro' e 'inicio de periodo'
CREATE TRIGGER fchInicio_mayor_igual_fchRegistro
BEFORE INSERT OR UPDATE 
ON horario
FOR EACH ROW 
EXECUTE PROCEDURE fchInicio_mayor_igual_fchRegistro();


-- Tabla de días
CREATE TABLE dia (
  idHorario INT REFERENCES horario(id) ON UPDATE CASCADE ON DELETE CASCADE,
  nombre VARCHAR(9) NOT NULL CHECK (nombre in ('Lunes', 'Martes', 'Miercoles', 'Jueves', 'Viernes', 'Sabado', 'Domingo')),
  PRIMARY KEY (idHorario, nombre)
);

-- Tabla de periodos de tiempo
CREATE TABLE periodo (
  id SERIAL PRIMARY KEY,
  idHorario INT,
  nombreDia VARCHAR(9),
  horaInicio TIME NOT NULL,
  horaFin TIME NOT NULL,
  FOREIGN KEY (idHorario, nombreDia) REFERENCES dia(idHorario, nombre) ON UPDATE CASCADE ON DELETE CASCADE,
  CHECK (horaInicio <= horaFin)
);

-- Tabla de prestaciones de articulos
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
  CHECK (fchInicio <= fchFin),
  CHECK (fchInicio <= fchDevolucion)
);

-- Función que establece la fecha de devolución de los artículos (14 días más de la fecha de inicio)
CREATE OR REPLACE FUNCTION set_fchFin_default()
RETURNS TRIGGER AS $$
BEGIN
  NEW.fchFin = NEW.fchInicio + INTERVAL '14 days';
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger para el evento de inserción en la tabla 'prestación' que genera el campo 'fchFin'
CREATE TRIGGER set_fchFin_default
BEFORE INSERT ON prestacion
FOR EACH ROW EXECUTE FUNCTION set_fchFin_default();

-- Trigger para el evento de inserción o actualización en la tabla de prestacion que comprueba que un idUsuario deba ser nulo y el otro no
CREATE TRIGGER trigger_prestacion_usuario
BEFORE INSERT OR UPDATE 
ON prestacion
FOR EACH ROW 
EXECUTE PROCEDURE un_idUsuario_debe_ser_nulo();

-- Función que comprueba que el número de prestaciones realizadas sea igual o menor a 5 o 7 (dependiendo del usuario)
CREATE OR REPLACE FUNCTION numero_prestaciones_menor_o_igual_a_5_o_7() RETURNS TRIGGER AS $$
  BEGIN
    IF (NEW.idUsuarioAdulto IS NOT NULL AND NEW.idUsuarioMenor IS NULL) THEN
      IF (
          TRUE = (SELECT estudiante FROM usuarioAdulto WHERE idUsuarioAdulto = NEW.idUsuarioAdulto) -- Si es adulto estudiante (prestaciones <= 7)
        ) THEN
          IF (
            7 <= (SELECT COUNT(*) FROM prestacion WHERE idUsuarioMenor = NEW.idUsuarioMenor AND vigente = TRUE GROUP BY idUsuarioMenor) 
          ) THEN
          RAISE EXCEPTION 'Error: el numero de prestaciones vigentes permitidas para un usuario adulto estudiante debe ser 7 o menos';
          END IF;
      ELSE -- Si es adulto no estudiante (prestaciones <= 5)
        IF (
            5 <= (SELECT COUNT(*) FROM prestacion WHERE idUsuarioMenor = NEW.idUsuarioMenor AND vigente = TRUE GROUP BY idUsuarioMenor) 
          ) THEN
          RAISE EXCEPTION 'Error: el numero de prestaciones vigentes permitidas para un usuario adulto no estudiante debe ser 5 o menos';
          END IF;
      END IF;
    END IF;
    IF (NEW.idUsuarioAdulto IS NULL AND NEW.idUsuarioMenor IS NOT NULL) THEN -- Si el usuario es menor (prestaciones <= 7) 
      IF (
        7 <= (SELECT COUNT(*) FROM prestacion WHERE idUsuarioMenor = NEW.idUsuarioMenor AND vigente = TRUE GROUP BY idUsuarioMenor) 
      ) THEN
        RAISE EXCEPTION 'Error: el numero de prestaciones vigentes permitidas para un usuario menor debe ser 7 o menos';
      END IF;
    END IF;
    
    RETURN NEW;
  END;
$$ LANGUAGE plpgsql;

-- Trigger para el evento de inserción o actualización en la tabla 'horario' para el máximo de prestaciones permitidas
CREATE TRIGGER comprobacion_numero_prestaciones
BEFORE INSERT OR UPDATE 
ON horario
FOR EACH ROW 
EXECUTE PROCEDURE numero_prestaciones_menor_o_igual_a_5_o_7();

-- Función que disminuye el campo 'stock' de un artículo en 1 unidad
CREATE OR REPLACE FUNCTION disminuye_articulo_stock() RETURNS TRIGGER AS $$
  BEGIN
    UPDATE articulo
    SET stock = stock - 1
    WHERE id = NEW.idArticulo;

    RETURN NEW;
  END;
$$ LANGUAGE plpgsql;

-- Función que aumenta el campo 'stock' de un artículo en 1 unidad
CREATE OR REPLACE FUNCTION aumenta_articulo_stock() RETURNS TRIGGER AS $$
  BEGIN
    IF OLD.vigente = TRUE AND (NEW.vigente = FALSE OR NEW.vigente == NULL) THEN
      UPDATE articulo
      SET stock = stock + 1
      WHERE id = OLD.idArticulo;
    END IF;
    RETURN NEW;
  END;
$$ LANGUAGE plpgsql;

-- Trigger que disminuye el stock de un artículo al crear una prestación
CREATE TRIGGER disminuir_stock_al_crear_prestacion
BEFORE INSERT
ON prestacion
FOR EACH ROW
EXECUTE PROCEDURE disminuye_articulo_stock();

-- Trigger que aumenta el stock de un artículo al finalizar una prestación
CREATE TRIGGER aumentar_stock_al_finalizar_prestacion
AFTER UPDATE OR DELETE
ON prestacion
FOR EACH ROW
EXECUTE PROCEDURE aumenta_articulo_stock();