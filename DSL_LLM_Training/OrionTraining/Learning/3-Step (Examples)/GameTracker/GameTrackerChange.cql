CREATE KEYSPACE IF NOT EXISTS gametracker WITH REPLICATION = { 'class': 'SimpleStrategy', 'replication_factor' : 3 } ;
USE gametracker ;

-- ADD ENTITY Guild: { +id: Identifier, code: String, name: String, num_players: Number }

CREATE TABLE IF NOT EXISTS guild
(
  id uuid,
  code text,
  name text,
  num_players varint,
  PRIMARY KEY (id)
);

-- RENAME ENTITY Player TO GamePlayer
-- There are operations that are not directly allowed but you can use a copy technique

COPY player TO 'tmp.csv' WITH HEADER = TRUE;
DROP TABLE player;
CREATE TABLE gameplayer
(
  id uuid,
  ach_earned list<frozen<ach_summary>>,
  avatar_url text,
  experience double,
  hours_played double,
  last_activity timestamp,
  nickname text,
  reputation double,
  score int,
  status int,
  suspended boolean,
  user_data player_data,
  PRIMARY KEY (id)
);
COPY gameplayer FROM 'tmp.csv' WITH HEADER = TRUE;

-- ADAPT ENTITY GamePlayer::2 TO 1

--- Operation not supported.

-- DELETE Achievement::is_active

ALTER TABLE achievement DROP ( is_active );

-- RENAME Ach_Summary::completed_at TO is_completed

COPY ach_summary ( , completed_at ) TO 'tmp.csv' WITH HEADER = TRUE;
ALTER TABLE ach_summary DROP ( completed_at );
ALTER TABLE ach_summary ADD is_completed timestamp;
COPY ach_summary ( , is_completed ) FROM 'tmp.csv' WITH HEADER = TRUE;

-- NEST GamePlayer::reputation, suspended TO Player_Data

--- Operation not supported.

-- UNNEST GamePlayer::user_data.email

--- Operation not supported.

-- ADD ATTR Player_Data::surname: String
ALTER TABLE player_data ADD surname text;

-- ADD ATTR Player_Data::homepage: String

ALTER TABLE player_data ADD homepage text;

-- CAST ATTR *::score, points TO Double
COPY gameplayer TO 'tmp.csv' WITH HEADER = TRUE;
DROP TABLE gameplayer;
CREATE TABLE gameplayer
(
  id uuid,
  ach_earned list<frozen<ach_summary>>,
  avatar_url text,
  email text,
  experience double,
  hours_played double,
  last_activity timestamp,
  nickname text,
  player_data player_data,
  status int,
  user_data player_data,
  score double,
  points double,
  PRIMARY KEY (id)
);
COPY gameplayer FROM 'tmp.csv' WITH HEADER = TRUE;
COPY ach_summary TO 'tmp.csv' WITH HEADER = TRUE;
DROP TABLE ach_summary;
CREATE TABLE ach_summary
(
  achievement uuid,
  is_completed timestamp,
  of_the_day boolean,
  score double,
  points double,
  PRIMARY KEY ()
);
COPY ach_summary FROM 'tmp.csv' WITH HEADER = TRUE;
COPY achievement TO 'tmp.csv' WITH HEADER = TRUE;
DROP TABLE achievement;
CREATE TABLE achievement
(
  id uuid,
  categories list<text>,
  description text,
  score double,
  points double,
  PRIMARY KEY (id)
);
COPY achievement FROM 'tmp.csv' WITH HEADER = TRUE;

-- CAST ATTR Ach_Summary::is_completed TO Boolean

COPY ach_summary TO 'tmp.csv' WITH HEADER = TRUE;
DROP TABLE ach_summary;
CREATE TABLE ach_summary
(
  achievement uuid,
  of_the_day boolean,
  points double,
  is_completed boolean,
  PRIMARY KEY ()
);
COPY ach_summary FROM 'tmp.csv' WITH HEADER = TRUE;

-- PROMOTE ATTR Guild::code

COPY guild
(
  id,code,
  name,num_players
) TO 'tmp.csv' WITH HEADER = TRUE;
DROP TABLE guild;
CREATE TABLE guild
(
  id uuid,
  code text,
  name text,
  num_players varint,
  PRIMARY KEY (id, code)
);
COPY guild FROM 'tmp.csv' WITH HEADER = TRUE;

-- ADD AGGR Guild::realm: { num_guilds: Number, max_guilds: Number, num_players: Number, max_players: Number, type: String
--}& AS Realm
CREATE TYPE IF NOT EXISTS realm
(
  max_guilds varint, 
  max_players varint, 
  num_guilds varint, 
  num_players varint, 
  type text
);
ALTER TABLE guild ADD realm realm;

-- ADD AGGR Player_Data::address: { country: String, city: String }& AS Address

CREATE TYPE IF NOT EXISTS address
(
  city text, 
  country text
);
ALTER TABLE player_data ADD address address;

-- MULT AGGR Player_Data::address TO +

--- Operation not supported.

-- MORPH AGGR GamePlayer::user_data TO user_private_data
--- Operation not supported.
