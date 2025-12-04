<div align="center">
  <img src="https://i.ibb.co/QFKT3pNr/favicon.png" alt="Volando.uy Logo" width="300"/>
  
  # VolandoUy - Plataforma de Gestión de Vuelos
  
  ![Java](https://img.shields.io/badge/Java-21-orange?style=for-the-badge&logo=openjdk&logoColor=white)
  ![Spring Boot](https://img.shields.io/badge/Spring%20Boot-3.2.5-6DB33F?style=for-the-badge&logo=spring-boot&logoColor=white)
  ![Maven](https://img.shields.io/badge/Maven-3.x-C71A36?style=for-the-badge&logo=apache-maven&logoColor=white)
  ![JSP](https://img.shields.io/badge/JSP-Jakarta-007396?style=for-the-badge)
  ![Material Design](https://img.shields.io/badge/Material%20Design-2.4.0-757575?style=for-the-badge&logo=material-design&logoColor=white)
  ![JAX-WS](https://img.shields.io/badge/JAX--WS-4.0.1-4B8BBE?style=for-the-badge)
  
</div>

---

## Descripción

Volando.uy es una plataforma web de gestión de vuelos orientada a usuarios finales y compañías aéreas. El sistema permite publicar, visualizar y reservar vuelos, además de ofrecer funcionalidades sociales y de gestión avanzada.

## Características Principales

### Para Usuarios
- Búsqueda y visualización de vuelos individuales o en paquetes
- Reserva de pasajes aéreos
- Check-in online y generación de boarding pass
- Facturación electrónica
- Seguimiento de compañías aéreas favoritas
- Marcado de destinos favoritos
- Sistema de recomendaciones personalizadas

### Para Compañías Aéreas
- Publicación de vuelos y paquetes
- Gestión de demoras y costos
- Administración de rutas y horarios
- Panel de control de reservas

### Características Técnicas
- Arquitectura distribuida cliente-servidor + capas
- Comunicación remota mediante Web Services SOAP
- Ejecución concurrente
- Seguridad y autenticación de usuarios
- Persistencia con JPA
- Interfaz web moderna y responsiva

## 🛠️ Stack Tecnológico

### Backend
- **Java 21 LTS** - Lenguaje de programación
- **Spring Boot 3.2.5** - Framework principal
- **JAX-WS 4.0.1** - Cliente SOAP para comunicación con Web Services
- **JAXB 4.0.5** - Marshalling/Unmarshalling XML
- **JPA 3.1.0** - Jakarta Persistence API
- **jBCrypt 0.4** - Encriptación de contraseñas
- **Maven** - Gestión de dependencias

### Frontend
- **JSP (Jakarta Server Pages)** - Motor de vistas
- **JSTL 3.0** - Jakarta Standard Tag Library
- **Flyion UI** - Componentes UI
- **Material Icons 1.13.14** - Iconografía
- **Notyf 3.10.0** - Notificaciones

### Generación de Documentos
- **iTextPDF 5.5.13.3** - Generación de PDFs (boarding pass, facturas)

## Requisitos Previos

- Java Development Kit (JDK) 21 o superior
- Maven 3.x
- Node.js y npm (para dependencias frontend)
- Servidor de Web Services SOAP en ejecución (volando_ws)

## 📥 Instalación

1. Clonar el repositorio:
```bash
git clone https://github.com/mCastro-web/volando_web.git
cd volando_web
```

2. Instalar dependencias de frontend:
```bash
npm install
```

3. Configurar la URL del Web Service (opcional):
```bash
# Por defecto: http://localhost:8090/Sistema?wsdl
# Para cambiar, editar pom.xml o usar:
mvn clean package -Dws.sistema.url=http://tu-servidor:puerto/Sistema?wsdl
```

4. Generar clases del cliente SOAP:
```bash
mvn clean generate-sources
```

5. Compilar el proyecto:
```bash
mvn clean package
```

## Ejecución

### Modo Desarrollo con Spring Boot

```bash
mvn spring-boot:run
```

La aplicación estará disponible en el puerto y direccion especificados en config.propoerties

### Despliegue en Servidor de Aplicaciones

El proyecto genera un archivo WAR que puede ser desplegado en cualquier servidor compatible con Jakarta EE:

```bash
# El WAR se genera en target/volandouy.war
mvn clean package

# Copiar a tu servidor (ejemplo Tomcat):
cp target/volandouy.war $TOMCAT_HOME/webapps/
```

## ⚙️ Configuración

### Web Service URL

La URL del Web Service SOAP se puede configurar en el `pom.xml`:

```xml
<properties>
    <ws.sistema.url>http://localhost:8090/Sistema?wsdl</ws.sistema.url>
</properties>
```

O mediante parámetro en tiempo de construcción:

```bash
mvn clean package -Dws.sistema.url=http://production-server:8090/Sistema?wsdl
```

## Estructura del Proyecto

```
volando_web/
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   └── uy/
│   │   │       └── volandouy/
│   │   │           ├── controllers/
│   │   │           ├── services/
│   │   │           ├── models/
│   │   │           └── utils/
│   │   ├── resources/
│   │   └── webapp/
│   │       ├── WEB-INF/
│   │       │   └── views/
│   │       ├── css/
│   │       ├── js/
│   │       └── images/
│   └── test/
├── node_modules/
├── pom.xml
├── package.json
└── README.md
```

## Arquitectura

El sistema implementa una arquitectura distribuida de tres capas:

1. **Capa de Presentación (Frontend)**: JSP + Material Design
2. **Capa de Aplicación (Backend)**: Spring Boot + Servlets
3. **Capa de Lógica de Negocio**: Accedida mediante Web Services SOAP

```
┌─────────────────┐
│   volando_web   │ ← Interfaz Web (JSP + Spring Boot)
│   (Frontend)    │
└────────┬────────┘
         │ SOAP
         ↓
┌─────────────────┐
│   volando_ws    │ ← Web Services (JAX-WS)
│  (Web Services) │
└────────┬────────┘
         │
         ↓
┌─────────────────┐
│  volando_src    │ ← Lógica de Negocio (JPA + Hibernate)
│    (Backend)    │
└─────────────────┘
```

## 📦 Funcionalidades Implementadas

### Autenticación y Seguridad
- Sistema de registro de usuarios
- Login con encriptación BCrypt
- Gestión de sesiones
- Control de acceso por roles

### Gestión de Vuelos
- Listado y búsqueda de vuelos
- Visualización de detalles
- Sistema de reservas
- Paquetes de vuelos

### Check-in y Boarding Pass
- Check-in online
- Generación de boarding pass en PDF
- Selección de asientos

### Facturación
- Generación automática de facturas
- Descarga de facturas en PDF
- Historial de compras

### Funciones Sociales
- Seguimiento de compañías aéreas
- Destinos favoritos
- Sistema de recomendaciones
- Perfiles de usuario

## Desarrollo

### Herramientas Recomendadas
- **IDE**: IntelliJ IDEA
- **Control de versiones**: Git + GitHub
- **Testing**: JUnit (en desarrollo)

### 🔧 Comandos Útiles

```bash
# Compilar sin tests
mvn clean package -DskipTests

# Limpiar proyecto
mvn clean

# Generar solo las clases del Web Service
mvn generate-sources

# Ejecutar en modo debug
mvn spring-boot:run -Dspring-boot.run.jvmArguments="-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=5005"
```


## 📄 Licencia

Este proyecto cuenta con Licencia MIT.

## Proyectos Relacionados

- [volando_ws](https://github.com/mCastro-web/volando_ws) - Web Services SOAP
- [volando_src](https://github.com/mCastro-web/volando_src) - Lógica de Negocio (Backend)

## Soporte

Para reportar problemas o solicitar nuevas características, por favor abre un issue en el repositorio de GitHub.

---

<div align="center">
  Desarrollado con ☕ y Java 21
</div>
