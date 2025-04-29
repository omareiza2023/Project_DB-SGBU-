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
| `/manual_practico_db_sql/consultas_subconsultas.sql` | Consultas utilizando subconsultas para diferentes operaciones. |
| `/manual_practico_db_sql/CTES.sql` | Consultas optimizadas utilizando expresiones comunes (CTEs). |
| `/manual_practico_db_sql/funciones.sql` | Funciones SQL específicas para operaciones en la base de datos. |
| `/manual_practico_db_sql/indices.sql` | Definición de índices para optimización de consultas. |
| `/manual_practico_db_sql/vistas.sql` | Creación de vistas para consultas consolidadas. |
| `/scripts/CTES.md` | Documentación de consultas optimizadas utilizando expresiones comunes (CTE). |
| `/scripts/Functions.md` | Documentación de funciones definidas por el usuario. |
| `/scripts/Index.md` | Documentación de los índices implementados. |
| `/scripts/Inserts.md` | Ejemplos de inserción de datos. |
| `/scripts/Security_and_acces.md` | Definición de roles, permisos y medidas de seguridad. |
| `/scripts/StoredProcedure.md` | Procedimientos almacenados del sistema. |
| `/scripts/Tables.md` | Estructura y detalles de todas las tablas. |
| `/scripts/Triggers.md` | Definición de triggers implementados. |
| `/scripts/View.md` | Documentación de vistas creadas. |
| `/documentacion/DiccionarioDatos.xlsx` | Diccionario de datos de todas las tablas. |
| `/documentacion/PresentacionProyecto.pptx` | Presentación general del proyecto (10 diapositivas). |
| `/documentacion/Evidencias.md` | Evidencias de funcionalidad |
| `/Backup_project_DB_II` | Backup de la base de datos en general |

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
