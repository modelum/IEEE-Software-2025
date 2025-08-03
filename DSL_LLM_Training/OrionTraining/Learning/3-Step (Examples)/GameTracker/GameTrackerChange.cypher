CREATE DATABASE GameTracker IF NOT EXISTS ;
:USE GameTracker

// ADD ENTITY Guild: { +id: String, code: String, name: String, num_players: Number }

CREATE (x: Guild);
MATCH (x: Guild)
SET x.id = "", x.code = "", x.name = "", x.num_players = 0
;

// RENAME ENTITY Player TO GamePlayer

MATCH (x: Player)
REMOVE x: Player
SET x: GamePlayer
;

// ADAPT ENTITY GamePlayer::2 TO 1

MATCH (x: GamePlayer)
WHERE
      x.experience IS NULL AND x.hours_played IS NULL AND x.ach_earned IS NULL AND x.score IS NULL
SET x.experience = 0.0, x.hours_played = 0.0, x., x.score = 0
;

// DELETE Achievement::is_active

MATCH (x: Achievement)
REMOVE x.is_active
;

// RENAME Ach_Summary::completed_at TO is_completed

MATCH (x: Ach_Summary)
SET x.is_completed = x.completed_at
REMOVE x.completed_at
;

// NEST GamePlayer::reputation, suspended TO Player_Data

// Operation not supported.

// UNNEST GamePlayer::user_data.email

// Operation not supported.

// ADD ATTR Player_Data::surname: String
MATCH (x: Player_Data)
SET x.surname = ""
;

// ADD ATTR Player_Data::homepage: String

MATCH (x: Player_Data)
SET x.homepage = ""
;

// CAST ATTR *::score, points TO Double
MATCH (x)
SET x.score = toFloat(x.score), x.points = toFloat(x.points)
;
MATCH ()-[x]->()
SET x.score = toFloat(x.score), x.points = toFloat(x.points)
;

// CAST ATTR Ach_Summary::is_completed TO Boolean

MATCH (x: Ach_Summary)
SET x.is_completed = toBoolean(x.is_completed)
;

// PROMOTE ATTR Guild::code

CREATE CONSTRAINT Guild_code_IS_UNIQUE IF NOT EXISTS
ON (x: Guild)
ASSERT x.code IS UNIQUE
;

// ADD AGGR Guild::realm: { num_guilds: Number, max_guilds: Number, num_players: Number, max_players: Number, type: String
}& AS Realm
// Operation not supported.

// ADD AGGR Player_Data::address: { country: String, city: String }& AS Address

// Operation not supported.

// MULT AGGR Player_Data::address TO +

// Operation not supported.

// MORPH AGGR GamePlayer::user_data TO user_private_data
// Operation not supported.
