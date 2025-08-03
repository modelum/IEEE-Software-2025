use SoftwareDev;

db.createCollection("Developer", {
  validator: {
    $jsonSchema: {
      bsonType: "object",
      required: ["id", "email", "permissions", "dev_info"],
      properties: {
        id: { bsonType: "string", description: "ID del Developer, debe ser string y es requerido." },
        dev_info: {
          bsonType: "object",
          required: ["name", "team"],
          properties: {
            about_me: { bsonType: "string", description: "Información opcional sobre el developer." },
            name: { bsonType: "string", pattern: "^[A-Z][a-z]*$", description: "Debe empezar con mayúscula." },
            team: { bsonType: "string", description: "Nombre del equipo al que pertenece el developer." }
          }
        },
        email: { bsonType: "string", pattern: "^.+@.+\\.com$", description: "Debe ser un email válido." },
        permissions: { enum: ["R", "W", "X", "RW", "RX", "WX", "RWX"], description: "Permisos válidos del developer." },
        is_active: { bsonType: "bool", description: "Indica si el usuario está activo." },
        suspended_acc: { anyOf: [{ bsonType: "string" }, { bsonType: "bool" }], description: "Puede ser un String o Boolean." }
      }
    }
  }
});

db.createCollection("Repository", {
  validator: {
    $jsonSchema: {
      bsonType: "object",
      required: ["id", "title", "url", "developers", "requests", "created_time", "last_activity_date", "num_forks", "num_stars"],
      properties: {
        id: { bsonType: "string", description: "ID del repositorio, debe ser string y es requerido." },
        title: { bsonType: "string", description: "Título del repositorio, requerido." },
        url: { bsonType: "string", description: "URL del repositorio, requerido." },
        developers: {
          bsonType: "array",
          items: { bsonType: "string" },
          description: "Lista de IDs de developers asignados al repositorio."
        },
        requests: {
          bsonType: "array",
          items: {
            bsonType: "object",
            required: ["branch", "status", "numLabels"],
            properties: {
              branch: { bsonType: "string", description: "Nombre de la rama." },
              status: { enum: ["Open", "Closed"], description: "Estado de la solicitud (Open/Closed)." },
              numLabels: { bsonType: "int", description: "Número de etiquetas asociadas a la solicitud." }
            }
          }
        },
        tags: {
          bsonType: "array",
          items: { bsonType: "string" },
          description: "Lista de etiquetas opcionales para el repositorio."
        },
        created_time: { bsonType: "date", description: "Fecha de creación del repositorio." },
        last_activity_date: { bsonType: "date", description: "Última actividad en el repositorio." },
        num_forks: { bsonType: "int", minimum: 0, maximum: 1000, description: "Cantidad de forks, entre 0 y 1000." },
        num_stars: { bsonType: "int", minimum: 0, maximum: 1000, description: "Cantidad de estrellas, entre 0 y 1000." }
      }
    }
  }
});

db.createCollection("Ticket", {
  validator: {
    $jsonSchema: {
      bsonType: "object",
      required: ["id", "message", "repository_id", "developer_id", "created_time", "last_activity_date", "num_forks", "num_stars"],
      properties: {
        id: { bsonType: "string", description: "ID del ticket, debe ser string y es requerido." },
        message: { bsonType: "string", description: "Mensaje del ticket, requerido." },
        repository_id: { bsonType: "string", description: "ID del repositorio asociado." },
        developer_id: { bsonType: "string", description: "ID del developer asignado." },
        created_time: { bsonType: "date", description: "Fecha de creación del ticket." },
        last_activity_date: { bsonType: "date", description: "Última actividad en el ticket." },
        num_forks: { bsonType: "int", minimum: 0, maximum: 1000, description: "Cantidad de forks asociados al ticket." },
        num_stars: { bsonType: "int", minimum: 0, maximum: 1000, description: "Cantidad de estrellas asociadas al ticket." }
      }
    }
  }
});
