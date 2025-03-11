USE running_songs ;

// RENAME ENTITY Author TO Artist

COPY author TO 'tmp.csv' WITH HEADER = TRUE;
DROP TABLE author;
CREATE TABLE artist
(
  _id text,
  name text,
  popularity varint,
  preferredalbum list<text>,
  startingyear varint,
  PRIMARY KEY (_id)
);
COPY artist FROM 'tmp.csv' WITH HEADER = TRUE;

// RENAME Artist::preferredAlbum TO albums

COPY artist ( _id, preferredalbum ) TO 'tmp.csv' WITH HEADER = TRUE;
ALTER TABLE artist DROP ( preferredalbum );
ALTER TABLE artist ADD albums list<text>;
COPY artist ( _id, albums ) FROM 'tmp.csv' WITH HEADER = TRUE;

// DELETE *::popularity
ALTER TABLE artist DROP ( popularity );
ALTER TABLE album DROP ( popularity );



USE running_songs ;

-- CAST ATTR *::length TO Double

COPY album TO 'tmp.csv' WITH HEADER = TRUE;
DROP TABLE album;
CREATE TABLE album
(
  _id text,
  details list<frozen<details>>,
  name text,
  reviews list<text>,
  tracks list<text>,
  length double,
  PRIMARY KEY (_id)
);
COPY album FROM 'tmp.csv' WITH HEADER = TRUE;
COPY track TO 'tmp.csv' WITH HEADER = TRUE;
DROP TABLE track;
CREATE TABLE track
(
  _id text,
  genres list<text>,
  name text,
  score varint,
  voters varint,
  length double,
  PRIMARY KEY (_id)
);
COPY track FROM 'tmp.csv' WITH HEADER = TRUE;

-- NEST Track::score, voters TO Rating
--- Operation not supported.
