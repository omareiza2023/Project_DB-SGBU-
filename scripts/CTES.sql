
-- CTE 1: Listar socios con multas pendientes mayores a $5
WITH socios_con_multas AS (
    SELECT id_socio, SUM(monto) AS total_multa
    FROM multa
    WHERE estado = 'pendiente'
    GROUP BY id_socio
)
SELECT 
    s.id_socio, 
    p.nombre, 
    sm.total_multa
FROM socios_con_multas sm
INNER JOIN socio s ON sm.id_socio = s.id_socio
INNER JOIN persona p ON s.id_persona = p.id_persona
WHERE sm.total_multa > 5;


-- CTE 2: Listar libros con al menos 2 copias disponibles
WITH libros_con_copias AS (
    SELECT id_libro, COUNT(*) AS copias_disponibles
    FROM copia
    WHERE estado = 'disponible'
    GROUP BY id_libro
)
SELECT 
    l.titulo, 
    lc.copias_disponibles
FROM libros_con_copias lc
INNER JOIN libro l ON lc.id_libro = l.id_libro
WHERE lc.copias_disponibles >= 2;
-- ----------------------------------------------------------------
-- consulta normal:
SELECT 
    DISTINCT s.tipo_socio,
    (
        SELECT COUNT(p.id_prestamo)
        FROM prestamo p
        WHERE p.id_socio = s.id_socio
    ) AS total_prestamos
FROM socio s;
-- consulta cte

-- Consultas basica
SELECT 
    p.id_prestamo,
    p.fecha_prestamo,
    p.fecha_devolucion_esperada,
    s.id_socio,
    s.tipo_socio,
    pr.nombre,
    pr.apellido,
    pr.correo
FROM prestamo p
INNER JOIN socio s ON p.id_socio = s.id_socio
INNER JOIN persona pr ON s.id_persona = pr.id_persona
WHERE p.fecha_devolucion_esperada > CURRENT_DATE;




-- 🔍 Préstamos activos (aún no devueltos) y datos del socio
_
WITH PrestamosActivos AS (
    SELECT 
        p.id_prestamo,
        p.fecha_prestamo,
        p.fecha_devolucion_esperada,
        s.id_socio,
        pr.nombre,
        pr.apellido
    FROM prestamo p
    LEFT JOIN socio s ON p.id_socio = s.id_socio
    LEFT JOIN persona pr ON s.id_persona = pr.id_persona
    WHERE p.fecha_devolucion_esperada > NOW()::DATE
)

SELECT 
    id_prestamo, 
    nombre, 
    apellido, 
    fecha_prestamo
FROM PrestamosActivos;

---------------------------------------------------------------------------------------------------

-- 🔍 Libros en inventario y sus autores
EXPLAIN ANALYZE
WITH LibrosInventario AS (
    SELECT 
        l.titulo,
        i.cantidad,
        a.nombre AS autor
    FROM inventario i
    INNER JOIN libro l ON l.id_libro = i.id_libro
    INNER JOIN libro_autor la ON la.id_libro = l.id_libro
    INNER JOIN autor a ON a.id_autor = la.id_autor
    ORDER BY i.cantidad DESC
)
SELECT * FROM LibrosInventario LIMIT 100;

-- 🔍 Reservas activas con información del socio y libro
WITH ReservasActivas AS (
    SELECT 
        r.id_reserva,
        r.fecha_reserva,
        r.estado,
        pr.nombre,
        pr.apellido,
        pr.correo,
        l.titulo
    FROM reserva r
    INNER JOIN socio s ON r.id_socio = s.id_socio
    INNER JOIN persona pr ON s.id_persona = pr.id_persona
    LEFT JOIN copia c ON r.id_copia = c.id_copia
    LEFT JOIN libro l ON c.id_libro = l.id_libro
    WHERE r.estado = 'Activa'

)
SELECT * FROM ReservasActivas LIMIT 100;


EXPLAIN ANALYZE
WITH AuditoriaPorFecha AS (
    SELECT 
        id_auditoria,
        tabla_afectada,
        operacion,
        usuario,
        fecha,
        datos_anteriores,
        datos_nuevos
    FROM auditoria_general
    WHERE fecha BETWEEN '2025-05-01 21:07:05.89707' AND '2025-05-07 21:00:00'
)
SELECT * FROM AuditoriaPorFecha LIMIT 100;

-- ====================================================

-- 🔹 CTE 6: Registros de auditoría en un día específico y rango de horas
-- Explicación: Muestra todas las operaciones de auditoría de un día definido 
--              y dentro de un intervalo de horas específico.
EXPLAIN ANALYZE
WITH AuditoriaPorHora AS (
    SELECT 
        id_auditoria,
        tabla_afectada,
        operacion,
        usuario,
        fecha,
        datos_anteriores,
        datos_nuevos
    FROM auditoria_general
    WHERE fecha::DATE = '2025-05-01'
      AND fecha::TIME BETWEEN '21:00:00' AND '22:00:00'
)
SELECT * FROM AuditoriaPorHora LIMIT 100;
""