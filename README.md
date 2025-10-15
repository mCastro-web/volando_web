<p align="center">
  <img src="https://github.com/MatiasAlfaroDev/volando-uy/blob/main/src/main/resources/static/favicon.png?raw=true" 
       alt="Logo" 
       width="150" 
       height="150">
</p>



<p align="center">

[![Java](https://img.shields.io/badge/Java-%23ED8B00.svg?logo=openjdk&logoColor=white)] [![Spring Boot](https://img.shields.io/badge/Spring%20Boot-6DB33F?logo=springboot&logoColor=fff)] [![Maven](https://img.shields.io/badge/apachemaven-C71A36.svg?style=for-the-badge&logo=apachemaven&logoColor=white)] [![Postgres](https://img.shields.io/badge/Postgres-%23316192.svg?logo=postgresql&logoColor=white)] [![Git]([https://img.shields.io/badge/Git-Version_Control-red?logo=git)](https://git-scm.com/](https://img.shields.io/badge/git-%23F05033.svg?style=for-the-badge&logo=git&logoColor=white)) [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
</p>

---


**Volando.uy** es una plataforma de gestión de Vuelos orientada a usuarios finales y compañías aéreas, que permite:

- Publicar y visualizar Vuelos individuales o en paquetes.
- Reservar pasajes, realizar check-in, obtener boarding pass y facturación.
- Gestionar demoras y costos.
- Acceder a funciones sociales: seguir compañías, marcar destinos favoritos, recibir recomendaciones.

---

## Arquitectura

El sistema se desarrolla como una **aplicación distribuida de mediano porte**, utilizando tecnologías basadas en Java, y estructurada bajo una arquitectura **híbrida** (cliente-servidor + capas). Se contemplan los siguientes aspectos:

- Distribución física de nodos.
- Comunicación remota y ejecución concurrente.
- Interfaz gráfica en escritorio (Java Swing) y eventualmente web.
- Seguridad y autenticación.
- Persistencia de información con **JPA**.

---

##  Tecnologías Utilizadas

| Componente        | Tecnología         |
|-------------------|--------------------|
| Lenguaje          | Java 21 LTS         |
| Interfaz de Usuario | Java Swing         |
| Persistencia      | JPA / Hibernate    |
| IDE               | IntelliJ IDEA       |
| Control de versiones | Git + GitHub     |
