-- Tabla padre: VEHICLE
CREATE TABLE vehicle (
  vehicle_id INT PRIMARY KEY,
  brand      VARCHAR(50) NOT NULL,
  model      VARCHAR(50) NOT NULL,
  year       INT NOT NULL
);

-- Tabla hija: CAR (hereda de VEHICLE)
CREATE TABLE car (
  car_id       INT PRIMARY KEY,
  door_number  INT NOT NULL,
  trunk_size   INT NOT NULL,
  -- Relación 1:1 con vehicle
  CONSTRAINT fk_car_vehicle
    FOREIGN KEY (car_id)
    REFERENCES vehicle(vehicle_id)
);

-- Tabla hija: MOTORCYCLE (hereda de VEHICLE)
CREATE TABLE motorcycle (
  moto_id             INT PRIMARY KEY,
  has_sidecar         BOOLEAN NOT NULL,
  engine_displacement INT NOT NULL,
  -- Relación 1:1 con vehicle
  CONSTRAINT fk_moto_vehicle
    FOREIGN KEY (moto_id)
    REFERENCES vehicle(vehicle_id)
);