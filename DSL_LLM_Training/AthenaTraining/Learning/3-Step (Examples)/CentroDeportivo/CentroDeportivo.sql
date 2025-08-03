CREATE TABLE instalacion (
  instalacion_id CHAR(3)     NOT NULL,
  nombre         VARCHAR(30) NOT NULL,
  tipo           CHAR(8)     DEFAULT 'Interior' NOT NULL,
  m2             NUMBER(7,2) NOT NULL,
  CONSTRAINT instalacion_pk PRIMARY KEY(instalacion_id),
  CONSTRAINT tipo_check CHECK (tipo IN ('Interior', 'Exterior')),
  CONSTRAINT m2_check   CHECK (m2>0)
);

CREATE TABLE monitor (
  dni       CHAR(9)     NOT NULL,
  nombre    VARCHAR(30) NOT NULL,
  telefono  NUMBER(9)   NOT NULL,
  fcontrato DATE        NOT NULL,  
  salario   NUMBER(6,2) NOT NULL,
  CONSTRAINT monitor_pk PRIMARY KEY(dni),
  CONSTRAINT monitor_ak UNIQUE(telefono),
  CONSTRAINT salario_check CHECK (salario>0)
);

CREATE TABLE actividad (
  actividad_id   CHAR(3)     NOT NULL,
  nombre         VARCHAR(30) NOT NULL,
  nivel          CHAR(8)     DEFAULT 3 NOT NULL,
  precio         NUMBER(4,2) NULL,
  responsable    CHAR(9)     NOT NULL,
  instalacion_id CHAR(3)     NOT NULL,
  CONSTRAINT actividad_pk PRIMARY KEY(actividad_id),
  CONSTRAINT actividad_fk_monitor
    FOREIGN KEY(responsable)
    REFERENCES monitor(dni),
  CONSTRAINT actividad_fk_instalacion 
    FOREIGN KEY(instalacion_id)
    REFERENCES instalacion(instalacion_id),
  CONSTRAINT nivel_check  CHECK (nivel BETWEEN 1 AND 5),
  CONSTRAINT precio_check CHECK (precio IS NULL OR precio>=0)
);

CREATE TABLE especialista (
  monitor_id   CHAR(9)     NOT NULL,
  actividad_id CHAR(3)     NOT NULL,
  CONSTRAINT especialista_pk PRIMARY KEY(monitor_id, actividad_id),
  CONSTRAINT especialista_fk_monitor 
    FOREIGN KEY(monitor_id)
    REFERENCES monitor(dni),
  CONSTRAINT especialista_fk_actividad 
    FOREIGN KEY(actividad_id)
    REFERENCES actividad(actividad_id)
);

CREATE TABLE sesion (
  actividad_id CHAR(3)     NOT NULL,
  diasemana    CHAR(1)     NOT NULL,
  hora         NUMBER(4,2) NOT NULL,
  monitor_id   CHAR(9)     NOT NULL,
  CONSTRAINT sesion_pk PRIMARY KEY(actividad_id, diasemana, hora),
  CONSTRAINT sesion_fk_actividad 
    FOREIGN KEY(actividad_id)
    REFERENCES actividad(actividad_id),
  CONSTRAINT sesion_fk_monitor FOREIGN KEY(monitor_id)
    REFERENCES monitor(dni),
  CONSTRAINT diasemana_check  
    CHECK (diasemana IN ('L', 'M', 'X', 'J', 'V', 'S'))
);

COMMIT;