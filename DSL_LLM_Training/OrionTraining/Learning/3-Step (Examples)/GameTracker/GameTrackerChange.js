// ENTITY OPERATIONS
// RENAME ENTITY Player TO GamePlayer 
db.Player.renameCollection("GamePlayer");

// ADD ENTITY Guild (se crea insertando datos en la colección) 
db.Guild.insertOne({ id: "G001", code: "GUILD123", name: "Warriors", num_players: 50 });

// ADAPT ENTITY GamePlayer::2 TO 1 (No hay campos en la v2 que pasar a la v1)


// FEATURE OPERATIONS 
// DELETE Achievement::is_active 
db.Achievement.updateMany({}, { $unset: { "is_active": "" } });

// RENAME Ach_Summary::completed_at TO is_completed 
db.Ach_Summary.updateMany({}, { $rename: { "completed_at": "is_completed" } });

// NEST GamePlayer::reputation, suspended TO Player_Data 
db.GamePlayer.bulkWrite([
    { updateMany: { filter: {}, update: { $rename: { "reputation": "user_data.reputation", "suspended": "user_data.suspended" } } } }
]);

// UNNEST GamePlayer::user_data.email (sacar email fuera de user_data) 
db.GamePlayer.bulkWrite([
    { updateMany: { filter: {}, update: { $rename: { "user_data.email": "email" } } } }
]);

// ATTRIBUTE OPERATIONS 
// ADD ATTR Player_Data::surname 
db.Player_Data.updateMany({}, { $set: { "surname": "" } });

// ADD ATTR Player_Data::homepage 
db.Player_Data.updateMany({}, { $set: { "homepage": "" } });

// CAST ATTR *::score, points TO Double 
db.getCollectionNames().forEach(function(collName) {
    db[collName].updateMany({}, [
        { $set: { "score": { $convert: { input: "$score", to: "double" } },
                  "points": { $convert: { input: "$points", to: "double" } } } }
    ]);
});

// CAST ATTR Ach_Summary::is_completed TO Boolean 
db.Ach_Summary.updateMany({}, [
    { $set: { "is_completed": { $convert: { input: "$is_completed", to: "bool" } } } }
]);

// PROMOTE ATTR Guild::code (Convertir `code` en clave primaria) 
db.Guild.createIndex({ "code": 1 }, { unique: true });


// AGGREGATE OPERATIONS 
// ADD AGGR Guild::realm con atributos agregados
db.Guild.updateMany({}, [
    { $set: { "realm": { "num_guilds": 0, "max_guilds": 0, "num_players": 0, "max_players": 0, "type": "" } } }
]);

// ADD AGGR Player_Data::address con country y city 
db.Player_Data.bulkWrite([
    { updateMany: { filter: {}, update: [ { $addFields: { "address": { "country": "", "city": "" } } } ], upsert: true } },
    { updateMany: { filter: {}, update: [ { $set: { "address": ["$address"] } } ] } }
]);

// MULT AGGR Player_Data::address TO + 
db.Player_Data.updateMany({}, [
    { $set: { "address": { $arrayElemAt: ["$address", 0] } } }
]);

// MORPH AGGR GamePlayer::user_data TO user_private_data 
db.GamePlayer.updateMany({}, { $rename: { "user_data": "user_private_data" } });

