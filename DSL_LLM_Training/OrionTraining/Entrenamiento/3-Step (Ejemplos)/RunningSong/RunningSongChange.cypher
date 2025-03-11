CREATE DATABASE running_songs IF NOT EXISTS ;
:USE running_songs

// RENAME ENTITY Author TO Artist

MATCH (x: Author)
REMOVE x: Author
SET x: Artist
;

// RENAME Artist::preferredAlbum TO albums

MATCH (x: Artist)
SET x.albums = x.preferredAlbum
REMOVE x.preferredAlbum
;

// DELETE *::popularity
MATCH (x)
REMOVE x.popularity
;
MATCH ()-[x]->()
REMOVE x.popularity
;




CREATE DATABASE running_songs IF NOT EXISTS ;
:USE running_songs

// CAST ATTR *::length TO Double

MATCH (x)
SET x.length = toFloat(x.length)
;
MATCH ()-[x]->()
SET x.length = toFloat(x.length)
;

// NEST Track::score, voters TO Rating
// Operation not supported.


