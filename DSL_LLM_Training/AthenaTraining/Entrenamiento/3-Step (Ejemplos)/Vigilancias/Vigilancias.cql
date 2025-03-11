CREATE KEYSPACE Vigilancias
WITH replication = {'class': 'SimpleStrategy', 'replication_factor': 3};

use Vigilancias;

CREATE TABLE Departamento (
    siglas TEXT PRIMARY KEY,
    nombre TEXT,
    cuantos_profesores INT
);

CREATE TABLE Profesor (
    DNI TEXT PRIMARY KEY,
    nombre TEXT,
    email TEXT,
    categoria TEXT,
    departamento TEXT,
    asignatura TEXT,
    creditos INT,
    TelefonoProfesores SET<TEXT>
);

CREATE TABLE Asignatura (
    codigo TEXT PRIMARY KEY,
    nombre TEXT,
    cuatrimestre INT,
    departamento TEXT,
    coordinador TEXT,
    prerrequisito TEXT
);

CREATE TABLE Examen (
    asignatura TEXT,
    curso TEXT,
    convocatoria TEXT,
    fecha_hora TIMESTAMP,
    duracion INT,
    vigilante TEXT,
    aula LIST<TEXT>,
    PRIMARY KEY ((asignatura, curso, convocatoria), fecha_hora)
);

CREATE TABLE Aula (
    codigo TEXT PRIMARY KEY,
    capacidad INT,
    puestos_examen INT,
    nombre TEXT,
    centro TEXT
);