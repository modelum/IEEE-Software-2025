use Vigilancias;

// Validador para Departamento
db.createCollection("Departamento", {
  validator: {
    $jsonSchema: {
      bsonType: "object",
      required: ["siglas", "nombre", "cuantos_profesores"],
      properties: {
        siglas: { bsonType: "string", description: "Código del departamento (identificador único)." },
        nombre: { bsonType: "string", description: "Nombre del departamento." },
        cuantos_profesores: { bsonType: "int", minimum: 0, maximum: 99, description: "Número de profesores en el departamento (0-99)." }
      }
    }
  }
});

db.Departamento.createIndex({ siglas: 1 }, { unique: true });


// Validador para Profesor
db.createCollection("Profesor", {
  validator: {
    $jsonSchema: {
      bsonType: "object",
      required: ["DNI", "nombre", "categoria", "departamento"],
      properties: {
        DNI: { bsonType: "string", description: "DNI del profesor, requerido y debe ser string." },
        nombre: { bsonType: "string", description: "Nombre del profesor, requerido y debe ser string." },
        email: { bsonType: "string", pattern: "^.+@.+\\.com$", description: "Debe ser un email válido." },
        categoria: { enum: ["CU", "TU", "CEU", "TEU", "AYD", "ASO", "CD"], description: "Categoría válida del profesor." },
        departamento: { bsonType: "string", description: "Referencia al departamento al que pertenece el profesor." },
        asignatura: { bsonType: "string", description: "Referencia a la asignatura que imparte el profesor (opcional)." },
        creditos: { bsonType: "int", minimum: 1, maximum: 99, description: "Número de créditos asignados al profesor (opcional)." },
        TelefonoProfesores: {
          bsonType: "array",
          description: "Lista de teléfonos asociados al profesor.",
          items: {
            bsonType: "int", minimum: 600000000, maximum: 999999999,
            description: "Número de teléfono del profesor, debe estar en el rango válido."
          }
        }
      }
    }
  }
});

db.Profesor.createIndex({ DNI: 1 }, { unique: true });
db.Profesor.createIndex({ email: 1 }, { unique: true, sparse: true });


// Validador para Asignatura
db.createCollection("Asignatura", {
  validator: {
    $jsonSchema: {
      bsonType: "object",
      required: ["codigo", "nombre", "cuatrimestre", "departamento", "coordinador"],
      properties: {
        codigo: { bsonType: "string", description: "Código único de la asignatura." },
        nombre: { bsonType: "string", description: "Nombre de la asignatura." },
        cuatrimestre: { bsonType: "int", enum: [0, 1, 2], description: "Cuatrimestre en el que se imparte (0, 1, 2)." },
        departamento: { bsonType: "string", description: "Referencia al departamento que imparte la asignatura." },
        coordinador: { bsonType: "string", description: "Referencia al profesor coordinador de la asignatura." },
        prerrequisito: { bsonType: "string", description: "Referencia a la asignatura prerrequisito (opcional)." },
        Examenes: {
          bsonType: "array",
          description: "Lista de exámenes de la asignatura.",
          items: {
            bsonType: "object",
            required: ["curso", "convocatoria", "fecha_hora", "duracion", "vigilante", "aula"],
            properties: {
              curso: { bsonType: "string", description: "Curso académico del examen." },
              convocatoria: { enum: ["Junio", "Julio", "Enero"], description: "Convocatoria del examen." },
              fecha_hora: { bsonType: "date", description: "Fecha y hora del examen." },
              duracion: { bsonType: "int", minimum: 1, maximum: 999, description: "Duración del examen en minutos." },
              vigilante: { bsonType: "string", description: "Referencia al profesor vigilante del examen." },
              aula: { bsonType: "array", minItems: 1,
	            items: {
	              bsonType: "string",
	              description: "Referencia a las aulas donde se realiza el examen (código de aula)."
	            },
	            description: "Lista de aulas donde se imparte el examen (mínimo 1 aula)."
	           }
            }
          }
        }
      }
    }
  }
});

db.Asignatura.createIndex({ codigo: 1 }, { unique: true });
db.Asignatura.createIndex({ coordinador: 1 }, { unique: true });

// Validador para Aula
db.createCollection("Aula", {
  validator: {
    $jsonSchema: {
      bsonType: "object",
      required: ["codigo", "capacidad", "puestos_examen", "centro"],
      properties: {
        codigo: { bsonType: "string", description: "Código único del aula." },
        capacidad: { bsonType: "int", minimum: 1, maximum: 999, description: "Capacidad total del aula." },
        puestos_examen: { bsonType: "int", minimum: 1, maximum: 999, description: "Número de puestos de examen." },
        nombre: { bsonType: "string", description: "Nombre del aula (opcional)." },
        centro: { bsonType: "string", description: "Centro donde está ubicada el aula." }
      }
    }
  }
});

db.Aula.createIndex({ codigo: 1 }, { unique: true });

