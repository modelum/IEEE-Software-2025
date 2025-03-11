CREATE TABLE airports (
  airport_id  uuid,
  name        text,
  location    text,
  planes      set<uuid>,  -- conjunto de IDs de aviones asociados
  PRIMARY KEY (airport_id)
);

-- Tabla de aviones
CREATE TABLE planes (
  plane_id    uuid,
  model       text,
  capacity    int,
  airport_id  uuid,  -- referencia al aeropuerto
  PRIMARY KEY (plane_id)
); 
