
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


-- 🔍 Total de préstamos por cada tipo de socio
EXPLAIN ANALYZE
WITH TotalPrestamos AS (
    SELECT 
        s.tipo_socio,
        COUNT(p.id_prestamo) AS total_prestamos
    FROM prestamo p
    INNER JOIN socio s ON p.id_socio = s.id_socio
    GROUP BY s.tipo_socio
)
SELECT * FROM TotalPrestamos;

-- 🔍 Préstamos activos (aún no devueltos) y datos del socio
EXPLAIN ANALYZE
WITH PrestamosActivos AS (
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
    LEFT JOIN socio s ON p.id_socio = s.id_socio
    LEFT JOIN persona pr ON s.id_persona = pr.id_persona
    WHERE p.fecha_devolucion_esperada > NOW()::DATE
)
SELECT * FROM PrestamosActivos;

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