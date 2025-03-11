-- EBlock: 1
BEGIN TRANSACTION;

-- Renombrar entidad Author a Artist
ALTER TABLE Author RENAME TO Artist;

-- Renombrar atributo preferredAlbum a albums
ALTER TABLE Artist RENAME COLUMN preferredAlbum TO albums;

-- Eliminar la columna popularity en todas las tablas
ALTER TABLE Artist DROP COLUMN IF EXISTS popularity;


COMMIT;


-- EBlock: 2
BEGIN TRANSACTION;

-- Convertir Track::length a Double
ALTER TABLE Track ALTER COLUMN length TYPE DOUBLE PRECISION;

-- Not operations supported

COMMIT;


