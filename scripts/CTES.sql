```sql
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


```