**Articulo** (ID, Título, Subtítulo, Fecha_Publicación, Portada, Stock, Disponible)
  - ID: PRIMARY KEY
  - Titulo: NOT NULL
  - Fecha_Publicacion <= FECHA_ACTUAL
  - Stock: NOT NULL
  - Stock > 0
  - Stock TRIGGER actualizar cuando se cree o finalice una Prestacion
  - Disponible TRIGGER TRUE : Stock > 0, FALSE : Stock = 0

**Genero** (ID_Articulo, GeneroArticulo)
  - ID_Articulo: FOREIGN KEY de Articulo(ID)
  - GeneroArticulo: NOT NULL
  - GeneroArticulo CHECK IN [Novela, Cuento, Poesía, Ensayo, Biografía, Historia, Periodismo, Tragedia, Comedia, Fantasía, Distopía, Viaje-en-el-Tiempo, Misterio, Suspense, Detective, Thriller, Romance, Acción, Aventura, Comedia-Romántica, Drama, Melodrama, Ciencia-Ficción, Terror, Infantil, Anime]

**Libro** (ID_Articulo, Editorial, Número_Pag, Estilo, Sinopsis, ID_Autor)
  - ID_Articulo: PRIMARY KEY AND FOREIGN KEY de Articulo(ID)
  - ID_Autor: FOREIGN KEY de Autor(ID)
  - Editorial: NOT NULL
  - Numero_Pag: NOT NULL
  - Numero_Pag > 0
  - Estilo: NOT NULL
  - Estilo CHECK IN [Narrativo, Poético, Dramático, Épico, Lírico, Didáctico, Satírico]

**Material_Periódico** (ID_Articulo, Editorial, Número_Pag, Tipo)
  - ID_Articulo: PRIMARY KEY AND FOREIGN KEY de Articulo(ID)
  - Editorial: NOT NULL
  - Número_Pag > 0
  - Tipo: NOT NULL
  - Tipo CHECK IN [Revista, Periódico]

**Material_Audiovisual** (ID_Articulo, Duración, Categoría, Tipo)
  - ID_Articulo: PRIMARY KEY AND FOREIGN KEY de Articulo(ID)
  - Duracion > 00:00:00
  - Categoría: NOT NULL
  - Categoría CHECK IN [Película, Documental, Serie]
  - Tipo: NOT NULL
  - Tipo CHECK IN [DVD, CD, CD_ROM, VHS, Audiolibro]

**Autor** (ID, Fecha_Nacimiento, Fecha_Muerte, Sexo, Edad, Nombre, Apellido_1, Apellido_2)
  - ID: PRIMARY KEY
  - Fecha_Nacimiento <= FECHA_ACTUAL
  - Fecha_Muerte <= FECHA_ACTUAL
  - Fecha_Nacimiento <= Fecha_Muerte
  - Sexo CHECK IN [Masculino, Femenino, Otros]
  - Edad TRIGGER Fecha_Actual - Fecha_Nacimiento
  - Nombre: NOT NULL
  - Apellido_1: NOT NULL

**Autor_Mat_Audiovisual** (ID_Autor, ID_Mat_Audiovisual)
  - ID_Autor: FOREIGN KEY de Autor(ID)
  - ID_Mat_Audiovisual: FOREIGN KEY de Material_Audiovisual(ID)


**Trabajador** (DNI, Nombre, Apellido_1, Apellido_2, Fecha_Nacimiento, Nombre_Usuario, Sexo, Contraseña, Edad, Activo, Fecha_Hora_Registro) 
  - DNI: PRIMARY KEY
  - DNI CHECK (DNI ~ '\d{8}[A-Za-z]$')
  - Nombre: NOT NULL
  - Apellido_1: NOT NULL
  - Fecha_Nacimiento: NOT NULL
  - Fecha_Nacimiento  BETWEEN 1900 AND FECHA_ACTUAL
  - Nombre_Usuario: NOT NULL
  - Nombre_Usuario: UNIQUE
  - Sexo CHECK IN [Masculino, Femenino, Otros]
  - Contraseña: NOT NULL 
  - Activo TRIGGER Activo = True: existe un periodo que no haya finalizado
  - Fecha_Hora_Registro: NOT NULL
  - Fecha_Hora_Registro TRIGGER Fecha_Hora_Registro = Fecha_Hora_Inserción

**TeléfonoTrabajador** (DNI_Trabajador, Teléfono)
  - DNI_Trabajador: FOREIGN KEY de Trabajador(DNI)
  - Teléfono: NOT NULL
  - Teléfono CHECK 9 Dígitos Numéricos

**EmailTrabajador** (DNI_Trabajador, Email)
  - DNI_Trabajador: FOREIGN KEY de Trabajador(DNI)
  - Email: NOT NULL

**Usuario_Adulto** (ID, Nombre, Apellido_1, Apellido_2, Fecha_Nacimiento, Fecha_Hora_Registro, Sexo, Edad, DNI, Estudiante)
  - ID: PRIMARY KEY
  - Nombre: NOT NULL
  - Apellido_1: NOT NULL
  - Fecha_Nacimiento: NOT NULL
  - Fecha_Nacimiento  BETWEEN 1900 AND FECHA_ACTUAL
  - Fecha_Hora_Registro: NOT NULL
  - Fecha_Hora_Registro TRIGGER Fecha_Hora_Registro = Fecha_Hora_Inserción
  - Sexo CHECK IN [Masculino, Femenino, Otros]
  - Edad TRIGGER Fecha_Actual - Fecha_Nacimiento
  - DNI: NOT NULL
  - DNI: UNIQUE
  - DNI CHECK (DNI ~ '\d{8}[A-Za-z]$')
  - Estudiante: NOT NULL

**Usuario_Menor** (ID, Nombre, Apellido_1, Apellido_2, Fecha_Nacimiento, Fecha_Hora_Registro, Sexo, Edad)
  - ID: PRIMARY KEY
  - Nombre: NOT NULL
  - Apellido_1: NOT NULL
  - Fecha_Nacimiento: NOT NULL
  - Fecha_Nacimiento  BETWEEN 1900 AND FECHA_ACTUAL
  - Fecha_Hora_Registro: NOT NULL
  - Fecha_Hora_Registro TRIGGER Fecha_Hora_Registro = Fecha_Hora_Inserción
  - Sexo CHECK IN [Masculino, Femenino, Otros]
  - Edad TRIGGER Fecha_Actual - Fecha_Nacimiento

**TutorUsuario_Menor** (ID_Usuario_Menor, DNI_Tutor)
  - ID_Usuario_Menor: FOREIGN KEY de Usuario_Menor(ID)
  - DNI_Tutor: NOT NULL 
  - DNI_Tutor CHECK (DNI_Tutor ~ '\d{8}[A-Za-z]$')

**TeléfonoUsuario** (ID_Usuario_Adulto, ID_Usuario_Menor, Teléfono)
  - ID_Usuario_Adulto: FOREIGN KEY de Usuario_Adulto(ID)
  - ID_Usuario_Menor: FOREIGN KEY de Usuario_Menor(ID)
  - Teléfono: NOT NULL
  - Teléfono CHECK 9 Dígitos Numéricos

**EmailUsuario** (ID_Usuario_Adulto, ID_Usuario_Menor, Email)
  - ID_Usuario_Adulto: FOREIGN KEY de Usuario_Adulto(ID)
  - ID_Usuario_Menor: FOREIGN KEY de Usuario_Menor(ID)
  - Email: NOT NULL

**Tarjeta_Socio** (ID, Color, ID_Menor)
  - ID: PRIMARY KEY
  - Color: NOT NULL
  - Color CHECK IN [AZUL, ROJO, VERDE]
  - ID_Menor: FOREIGN KEY de Usuario_Menor(ID)

**Horario** (ID, ID_Trabajador, Periodo_Inicio, Periodo_Fin)
  - ID: PRIMARY KEY
  - ID_Trabajador: FOREIGN KEY de Trabajador(ID)
  - Periodo_Inicio: NOT NULL
  - Periodo_Fin: NOT NULL
  - Periodo_Inicio CHECK Periodo_Inicio <= Periodo_Fin
  - TRIGGER Periodo_Inicio y Periodo_Fin no se solapan para un mismo Trabajador

**Día** (ID_Horario, Nombre)
  - PRIMARY KEY(ID_Horario, Nombre)
  - ID_Horario: FOREIGN KEY de Horario(ID)
  
**Periódo** (ID, Inicio, Fin, ID_Horario, Nombre_Dia)
  - ID: PRIMARY KEY
  - Inicio: NOT NULL
  - Fin: NOT NULL
  - Inicio CHECK Inicio <= Fin
  - FOREIGN KEY(ID_Horario, Nombre_Dia) de Día(ID_Horario, Nombre)

**Provincia** (ID, Nombre_Provincia)
  - ID: PRIMARY KEY
  - Nombre_Provincia: NOT NULL

**Isla** (ID, Nombre_Isla, Latitud, Longitud, ID_Provinvia)
  - ID: PRIMARY KEY
  - Nombre_Isla: NOT NULL
  - Latitud: NOT NULL
  - Longitud: NOT NULL
  - ID_Provinvia: FOREIGN KEY de Provincia(ID)

**Dirección** (ID, Ciudad, CP, Dirección1, Dirección2, DNI_Trabajador, ID_Usuario, ID_Isla)
  - ID: PRIMARY KEY
  - Ciudad: NOT NULL
  - CP: NOT NULL
  - Dirección1: NOT NULL
  - DNI_Trabajador: FOREIGN KEY de Trabajador(DNI)
  - DNI_Trabajador CHECK (DNI_Trabajador ~ '\d{8}[A-Za-z]$')
  - ID_Usuario: FOREIGN KEY de Usuario(ID)
  - TRIGGER (DNI_Trabajador != NULL && ID_Usuario = NULL) || (DNI_Trabajador = NULL && ID_Usuario != NULL)
  - ID_Isla: FOREIGN KEY de Isla(ID)


**Prestacion**(ID, ID_Articulo, DNI_Trabajador, ID_Usuario_Adulto, ID_Usuario_Menor, PeriodoInicio, PeriodoFin, FechaDevolución, Vigente)
- ID: PRIMARY KEY
- ID_Articulo: FOREIGN KEY de Articulo(ID)
- DNI_Trabajador: FOREIGN KEY de Trabajador(DNI)
- ID_Usuario_Adulto: FOREIGN KEY de Usuario_Adulto(ID)
- ID_Usuario_Menor: FOREIGN KEY de Usuario_Menor(ID)
- PeriodoInicio TRIGGER PeriodoInicio = Fecha de inserción
- PeriodoFin TRIGGER PeriodoFin = Periodo Inicio + 14 dias
- Vigente TRIGGER Vigente = True IF FechaDevolución IS NOT NULL
- TRIGGER En caso de inserción: un usuario no puede tener más 5 prestaciones vigentes (o 7 si es estudiante o menor)
- TRIGGER (ID_Usuario_Adulto != NULL && ID_Usuario_Menor = NULL) || (ID_Usuario_Adulto = NULL && ID_Usuario_Menor != NULL)