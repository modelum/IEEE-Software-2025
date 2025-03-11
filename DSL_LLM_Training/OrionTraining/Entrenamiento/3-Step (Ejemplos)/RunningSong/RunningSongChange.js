// EvolBlock 1
// RENAME ENTITY Author TO Artist
db.Author.renameCollection("Artist");

// RENAME Artist::preferredAlbum TO albums
db.Artist.updateMany({}, { $rename: { "preferredAlbum": "albums" } });

// DELETE *::popularity (Eliminar `popularity` en todas las colecciones)
db.getCollectionNames().forEach(function(collName) {
    db[collName].updateMany({}, { $unset: { "popularity": "" } });
});

// EvolBlock 2
// CAST ATTR *::length TO Double
db.getCollectionNames().forEach(function(collName) {
    db[collName].updateMany({}, [
        { $set: { "length": { $convert: { input: "$length", to: "double" } } } }
    ]);
});

// NEST Track::score, voters TO Rating 
db.Track.updateMany({}, [
    { $set: { "rating": { "score": "$score", "voters": "$voters" } } },
]);



