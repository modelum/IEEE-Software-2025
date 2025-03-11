# OrionTraining y AthenaTraining: Entrenamiento y Pruebas de DSLs con LLM

Este repositorio contiene los proyectos OrionTraining y AthenaTraining, donde se han llevado a cabo procesos 
de entrenamiento y validación de modelos de lenguaje para la comprensión, 
transformación y evolución de los DSLs Orion y Athena.

# Estructura del Repositorio

Cada proyecto sigue la misma organización interna, separando las fases de entrenamiento y pruebas, con los correspondientes prompts utilizados. Además se adjunta una conversación tenida con el modelo siguiendo los prompts planteados con modificaciones mínimas.

📂 OrionTraining/
 ├── 📂 entrenamiento/
 │    ├── prompt.txt
 │    ├── ...
 ├── 📂 pruebas/
 │    ├── prompt.txt
 │    ├── ...
 
📂 AthenaTraining/
 ├── 📂 entrenamiento/
 │    ├── prompt.txt
 │    ├── ...
 ├── 📂 pruebas/
 │    ├── prompt.txt
 │    ├── ...
 EntrenamientoConversación.html

# Descripción de los Archivos
## Prompts en Entrenamiento y Pruebas
Cada archivo `prompt.txt` contiene múltiples prompts utilizados para entrenar y evaluar el modelo.
Los prompts están separados por el delimitador "----", lo que permite diferenciar claramente cada consulta o instrucción dada al modelo. 

- Carpeta **entrenamiento**: Contiene los prompts diseñados para que el modelo aprenda la estructura y reglas de cada DSL, incluyendo transformaciones a diferentes esquemas de bases de datos.
- Carpeta **pruebas**: Contiene los prompts utilizados para evaluar la capacidad del modelo de lenguaje al comprender y transformar código de los DSLs.

## Instrucciones de Uso 

1. Consultar los prompts.
2. Ejecutar los prompts.
3. Evaluar resultados. Hay resultados que requerirán de resulución de dudas para 
mejorar el modelo. 
