db.createCollection("User", {
  validator: {
    $jsonSchema: {
      bsonType: "object",
      required: ["name", "email", "posts"],
      properties: {
        name: {
          bsonType: "string",
          description: "El nombre del usuario es obligatorio y debe ser un string."
        },
        email: {
          bsonType: "string",
          pattern: "^.+@.+\\..+$",
          description: "Debe ser un correo electrónico válido y único."
        },
        posts: {
          bsonType: "array",
          items: {
            bsonType: "object",
            required: ["title", "content", "createdAt", "type"],
            properties: {
              title: {
                bsonType: "string",
                description: "Título del post."
              },
              content: {
                bsonType: "string",
                description: "Contenido del post."
              },
              createdAt: {
                bsonType: "date",
                description: "Fecha de creación del post."
              },
              type: {
                bsonType: "string",
                enum: ["text", "media"],
                description: "Tipo de post, puede ser 'text' o 'media'."
              },
              wordCount: {
                bsonType: "int",
                description: "Número de palabras (solo para posts de tipo 'text').",
                minimum: 1
              },
              mediaUrl: {
                bsonType: "string",
                description: "URL del archivo multimedia (solo para posts de tipo 'media')."
              },
              format: {
                bsonType: "string",
                enum: ["jpg", "png", "gif", "mp4", "mp3"],
                description: "Formato del archivo multimedia (solo para posts de tipo 'media')."
              }
            },
            oneOf: [
              {
                required: ["wordCount"],
                description: "Si el tipo es 'text', debe incluir wordCount."
              },
              {
                required: ["mediaUrl", "format"],
                description: "Si el tipo es 'media', debe incluir mediaUrl y format."
              }
            ]
          },
          description: "Lista de posts asociados al usuario."
        }
      }
    }
  }
});
