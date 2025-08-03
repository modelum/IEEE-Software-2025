use CentroDeportivo;

db.createCollection("Instalacion", {
  validator: {
    $jsonSchema: {
      bsonType: "object",
      required: ["instalacion_id", "nombre", "tipo", "m2"],
      properties: {
        instalacion_id: { bsonType: "string", description: "ID de la instalación, requerido y debe ser string." },
        nombre: { bsonType: "string", description: "Nombre de la instalación, requerido y debe ser string." },
        tipo: { enum: ["Interior", "Exterior"], description: "Tipo debe ser Interior o Exterior." },
        m2: { bsonType: "double", minimum: 1, maximum: 9999999, description: "Superficie en m2, debe estar entre 1 y 9999999." }
      }
    }
  }
});

db.Instalacion.createIndex({ instalacion_id: 1 }, { unique: true });

db.createCollection("Monitor", {
  validator: {
    $jsonSchema: {
      bsonType: "object",
      required: ["dni", "nombre", "telefono", "fcontrato", "salario", "especialista"],
      properties: {
        dni: { bsonType: "string", description: "DNI del monitor, requerido y debe ser string." },
        nombre: { bsonType: "string", description: "Nombre del monitor, requerido y debe ser string." },
        telefono: { bsonType: "int", minimum: 600000000, maximum: 999999999, description: "Teléfono debe ser un número entre 600000000 y 999999999." },
        fcontrato: { bsonType: "date", description: "Fecha de contrato, debe ser date." },
        salario: { bsonType: "double", minimum: 0, maximum: 999999, description: "Salario, debe estar entre 0 y 999999." },
        especialista: { bsonType: "array", items: { bsonType: "string" }, description: "Lista de IDs de actividades especializadas." }
      }
    }
  }
});

db.Monitor.createIndex({ dni: 1 }, { unique: true });

db.createCollection("Actividad", {
  validator: {
    $jsonSchema: {
      bsonType: "object",
      required: ["actividad_id", "nombre", "nivel", "responsable", "instalacion", "sesiones"],
      properties: {
        actividad_id: { bsonType: "string", description: "ID de la actividad, requerido y debe ser string." },
        nombre: { bsonType: "string", description: "Nombre de la actividad, requerido y debe ser string." },
        nivel: { bsonType: "int", minimum: 1, maximum: 5, description: "Nivel debe estar entre 1 y 5." },
        precio: { bsonType: "double", minimum: 0, maximum: 9999, description: "Precio opcional, entre 0 y 9999." },
        responsable: { bsonType: "string", description: "Referencia al monitor responsable." },
        instalacion: { bsonType: "string", description: "Referencia a la instalación donde se imparte la actividad." },
        sesiones: {
          bsonType: "array",
          items: {
            bsonType: "object",
            required: ["diasemana", "hora", "monitor"],
            properties: {
              diasemana: { enum: ["L", "M", "X", "J", "V", "S"], description: "Día de la semana debe ser un valor válido." },
              hora: { bsonType: "double", description: "Hora" },
              monitor: { bsonType: "string", description: "Referencia al monitor que imparte la sesión." }
            }
          },
          description: "Lista de sesiones de la actividad."
        }
      }
    }
  }
});

db.Actividad.createIndex({ actividad_id: 1 }, { unique: true });


