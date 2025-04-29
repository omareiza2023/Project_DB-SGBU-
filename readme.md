# 📚 Sistema de Gestión de Biblioteca Universitaria

## Tabla de Contenidos

- [Descripción General](#descripción-general)
- [Contenidos del Repositorio](#contenidos-del-repositorio)
- [Funcionalidades Principales](#funcionalidades-principales)
- [Ejecución del Proyecto](#ejecución-del-proyecto)
- [Créditos del Proyecto](#créditos-del-proyecto)

---

## Descripción General

Este proyecto consiste en el diseño, desarrollo e implementación de una base de datos completa para administrar las operaciones de una biblioteca universitaria. Se abordan funcionalidades como la gestión de libros, copias físicas, socios (estudiantes y profesores), préstamos, devoluciones, reservas, multas y el control del personal de la biblioteca.

**Tecnologías utilizadas:**
- PostgreSQL como sistema gestor de base de datos.
- Docker para la gestión y ejecución del ambiente de bases de datos.

> **Nota:** Todo el contenido del proyecto está desarrollado y almacenado directamente en la rama `main`. No se utilizan ramas adicionales. Cualquier mención o referencia a otras ramas dentro de los documentos o scripts debe considerarse incorrecta.

---

## Contenidos del Repositorio

| Archivo/Carpeta | Descripción |
| :-------------- | :---------- |
| `/scripts/CTES.md` | Consultas optimizadas utilizando expresiones comunes (CTE). |
| `/scripts/Functions.md` | Funciones definidas por el usuario para operaciones específicas. |
| `/scripts/Index.md` | Índices aplicados para mejorar el rendimiento en búsquedas. |
| `/scripts/Inserts.md` | Ejemplos de inserción de datos en las tablas principales. |
| `/scripts/Security_and_acces.md` | Definición de roles, permisos y medidas de seguridad. |
| `/scripts/StoredProcedure.md` | Procedimientos almacenados (CRUD y otras lógicas del sistema). |
| `/scripts/Tables.md` | Estructura detallada de todas las tablas del modelo. |
| `/scripts/Triggers.md` | Triggers para auditoría y automatización de eventos. |
| `/scripts/View.md` | Vistas creadas para facilitar el acceso a datos consolidados. |
| `modelo/ModeloRelacional.drawdb` | Modelo relacional del sistema (DrawDB). |
|funciones y triggers. |

| `/documentacion/DiccionarioDatos.xlsx` | Diccionario de datos de todas las tablas. |
| `/documentacion/PresentacionProyecto.pptx` | Presentación resumen del proyecto (10 diapositivas). |
---

## Funcionalidades Principales

- **Modelo Relacional:** Representación detallada de todas las entidades y relaciones principales del sistema.
- **Procedimientos Almacenados (CRUD):** Operaciones estandarizadas para inserción, actualización y eliminación de registros.
- **Funciones Definidas por el Usuario:** Cálculo de multas, verificación de disponibilidad de libros, entre otras.
- **Triggers de Auditoría:** Registro automático de cambios importantes en las tablas principales.
- **Consultas SQL Avanzadas:** Ejecución de consultas utilizando INNER JOIN, LEFT JOIN, RIGHT JOIN, subconsultas y optimizaciones CTE.
- **Vistas SQL:** Vistas creadas para simplificar consultas recurrentes (ej. libros prestados, multas pendientes).
- **Seguridad y Roles:** Definición de roles específicos (bibliotecario, administrador, socio) con permisos diferenciados.
- **Optimización de Consultas:** Aplicación de índices y técnicas de optimización para mejorar el rendimiento.

---

## Ejecución del Proyecto

1. Clonar el repositorio.
2. Iniciar la base de datos utilizando Docker:

   ```bash
   docker-compose up -d
   
   ```


