CREATE TABLE DEPARTAMENTO(
  siglas	CHAR(5)	NOT NULL,
  nombre	VARCHAR(50)	NOT NULL,
  cuantos_profesores NUMBER(2) DEFAULT 0 NOT NULL,
	CONSTRAINT departamento_pk PRIMARY KEY(siglas),
	CONSTRAINT departamento_ak UNIQUE(nombre)
 );

CREATE TABLE PROFESOR(
  DNI          CHAR(9)	    NOT NULL,
  nombre       VARCHAR(40)	NOT NULL,
  email        VARCHAR(15)	NULL, 
  categoria    CHAR(3)	    NOT NULL,
  departamento CHAR(5)	    NOT NULL, 
  asignatura	 CHAR(4)        NULL, 
  creditos     NUMBER(2)      NULL,
  CONSTRAINT profesor_pk PRIMARY KEY(DNI),
  CONSTRAINT profesor_ak UNIQUE(email),
  CONSTRAINT profesor_fk_departamento
    FOREIGN KEY(departamento) 
		REFERENCES DEPARTAMENTO(siglas),
  CONSTRAINT profesor_check1 
      CHECK (categoria IN ('CU','TU','CEU','TEU','AYD','ASO','CD')),
  CONSTRAINT profesor_check2 CHECK (creditos > 0) 
 );

CREATE TABLE ASIGNATURA (
  codigo        CHAR(4)	  NOT NULL,
  nombre        VARCHAR(50) NOT NULL, 
  cuatrimestre  NUMBER(1)   NOT NULL,
  departamento  CHAR(5)     NOT NULL, 
  coordinador   CHAR(9)     NOT NULL,
  prerrequisito CHAR(4)     NULL, 
  CONSTRAINT asignatura_pk PRIMARY KEY(codigo),
  CONSTRAINT asignatura_ak UNIQUE(coordinador), 
  CONSTRAINT asignatura_fk_departamento
    FOREIGN KEY(departamento)
		REFERENCES DEPARTAMENTO(siglas),
  CONSTRAINT asignatura_fk_profesor
    FOREIGN KEY(coordinador)
		REFERENCES PROFESOR(DNI),
  CONSTRAINT asignatura_fk_prerrequisito
    FOREIGN KEY(prerrequisito)
		REFERENCES ASIGNATURA(codigo),
  CONSTRAINT asignatura_check1 CHECK (cuatrimestre IN (0, 1, 2)), 
  CONSTRAINT asignatura_check2 CHECK (codigo <> prerrequisito) 
 );
 
 ALTER TABLE PROFESOR 
  ADD CONSTRAINT profesor_fk_asignatura
      FOREIGN KEY(asignatura) 
		  REFERENCES ASIGNATURA(codigo);

CREATE TABLE EXAMEN(
  asignatura     CHAR(4)	   NOT NULL, 
  curso          CHAR(9)	   NOT NULL,
  convocatoria   VARCHAR(10)   NOT NULL,
  fecha_hora     DATE	       NOT NULL, 
  duracion       NUMBER(3) DEFAULT 1 NOT NULL,
  CONSTRAINT examen_pk PRIMARY KEY (asignatura,curso,convocatoria),
  CONSTRAINT examen_fk_asignatura
    FOREIGN KEY(asignatura)
		REFERENCES ASIGNATURA(codigo),
  CONSTRAINT examen_check1 
    CHECK (convocatoria IN ('Junio', 'Julio', 'Enero')),
CONSTRAINT examen_check2 
    CHECK (duracion > 0)   
 );

CREATE TABLE VIGILANCIA( 
  profesor     CHAR(9) NOT NULL,
  asignatura   CHAR(4) NOT NULL,
  curso        CHAR(9) NOT NULL,
  convocatoria VARCHAR(10),
  CONSTRAINT vigilancia_pk 
    PRIMARY KEY(profesor, asignatura, curso, convocatoria),
  CONSTRAINT vigilancia_profesor
    FOREIGN KEY (profesor) 
    REFERENCES PROFESOR(DNI),
  CONSTRAINT vigilancia_examen
    FOREIGN KEY (asignatura, curso, convocatoria)
    REFERENCES EXAMEN(asignatura, curso, convocatoria) 
 );
      
CREATE TABLE AULA(
  codigo         CHAR(4)      NOT NULL,
  capacidad      NUMBER(3)    NOT NULL,
  puestos_examen NUMBER(3)    NOT NULL,
  nombre         VARCHAR(30)  NULL,
  centro         VARCHAR(25)  NOT NULL, 
  CONSTRAINT aula_pk PRIMARY KEY (codigo),
  CONSTRAINT aula_check1 CHECK (capacidad > 0), 
  CONSTRAINT aula_check2 CHECK (puestos_examen > 0)
);

CREATE TABLE AULA_EXAMEN( 
  aula	       CHAR(4) NOT NULL,
  asignatura	 CHAR(4) NOT NULL,
  curso	       CHAR(9) NOT NULL,
  convocatoria VARCHAR(10),
  CONSTRAINT aula_examen_pk
   PRIMARY KEY(aula,asignatura,curso,convocatoria),
  CONSTRAINT aula_examen_fk_aula
    FOREIGN KEY (aula) 
    REFERENCES AULA(codigo),
  CONSTRAINT aula_examen_fk_examen
 	FOREIGN KEY (asignatura, curso, convocatoria)
 	REFERENCES EXAMEN(asignatura, curso, convocatoria) 
 );

CREATE TABLE TELEFONO_PROFESOR (
  profesor CHAR(9)   NOT NULL,
  telefono NUMBER(9) NOT NULL,
  PRIMARY KEY(profesor, telefono),
  CONSTRAINT telefono_profesor_fk_profesor
    FOREIGN KEY (profesor) 
	  REFERENCES PROFESOR(DNI)
);