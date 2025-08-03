use SoftwareProject;

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

db.Developer.createIndex({ id: 1 }, { unique: true });
db.Developer.createIndex({ email: 1 }, { unique: true });

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

db.Repository.createIndex({ id: 1 }, { unique: true });

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

db.Ticket.createIndex({ id: 1 }, { unique: true });

db.createCollection("Project", {
  validator: {
    $jsonSchema: {
      bsonType: "object",
      required: ["id", "developers", "due_date", "name", "repositories"],
      properties: {
        id: { bsonType: "string", description: "ID del proyecto, requerido y debe ser string." },
        developers: {
          bsonType: "array",
          items: { bsonType: "string" },
          description: "Lista de referencias a ProjectDeveloper, debe ser un array de strings."
        },
        due_date: { bsonType: "date", description: "Fecha de entrega del proyecto, debe ser date." },
        name: { bsonType: "string", description: "Nombre del proyecto, requerido y debe ser string." },
        repositories: {
          bsonType: "array",
          items: { bsonType: "string" },
          description: "Lista de referencias a SoftwareDev:1.Repository, debe ser un array de strings."
        }
      }
    }
  }
});

db.Project.createIndex({ id: 1 }, { unique: true });

db.createCollection("ProjectManager", {
  validator: {
    $jsonSchema: {
      bsonType: "object",
      required: ["id", "email", "permissions", "dev_info", "in_active", "managed_projects"],
      properties: {
        id: { bsonType: "string", description: "ID del ProjectManager, requerido y debe ser string." },
        email: { bsonType: "string", pattern: "^.+@.+\\.com$", description: "Debe ser un email válido." },
        permissions: { enum: ["R", "W", "X", "RW", "RX", "WX", "RWX"], description: "Permisos válidos." },
        dev_info: {
          bsonType: "object",
          required: ["name", "team"],
          properties: {
            about_me: { bsonType: "string", description: "Información opcional sobre el manager." },
            name: { bsonType: "string", pattern: "^[A-Z][a-z]*$", description: "Debe empezar con mayúscula." },
            team: { bsonType: "string", description: "Nombre del equipo al que pertenece." }
          }
        },
        in_active: { bsonType: "bool", description: "Indica si el ProjectManager está activo." },
        managed_projects: { bsonType: "int", minimum: 0, description: "Cantidad de proyectos gestionados, debe ser número entero positivo." }
      }
    }
  }
});

db.ProjectManager.createIndex({ id: 1 }, { unique: true });
db.ProjectManager.createIndex({ email: 1 }, { unique: true });

db.createCollection("ProjectDeveloper", {
  validator: {
    $jsonSchema: {
      bsonType: "object",
      required: ["id", "email", "permissions", "dev_info", "languages", "solved_tickets"],
      properties: {
        id: { bsonType: "string", description: "ID del ProjectDeveloper, requerido y debe ser string." },
        email: { bsonType: "string", pattern: "^.+@.+\\.com$", description: "Debe ser un email válido." },
        permissions: { enum: ["R", "W", "X", "RW", "RX", "WX", "RWX"], description: "Permisos válidos." },
        dev_info: {
          bsonType: "object",
          required: ["name", "team"],
          properties: {
            about_me: { bsonType: "string", description: "Información opcional sobre el developer." },
            name: { bsonType: "string", pattern: "^[A-Z][a-z]*$", description: "Debe empezar con mayúscula." },
            team: { bsonType: "string", description: "Nombre del equipo." }
          }
        },
        languages: {
          bsonType: "array",
          items: { bsonType: "string" },
          description: "Lista de lenguajes de programación que conoce."
        },
        solved_tickets: {
          bsonType: "array",
          items: { bsonType: "string" },
          description: "Lista de referencias a SoftwareDev:1.Ticket, deben ser strings."
        }
      }
    }
  }
});

db.ProjectDeveloper.createIndex({ id: 1 }, { unique: true });
db.ProjectDeveloper.createIndex({ email: 1 }, { unique: true });

