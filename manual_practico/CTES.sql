-- 1. CTE 1: Listar socios con multas pendientes mayores a $5
WITH socios_con_multas AS (
    SELECT pr.id_socio, SUM(m.monto) AS total_multa
    FROM multa m
    INNER JOIN prestamo pr ON m.id_prestamo = pr.id_prestamo
    WHERE m.estado = 'Pendiente'
    GROUP BY pr.id_socio
)
SELECT 
    s.id_socio, 
    p.nombre, 
    sm.total_multa
FROM socios_con_multas sm
INNER JOIN socio s ON sm.id_socio = s.id_socio
INNER JOIN persona p ON s.id_persona = p.id_persona
WHERE sm.total_multa > 5;

-- Usamos el CTE 'socios_con_multas' para agrupar las multas pendientes por socio, y luego listamos aquellos socios cuyo total de multa es mayor a 5.

-- 2. CTE 2: Listar libros con al menos 2 copias disponibles
WITH libros_con_copias AS (
    SELECT c.id_libro, COUNT(*) AS copias_disponibles
    FROM copia c
    WHERE c.estado = 'Disponible'
    GROUP BY c.id_libro
)
SELECT 
    l.titulo, 
    lc.copias_disponibles
FROM libros_con_copias lc
INNER JOIN libro l ON lc.id_libro = l.id_libro
WHERE lc.copias_disponibles >= 2;
-- Usamos el CTE 'libros_con_copias' para contar cuántas copias disponibles tiene cada libro y luego listamos aquellos libros que tienen al menos 2 copias disponibles.
