use Umugram;

// Validador de User
db.createCollection("User", {
  validator: {
    $jsonSchema: {
      bsonType: "object",
      required: ["id", "username", "email", "password", "birthday", "profile", "followers", "following", "userComments", "userPosts", "create_at", "update_at"],
      properties: {
        id: { bsonType: "string", description: "ID del usuario, requerido y debe ser string." },
        username: { bsonType: "string", description: "Nombre de usuario, requerido y debe ser string." },
        email: { bsonType: "string", pattern: "^.+@.+\\.com$", description: "Debe ser un email válido." },
        password: { bsonType: "string", description: "Contraseña, requerida y debe ser string." },
        birthday: { bsonType: "date", description: "Fecha de nacimiento del usuario." },
        profile: {
          bsonType: "object",
          required: ["nameProfile"],
          properties: {
            nameProfile: { bsonType: "string", description: "Nombre del perfil, requerido y debe ser string." },
            avatar_url: { bsonType: "string", description: "URL del avatar, opcional." },
            decription: { bsonType: "string", description: "Descripción del usuario, opcional." },
            website: { bsonType: "string", description: "Sitio web del usuario, opcional." }
          }
        },
        followers: { bsonType: "array", items: { bsonType: "string" }, description: "Lista de seguidores." },
        following: { bsonType: "array", items: { bsonType: "string" }, description: "Lista de usuarios seguidos." },
        userComments: { bsonType: "array", items: { bsonType: "string" }, description: "Lista de comentarios hechos por el usuario." },
        userPosts: { bsonType: "array", items: { bsonType: "string" }, description: "Lista de publicaciones del usuario." },
        create_at: { bsonType: "date", description: "Fecha de creación del usuario." },
        update_at: { bsonType: "date", description: "Fecha de actualización del usuario." }
      }
    }
  }
});

db.User.createIndex({ id: 1 }, { unique: true });
db.User.createIndex({ email: 1 }, { unique: true });
db.User.createIndex({ username: 1 }, { unique: true });

// Validador de Comment
db.createCollection("Comment", {
  validator: {
    $jsonSchema: {
      bsonType: "object",
      required: ["id", "text", "post", "replyTo", "user", "create_at", "update_at"],
      properties: {
        id: { bsonType: "string", description: "ID del comentario, requerido y debe ser string." },
        text: { bsonType: "string", description: "Texto del comentario, requerido y debe ser string." },
        post: { bsonType: "string", description: "Referencia al post al que pertenece el comentario." },
        replyTo: { bsonType: "string", description: "Referencia al comentario al que responde." },
        user: { bsonType: "string", description: "Referencia al usuario que hizo el comentario." },
        create_at: { bsonType: "date", description: "Fecha de creación del comentario." },
        update_at: { bsonType: "date", description: "Fecha de actualización del comentario." }
      }
    }
  }
});

db.Comment.createIndex({ id: 1 }, { unique: true });

// Validador de Post
db.createCollection("Post", {
  validator: {
    $jsonSchema: {
      bsonType: "object",
      required: ["id", "user", "create_at", "update_at"],
      properties: {
        id: { bsonType: "string", description: "ID del post, requerido y debe ser string." },
        caption: { bsonType: "string", description: "Título o descripción corta del post, opcional." },
        user: { bsonType: "string", description: "Referencia al usuario que publicó el post." },
        description: { bsonType: "string", description: "Descripción del post, opcional." },
        create_at: { bsonType: "date", description: "Fecha de creación del post." },
        update_at: { bsonType: "date", description: "Fecha de actualización del post." },
        
        // Variación 1: Post con imagen
        photoUrl: { bsonType: "string", description: "URL de la imagen, si es un PhotoPost." },

        // Variación 2: Post con video
        videoUrl: { bsonType: "string", description: "URL del video, si es un VideoPost." },
        duration: { bsonType: "double", minimum: 0, description: "Duración del video en segundos." },
        lastMinute: { bsonType: "double", minimum: 0, description: "Último minuto visto del video." }
      },
      oneOf: [
        {
          required: ["photoUrl"], // Post de tipo imagen
          description: "Debe ser un PhotoPost si tiene photoUrl."
        },
        {
          required: ["videoUrl", "duration", "lastMinute"], // Post de tipo video
          description: "Debe ser un VideoPost si tiene videoUrl, duration y lastMinute."
        }
      ]
    }
  }
});

db.Post.createIndex({ id: 1 }, { unique: true });



