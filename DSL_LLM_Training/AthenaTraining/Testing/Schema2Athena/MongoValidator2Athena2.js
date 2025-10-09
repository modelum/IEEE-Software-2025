db.createCollection("movie", {
  validator: { $jsonSchema: {
    bsonType: "object",
    required: ["id","title"],
    properties: {
      id: { bsonType: "int" },
      title: { bsonType: "string" },
      production_year: { bsonType: ["int","null"] }
    }
  }}
});

db.createCollection("person", {
  validator: { $jsonSchema: {
    bsonType: "object",
    required: ["id","name"],
    properties: {
      id: { bsonType: "int" },
      name: { bsonType: "string" },
      gender: { bsonType: ["string","null"] },
      birth_country: { bsonType: ["string","null"] },
      birth_year: { bsonType: ["int","null"] },
      death_year: { bsonType: ["int","null"] },
      age_group: { bsonType: ["string","null"] },
      death_cause: { bsonType: ["string","null"] },
      height_group: { bsonType: ["string","null"] }
    }
  }}
});

db.createCollection("role", {
  validator: { $jsonSchema: {
    bsonType: "object",
    required: ["id","role"],
    properties: { id: { bsonType: "int" }, role: { bsonType: "string" } }
  }}
});

db.createCollection("castinfo", {
  validator: { $jsonSchema: {
    bsonType: "object",
    required: ["movie_id","person_id","role_id"],
    properties: {
      movie_id: { bsonType: "int" },
      person_id:{ bsonType: "int" },
      role_id:  { bsonType: "int" }
    }
  }}
});

db.createCollection("genre", {
  validator: { $jsonSchema: {
    bsonType: "object",
    required: ["id","name"],
    properties: { id: { bsonType: "int" }, name: { bsonType: "string" } }
  }}
});

db.createCollection("movietogenre", {
  validator: { $jsonSchema: {
    bsonType: "object",
    required: ["movie_id","genre_id"],
    properties: { movie_id: { bsonType: "int" }, genre_id: { bsonType: "int" } }
  }}
});

db.createCollection("language", {
  validator: { $jsonSchema: {
    bsonType: "object",
    required: ["id","name"],
    properties: { id: { bsonType: "int" }, name: { bsonType: "string" } }
  }}
});

db.createCollection("movietolanguage", {
  validator: { $jsonSchema: {
    bsonType: "object",
    required: ["movie_id","language_id"],
    properties: { movie_id: { bsonType: "int" }, language_id: { bsonType: "int" } }
  }}
});

db.createCollection("country", {
  validator: { $jsonSchema: {
    bsonType: "object",
    required: ["id","name"],
    properties: { id: { bsonType: "int" }, name: { bsonType: "string" } }
  }}
});

db.createCollection("movietocountry", {
  validator: { $jsonSchema: {
    bsonType: "object",
    required: ["movie_id","country_id"],
    properties: { movie_id: { bsonType: "int" }, country_id: { bsonType: "int" } }
  }}
});

db.createCollection("company", {
  validator: { $jsonSchema: {
    bsonType: "object",
    required: ["id","name"],
    properties: { id: { bsonType: "int" }, name: { bsonType: "string" } }
  }}
});

db.createCollection("production", {
  validator: { $jsonSchema: {
    bsonType: "object",
    required: ["movie_id","company_id"],
    properties: { movie_id: { bsonType: "int" }, company_id: { bsonType: "int" } }
  }}
});

db.createCollection("distribution", {
  validator: { $jsonSchema: {
    bsonType: "object",
    required: ["movie_id","company_id"],
    properties: { movie_id: { bsonType: "int" }, company_id: { bsonType: "int" } }
  }}
});

db.createCollection("certificate", {
  validator: { $jsonSchema: {
    bsonType: "object",
    required: ["id","name"],
    properties: { id: { bsonType: "int" }, name: { bsonType: "string" } }
  }}
});

db.createCollection("movietocertificate", {
  validator: { $jsonSchema: {
    bsonType: "object",
    required: ["movie_id","certificate_id"],
    properties: { movie_id: { bsonType: "int" }, certificate_id: { bsonType: "int" } }
  }}
});
