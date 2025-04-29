-- 1. Tabla: libros
-- Consulta 1: Listar libros con su categoría
SELECT l.titulo, c.nombre AS nombre_categoria
FROM libro l
INNER JOIN categoria c ON l.id_categoria = c.id_categoria;

-- Consulta 2: Mostrar todos los libros y, si aplica, su editorial
SELECT l.titulo, e.nombre AS nombre_editorial
FROM libro l
LEFT JOIN editorial e ON l.id_editorial = e.id_editorial;

-- Subconsulta 1: Libros con más de 3 copias
SELECT * FROM libro
WHERE id_libro IN (
    SELECT id_libro FROM copia
    GROUP BY id_libro
    HAVING COUNT(*) > 3
);

-- Subconsulta 2: Libros prestados al menos una vez
SELECT * FROM libro
WHERE id_libro IN (
    SELECT DISTINCT id_libro FROM prestamo
);

-- 2. Tabla: copias
-- Consulta 1: Copias y su ubicación
SELECT c.id_copia, c.estado, c.ubicacion
FROM copia c;

-- Consulta 2: Todas las copias aunque no estén asignadas a sucursal
-- (No se encuentra la tabla 'sucursal', por lo que esta consulta no se puede realizar correctamente con los datos actuales)

-- Subconsulta 1: Copias dañadas
SELECT * FROM copia
WHERE estado = 'Dañado';

-- Subconsulta 2: Copias disponibles de un libro específico
SELECT * FROM copia
WHERE id_libro = (
    SELECT id_libro FROM libro WHERE titulo = 'Cien años de soledad'
);

-- 3. Tabla: socios
-- Consulta 1: Socios y su tipo (estudiante o profesor)
SELECT p.nombre, s.tipo_socio
FROM socio s
INNER JOIN persona p ON s.id_persona = p.id_persona;

-- Consulta 2: Todos los socios y si tienen préstamos
SELECT p.nombre, pr.id_prestamo
FROM socio s
LEFT JOIN prestamo pr ON s.id_socio = pr.id_socio
INNER JOIN persona p ON s.id_persona = p.id_persona;

-- Subconsulta 1: Socios con más de 3 préstamos
SELECT * FROM socio
WHERE id_socio IN (
    SELECT id_socio FROM prestamo
    GROUP BY id_socio
    HAVING COUNT(*) > 3
);

-- Subconsulta 2: Socios sin préstamos
SELECT * FROM socio
WHERE id_socio NOT IN (
    SELECT DISTINCT id_socio FROM prestamo
);

-- 4. Tabla: prestamos
-- Consulta 1: Préstamos con nombre del socio y título del libro
SELECT pr.id_prestamo, p.nombre, l.titulo
FROM prestamo pr
INNER JOIN socio s ON pr.id_socio = s.id_socio
INNER JOIN copia c ON pr.id_copia = c.id_copia
INNER JOIN libro l ON c.id_libro = l.id_libro
INNER JOIN persona p ON s.id_persona = p.id_persona;

-- Consulta 2: Préstamos y sus devoluciones si existen
SELECT pr.id_prestamo, d.fecha_real_devolucion
FROM prestamo pr
LEFT JOIN devolucion d ON pr.id_prestamo = d.id_prestamo;

-- Subconsulta 1: Préstamos en los últimos 30 días
SELECT * FROM prestamo
WHERE fecha_prestamo >= CURRENT_DATE - INTERVAL '30 days';

-- Subconsulta 2: Préstamos de libros de una categoría específica
SELECT * FROM prestamo
WHERE id_copia IN (
    SELECT id_copia FROM copia WHERE id_libro IN (
        SELECT id_libro FROM libro WHERE id_categoria = 2
    )
);

-- 5. Tabla: devoluciones
-- Consulta 1: Devoluciones con multa (INNER JOIN)
SELECT d.id_devolucion, m.monto
FROM devolucion d
INNER JOIN multa m ON d.id_devolucion = m.id_devolucion;

-- Consulta 2: Todas las devoluciones, aunque no tengan multa
SELECT d.id_devolucion, m.monto
FROM devolucion d
LEFT JOIN multa m ON d.id_devolucion = m.id_devolucion;

-- Subconsulta 1: Devoluciones fuera de plazo
SELECT * FROM devolucion
WHERE fecha_real_devolucion > (
    SELECT fecha_devolucion_esperada FROM prestamo WHERE prestamo.id_prestamo = devolucion.id_prestamo
);

-- Subconsulta 2: Devoluciones hechas por socios específicos
SELECT * FROM devolucion
WHERE id_prestamo IN (
    SELECT id_prestamo FROM prestamo WHERE id_socio = 1
);

-- 6. Tabla: reservas
-- Consulta 1: Reservas con nombre del socio y título del libro
SELECT r.id_reserva, p.nombre, l.titulo
FROM reserva r
INNER JOIN socio s ON r.id_socio = s.id_socio
INNER JOIN copia c ON r.id_copia = c.id_copia
INNER JOIN libro l ON c.id_libro = l.id_libro
INNER JOIN persona p ON s.id_persona = p.id_persona;

-- Consulta 2: Reservas aunque el libro ya no esté disponible
SELECT r.id_reserva, l.titulo
FROM reserva r
LEFT JOIN libro l ON r.id_libro = l.id_libro;

-- Subconsulta 1: Reservas activas
SELECT * FROM reserva
WHERE estado = 'Activa';

-- Subconsulta 2: Libros más reservados
SELECT id_libro, COUNT(*) AS total_reservas
FROM reserva
GROUP BY id_libro
ORDER BY total_reservas DESC
LIMIT 5;

-- 7. Tabla: multas
-- Consulta 1: Multas con nombre del socio
SELECT m.monto, p.nombre
FROM multa m
INNER JOIN devolucion d ON m.id_devolucion = d.id_devolucion
INNER JOIN prestamo pr ON d.id_prestamo = pr.id_prestamo
INNER JOIN socio s ON pr.id_socio = s.id_socio
INNER JOIN persona p ON s.id_persona = p.id_persona;

-- Consulta 2: Multas aunque no haya devolución registrada
SELECT m.monto, d.id_devolucion
FROM multa m
RIGHT JOIN devolucion d ON m.id_devolucion = d.id_devolucion;

-- Subconsulta 1: Multas mayores a $10.000
SELECT * FROM multa
WHERE monto > 10000;

-- Subconsulta 2: Total de multas por socio
SELECT pr.id_socio, SUM(m.monto) AS total
FROM multa m
INNER JOIN devolucion d ON m.id_devolucion = d.id_devolucion
INNER JOIN prestamo pr ON d.id_prestamo = pr.id_prestamo
GROUP BY pr.id_socio;
