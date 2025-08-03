
-- Schema Type operations
-- ADD ENTITY Guild: { +id: Identifier, code: String, name: String, num_players: Number }
CREATE TABLE Guild (
    id UUID PRIMARY KEY,
    code VARCHAR(255) UNIQUE,
    name VARCHAR(255),
    num_players INT
);
-- RENAME ENTITY Player TO GamePlayer
ALTER TABLE Player RENAME TO GamePlayer;

-- ADAPT ENTITY GamePlayer::2 TO 1
--- Operation not supported.

-- Feature operations
-- DELETE Achievement::is_active
ALTER TABLE Achievement DROP COLUMN is_active;

-- RENAME Ach_Summary::completed_at TO is_completed
ALTER TABLE Ach_Summary RENAME COLUMN completed_at TO is_completed;

-- NEST GamePlayer::reputation, suspended TO Player_Data
-- Operation not supported.

-- UNNEST GamePlayer::user_data.email
-- Operation not supported.


-- Attribute operations
-- ADD ATTR Player_Data::surname: String
ALTER TABLE Player_Data ADD COLUMN surname VARCHAR(255);

--ADD ATTR Player_Data::homepage: String
ALTER TABLE Player_Data ADD COLUMN homepage VARCHAR(255);

-- CAST ATTR *::score, points TO Double
ALTER TABLE GamePlayer ALTER COLUMN score TYPE DOUBLE PRECISION;
ALTER TABLE GamePlayer ALTER COLUMN points TYPE DOUBLE PRECISION;
ALTER TABLE Ach_Summary ALTER COLUMN points TYPE DOUBLE PRECISION;
ALTER TABLE Achievement ALTER COLUMN points TYPE DOUBLE PRECISION;

-- CAST ATTR Ach_Summary::is_completed TO Boolean
ALTER TABLE Ach_Summary ALTER COLUMN is_completed TYPE BOOLEAN USING (is_completed::BOOLEAN);

-- PROMOTE ATTR Guild::code
ALTER TABLE Guild DROP CONSTRAINT Guild_pkey;
ALTER TABLE Guild ADD PRIMARY KEY (id, code);


-- Aggregate operations
--ADD AGGR Guild::realm: {num_guilds: Number, max_guilds: Number, num_players: Number, max_players: Number, type: String}& AS Realm
CREATE TABLE Realm (
    guild_id UUID PRIMARY KEY REFERENCES Guild(id),
    num_guilds INT,
    max_guilds INT,
    num_players INT,
    max_players INT,
    type VARCHAR(255)
);
ALTER TABLE Guild ADD COLUMN realm UUID REFERENCES Realm(guild_id);

-- ADD AGGR Player_Data::address: { country: String, city: String }& AS Address
CREATE TABLE Address (
    id UUID PRIMARY KEY,
    country VARCHAR(255),
    city VARCHAR(255)
);
ALTER TABLE Player_Data ADD COLUMN address UUID REFERENCES Address(id);

-- MULT AGGR Player_Data::address TO +
-- Operation not supported.

-- MORPH AGGR GamePlayer::user_data TO user_private_data
-- Operation not supported.