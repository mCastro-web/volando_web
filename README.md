<p align="center">
  <img src="https://github.com/MatiasAlfaroDev/volando-uy/blob/main/src/main/resources/static/favicon.png?raw=true" 
       alt="Logo" 
       width="150" 
       height="150">
</p>



<p align="center">
  <img alt="Java" src="https://img.shields.io/badge/java-%23ED8B00.svg?style=for-the-badge&logo=openjdk&logoColor=white">
  <img alt="Spring" src="https://img.shields.io/badge/spring-%236DB33F.svg?style=for-the-badge&logo=spring&logoColor=white">
  <img alt="Maven" src="https://img.shields.io/badge/apachemaven-C71A36.svg?style=for-the-badge&logo=apachemaven&logoColor=white">
  <img alt="Postgres" src="https://img.shields.io/badge/postgres-%23316192.svg?style=for-the-badge&logo=postgresql&logoColor=white">
  <img alt="Git" src="https://img.shields.io/badge/git-%23F05033.svg?style=for-the-badge&logo=git&logoColor=white">
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
