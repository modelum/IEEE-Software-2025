# OrionTraining and AthenaTraining: DSL Training and Testing with LLM

This repository contains the OrionTraining and AthenaTraining projects, where training and validation processes for language models have been carried out for the comprehension, transformation, and evolution of the Orion [1] and Athena [2] DSLs.

[1] Alberto Hernández Chillón, Meike Klettke, Diego Sevilla Ruiz, Jesús García Molina:
A Generic Schema Evolution Approach for NoSQL and Relational Databases. IEEE Trans. Knowl. Data Eng. 36(7): 2774-2789 (2024)
(https://ieeexplore.ieee.org/abstract/document/10420500)

[2] 	Alberto Hernández Chillón, Diego Sevilla Ruiz, Jesús García Molina:
Athena: A Database-Independent Schema Definition Language. ER (Workshops) 2021: 33-42
(https://www.researchgate.net/publication/355185841_Athena_A_Database-Independent_Schema_Definition_Language)

# Repository Structure

Each project follows the same internal organization, separating the training and testing phases, along with the corresponding prompts used. In addition, a conversation with the model is included, following the prompts that were executed but with minimal modifications.

- **/**
    - 📁 **.AthenaTraining/**
        - 📁 Learning/
            - 📁 1-Step (Formal Definition)/
                - 📄 Formal Specification.txt
            - 📁 2-Step (Articles)/
                - 📄 Athena.png
                - 📄 ChapterAthena.pdf
                - 📄 DesignAthena.pdf
            - 📁 3-Step (Examples)/
                - 📁 CentroDeportivo/
                    - 📄 CentroDeportivo.athena
                    - 📄 CentroDeportivo.cql
                    - 📄 CentroDeportivo.js
                    - 📄 CentroDeportivo.sql
                - 📁 SoftwareDev/
                    - 📄 SoftwareDev.athena
                    - 📄 SoftwareDev.cql
                    - 📄 SoftwareDev.js
                    - 📄 SoftwareDev.sql
                - 📁 SoftwareProject/
                    - 📄 SoftwareProject.athena
                    - 📄 SoftwareProject.cql
                    - 📄 SoftwareProject.js
                    - 📄 SoftwareProject.sql
                - 📁 Umugram/
                    - 📄 Umugram.athena
                    - 📄 Umugram.cql
                    - 📄 Umugram.js
                    - 📄 Umugram.sql
                - 📁 Vigilancias/
                    - 📄 Vigilancias.athena
                    - 📄 Vigilancias.cql
                    - 📄 Vigilancias.js
                    - 📄 Vigilancias.sql
            - 📄 Prompt.txt
        - 📁 Testing/
            - 📁 Athena2Schema/
                - 📄 EduPlatform.athena
            - 📁 Schema2Athena/
                - 📄 Cassandra2Athena.cql
                - 📄 MongoValidator2Athena.js
                - 📄 NaturalLanguage2Athena.txt
                - 📄 SQL2Athena.sql
            - 📄 Prompt.txt
    - 📁 **.OrionTraining/**
        - 📁 Learning/
            - 📁 1-Step (Formal Definition)/
                - 📄 Formal Specification.txt
            - 📁 2-Step (Articles)/
                - 📄 Athena.txt
                - 📄 ChapterAthena.pdf
                - 📄 DesignAthena.pdf
            - 📁 3-Step (Examples)/
                - 📁 GameTracker/
                    - 📄 GameTracker1.athena
                    - 📄 GameTracker2.athena
                    - 📄 GameTrackerChange.cql
                    - 📄 GameTrackerChange.cypher
                    - 📄 GameTrackerChange.js
                    - 📄 GameTrackerChange.orion
                    - 📄 GameTrackerChange.sql
                - 📁 RunningSong/
                    - 📄 RunningSong1.athena
                    - 📄 RunningSong2.athena
                    - 📄 RunningSong3.athena
                    - 📄 RunningSongChange.cql
                    - 📄 RunningSongChange.cypher
                    - 📄 RunningSongChange.js
                    - 📄 RunningSongChange.orion
                    - 📄 RunningSongChange.sql
            - 📄 Prompt.txt
        - 📁 Testing/
            - 📁 Orion2Schema/
                - 📄 EduPlatform.athena
                - 📄 EduPlatformChange.orion
            - 📁 Schema2Orion/
                - 📄 CQL2Orion.cql
                - 📄 MongoDB2Orion.js
                - 📄 Neo4j2Orion.cypher
                - 📄 SQL2Orion.sql
            - 📄 Prompt.txt
    - 📄 EntrenamientoConversación.html

# File Description
## Training and Testing Prompts
Each `prompt.txt` file contains multiple prompts used to train and evaluate the model.
The prompts are separated by the delimiter "----", which allows for a clear differentiation of each query or instruction given to the model.

- **Learning** folder: Contains the prompts designed for the model to learn the structure and rules of each DSL, including transformations to different database schemas.
- **Testing** folder: Contains the prompts used to evaluate the language model's ability to understand and transform code from the DSLs.

## Usage Instructions
You can see the example conversations here:

Athena: https://chatgpt.com/share/689a0551-d5f4-800b-9adb-98eb7e14cfa4

Orion: https://chatgpt.com/share/68961d20-1aa8-800b-b9bd-2eca64d7cf1f
1. Review the prompts.
2. Execute the prompts.
3. Evaluate results. Some results will require clarification to improve the model.
