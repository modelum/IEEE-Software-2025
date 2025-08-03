CREATE KEYSPACE CentroDeportivo 
WITH replication = { 'class': 'SimpleStrategy', 'replication_factor': 3 };


USE CentroDeportivo;

CREATE TABLE Instalacion (
    instalacion_id TEXT PRIMARY KEY,  
    nombre TEXT,
    tipo TEXT,
    m2 DOUBLE
);

CREATE TABLE monitor (
    dni TEXT PRIMARY KEY,
    nombre TEXT,
    telefono BIGINT,
    fcontrato TIMESTAMP,
    salario DOUBLE,
    especialista SET<TEXT>  
);

CREATE TABLE Actividad (
    actividad_id TEXT PRIMARY KEY, 
    nombre TEXT,
    nivel INT,
    precio DOUBLE,
    responsable TEXT, 
    instalacion_id TEXT
);

CREATE TABLE Sesion (
    actividad_id TEXT,
    diasemana TEXT,
    hora DOUBLE,
    monitor_id TEXT,
    PRIMARY KEY (actividad_id, diasemana, hora) 
);
