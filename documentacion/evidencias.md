# 📸 Evidencias del Funcionamiento de la Base de Datos

Este apartado presenta un conjunto de evidencias gráficas que validan el correcto funcionamiento de los componentes clave de la base de datos del sistema de gestión de biblioteca universitaria. A continuación, se detallan las pruebas realizadas con sus respectivas capturas de pantalla almacenadas en rutas del proyecto.

---

## 🔍 Índices: Prueba de Mejora en el Rendimiento

Se validó que los índices definidos permiten una ejecución más eficiente de las consultas frecuentes.

![Indices](/documentacion/img/index1.png)
![Indices](/documentacion/img/index2.png)

---

## 🧮 Funciones: Ejecución Correcta de Funciones SQL

Se probaron funciones definidas por el usuario, como el cálculo de multas y verificación de disponibilidad.

![FUNCIONES](/documentacion/img/funcion1.png)

---

## 🧾 Triggers y Auditoría: Registro de Cambios

Se comprobó que los triggers definidos, junto con la función de auditoría, almacenan correctamente los cambios realizados sobre las tablas principales.

![TABLA DE AUDITORIA](/documentacion/img/auditoria_general.png)

---

## 📚 Historial de Reservas: Registro Automático de Cada prestamo

Cada vez que se realiza una reserva nueva, se registra automáticamente en la tabla `historial_prestamos`, confirmando que la funcionalidad opera como se esperaba.

![Historial DE Prestamos](/documentacion/img/Historial_prestamo.png)
---

## 🔄 CTEs: Pruebas de Consultas con Expresiones Comunes

Se ejecutaron consultas utilizando Common Table Expressions (CTEs) para validar su funcionamiento y legibilidad.

![vista 1](/documentacion/img/)
![vista 2](/documentacion/img/)

---

## 👓 Vistas: Verificación de Resultados Consolidados

Se consultaron todas las vistas creadas para verificar que devuelven correctamente la información consolidada.

![vista 1](/documentacion/img/vista1.png)
![vista 2](/documentacion/img/vista2.png)


---

## 🧱 Modelo Final: Vista General del Esquema Relacional

Luego de la construcción completa del modelo, se documentó visualmente el diagrama relacional con todas las tablas, relaciones y claves primarias/foráneas.

![Modelo relacional](/documentacion/img/DrawDB.png)

