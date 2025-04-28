# 📚 Sistema de Gestión de Biblioteca Universitaria

## Tabla de Contenidos

- [Descripción General](#descripción-general)
- [Contenidos del Repositorio](#contenidos-del-repositorio)
- [Funcionalidades Principales](#funcionalidades-principales)
- [Ejecución del Proyecto](#ejecución-del-proyecto)

---

## Descripción General

Este proyecto consiste en el diseño, desarrollo e implementación de una base de datos completa para administrar las operaciones de una biblioteca universitaria. Se abordan funcionalidades como la gestión de libros, copias físicas, socios (estudiantes y profesores), préstamos, devoluciones, reservas, multas y el control del personal de la biblioteca.

**Tecnologías utilizadas:**
- PostgreSQL como sistema gestor de base de datos.
- Docker para la gestión y ejecución del ambiente de bases de datos.

---

## Contenidos del Repositorio

| Archivo/Carpeta | Descripción |
| :-------------- | :---------- |
| `/modelo/ModeloRelacional.drawdb` | Archivo con el diseño del modelo relacional de la base de datos en formato DrawDB. Incluye más de 15 tablas principales y sus relaciones. |
| `/scripts/CreacionTablas.sql` | Script SQL para la creación de todas las tablas, relaciones, restricciones y objetos de la base de datos. |
| `/scripts/InsercionDatos.sql` | Script SQL con datos de ejemplo (mínimo 5 registros por tabla relevante) para poblar la base de datos. |
| `/scripts/ProcedimientosFuncionesTriggers.sql` | Script que contiene la creación de procedimientos almacenados (CRUD), funciones definidas por el usuario y triggers de auditoría. |
| `/scripts/ConsultasOptimización.sql` | Archivo SQL con consultas avanzadas, subconsultas y optimizaciones usando CTEs (Common Table Expressions). |
| `/documentacion/DiccionarioDatos.xlsx` | Documento Excel que detalla cada tabla, sus atributos, tipos de datos, llaves primarias, foráneas y descripciones. |
| `/documentacion/PresentacionProyecto.pptx` | Presentación resumen del proyecto (máximo 10 diapositivas) cubriendo contexto, estructura de la BD, optimización, seguridad, y conclusiones. |
| `/docker-compose.yml` | Archivo de configuración para levantar la base de datos PostgreSQL utilizando Docker. |
| `/README.md` | Archivo de descripción general del proyecto (este documento). |

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
