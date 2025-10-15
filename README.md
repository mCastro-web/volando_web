
![Logo](https://github.com/MatiasAlfaroDev/volando-uy/blob/main/src/main/resources/static/favicon.png?raw=true)




[![Java](https://img.shields.io/badge/Java-17-blue?logo=java)](https://www.oracle.com/java/) [![Swing](https://img.shields.io/badge/Swing-UI-orange?logo=java)](https://docs.oracle.com/javase/tutorial/uiswing/) ![JPA](https://img.shields.io/badge/JPA-Persistence-green?logo=hibernate) [![Git](https://img.shields.io/badge/Git-Version_Control-red?logo=git)](https://git-scm.com/) [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

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
