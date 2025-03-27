# OrionTraining y AthenaTraining: Entrenamiento y Pruebas de DSLs con LLM

Este repositorio contiene los proyectos OrionTraining y AthenaTraining, donde se han llevado a cabo procesos 
de entrenamiento y validación de modelos de lenguaje para la comprensión, 
transformación y evolución de los DSLs Orion [1] y Athena [2].

[1] Alberto Hernández Chillón, Meike Klettke, Diego Sevilla Ruiz, Jesús García Molina:
A Generic Schema Evolution Approach for NoSQL and Relational Databases. IEEE Trans. Knowl. Data Eng. 36(7): 2774-2789 (2024)
(https://ieeexplore.ieee.org/abstract/document/10420500)

[2] 	Alberto Hernández Chillón, Diego Sevilla Ruiz, Jesús García Molina:
Athena: A Database-Independent Schema Definition Language. ER (Workshops) 2021: 33-42
(https://www.researchgate.net/publication/355185841_Athena_A_Database-Independent_Schema_Definition_Language)

# Estructura del Repositorio

Cada proyecto sigue la misma organización interna, separando las fases de entrenamiento y pruebas, con los correspondientes prompts utilizados. Además se adjunta una conversación con el modelo que sigue los prompts que se han lanzado pero con modificaciones mínimas.

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
3. Evaluar resultados. Hay resultados que requerirán de resolución de dudas para 
mejorar el modelo. 
