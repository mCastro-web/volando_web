
![Logo](https://cdn.discordapp.com/attachments/921147865882058752/1407950946423537746/image.png?ex=68a7f800&is=68a6a680&hm=b7011f9f6f1ed227d69182a6ff59bda34a44bb5d699332b6ef473858f1da0390&)




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
