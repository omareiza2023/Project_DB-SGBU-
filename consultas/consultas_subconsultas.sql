
-- CONSULTAS Y SUBCONSULTAS PARA EL PROYECTO DE BIBLIOTECA UNIVERSITARIA


-- 1. Tabla: libros
-- Consulta 1: Listar libros con su categoría
SELECT l.titulo, l.autor, c.nombre_categoria
FROM libros l
INNER JOIN categorias c ON l.id_categoria = c.id_categoria;

-- Consulta 2: Mostrar todos los libros y, si aplica, su editor
SELECT l.titulo, e.nombre_editorial
FROM libros l
LEFT JOIN editoriales e ON l.id_editorial = e.id_editorial;

-- Subconsulta 1: Libros con más de 3 copias
SELECT * FROM libros
WHERE id_libro IN (
    SELECT id_libro FROM copias
    GROUP BY id_libro
    HAVING COUNT(*) > 3
);

-- Subconsulta 2: Libros prestados al menos una vez
SELECT * FROM libros
WHERE id_libro IN (
    SELECT DISTINCT id_libro FROM prestamos
);

-- 2. Tabla: copias
-- Consulta 1: Copias y su ubicación
SELECT c.id_copia, c.estado, s.nombre_sucursal
FROM copias c
INNER JOIN sucursales s ON c.id_sucursal = s.id_sucursal;

-- Consulta 2: Todas las copias aunque no estén asignadas a sucursal
SELECT c.id_copia, s.nombre_sucursal
FROM copias c
LEFT JOIN sucursales s ON c.id_sucursal = s.id_sucursal;

-- Subconsulta 1: Copias dañadas
SELECT * FROM copias
WHERE estado = 'Dañado';

-- Subconsulta 2: Copias disponibles de un libro específico
SELECT * FROM copias
WHERE id_libro = (
    SELECT id_libro FROM libros WHERE titulo = 'Cien años de soledad'
);

-- 3. Tabla: socios
-- Consulta 1: Socios y su tipo (estudiante o profesor)
SELECT s.nombre, ts.tipo
FROM socios s
INNER JOIN tipo_socio ts ON s.id_tipo = ts.id_tipo;

-- Consulta 2: Todos los socios y si tienen préstamos
SELECT s.nombre, p.id_prestamo
FROM socios s
LEFT JOIN prestamos p ON s.id_socio = p.id_socio;

-- Subconsulta 1: Socios con más de 3 préstamos
SELECT * FROM socios
WHERE id_socio IN (
    SELECT id_socio FROM prestamos
    GROUP BY id_socio
    HAVING COUNT(*) > 3
);

-- Subconsulta 2: Socios sin préstamos
SELECT * FROM socios
WHERE id_socio NOT IN (
    SELECT DISTINCT id_socio FROM prestamos
);

-- 4. Tabla: prestamos
-- Consulta 1: Préstamos con nombre del socio y título del libro
SELECT p.id_prestamo, s.nombre, l.titulo
FROM prestamos p
INNER JOIN socios s ON p.id_socio = s.id_socio
INNER JOIN libros l ON p.id_libro = l.id_libro;

-- Consulta 2: Préstamos y sus devoluciones si existen
SELECT p.id_prestamo, d.fecha_devolucion
FROM prestamos p
LEFT JOIN devoluciones d ON p.id_prestamo = d.id_prestamo;

-- Subconsulta 1: Préstamos en los últimos 30 días
SELECT * FROM prestamos
WHERE fecha_prestamo >= CURRENT_DATE - INTERVAL '30 days';

-- Subconsulta 2: Préstamos de libros de una categoría específica
SELECT * FROM prestamos
WHERE id_libro IN (
    SELECT id_libro FROM libros WHERE id_categoria = 2
);

-- 5. Tabla: devoluciones
-- Consulta 1: Devoluciones con multa (INNER JOIN)
SELECT d.id_devolucion, m.monto
FROM devoluciones d
INNER JOIN multas m ON d.id_devolucion = m.id_devolucion;

-- Consulta 2: Todas las devoluciones, aunque no tengan multa
SELECT d.id_devolucion, m.monto
FROM devoluciones d
LEFT JOIN multas m ON d.id_devolucion = m.id_devolucion;

-- Subconsulta 1: Devoluciones fuera de plazo
SELECT * FROM devoluciones
WHERE fecha_devolucion > (
    SELECT fecha_limite FROM prestamos WHERE prestamos.id_prestamo = devoluciones.id_prestamo
);

-- Subconsulta 2: Devoluciones hechas por socios específicos
SELECT * FROM devoluciones
WHERE id_prestamo IN (
    SELECT id_prestamo FROM prestamos WHERE id_socio = 1
);

-- 6. Tabla: reservas
-- Consulta 1: Reservas con nombre del socio y título del libro
SELECT r.id_reserva, s.nombre, l.titulo
FROM reservas r
INNER JOIN socios s ON r.id_socio = s.id_socio
INNER JOIN libros l ON r.id_libro = l.id_libro;

-- Consulta 2: Reservas aunque el libro ya no esté disponible
SELECT r.id_reserva, l.titulo
FROM reservas r
LEFT JOIN libros l ON r.id_libro = l.id_libro;

-- Subconsulta 1: Reservas activas
SELECT * FROM reservas
WHERE estado = 'Activa';

-- Subconsulta 2: Libros más reservados
SELECT id_libro, COUNT(*) AS total_reservas
FROM reservas
GROUP BY id_libro
ORDER BY total_reservas DESC
LIMIT 5;

-- 7. Tabla: multas
-- Consulta 1: Multas con nombre del socio
SELECT m.monto, s.nombre
FROM multas m
INNER JOIN devoluciones d ON m.id_devolucion = d.id_devolucion
INNER JOIN prestamos p ON d.id_prestamo = p.id_prestamo
INNER JOIN socios s ON p.id_socio = s.id_socio;

-- Consulta 2: Multas aunque no haya devolución registrada
SELECT m.monto, d.id_devolucion
FROM multas m
RIGHT JOIN devoluciones d ON m.id_devolucion = d.id_devolucion;

-- Subconsulta 1: Multas mayores a $10.000
SELECT * FROM multas
WHERE monto > 10000;

-- Subconsulta 2: Total de multas por socio
SELECT p.id_socio, SUM(m.monto) AS total
FROM multas m
INNER JOIN devoluciones d ON m.id_devolucion = d.id_devolucion
INNER JOIN prestamos p ON d.id_prestamo = p.id_prestamo
GROUP BY p.id_socio;
