```sql
-- 1. Vista: Libros actualmente prestados
CREATE OR REPLACE VIEW vista_libros_prestados AS
SELECT 
    p.id_prestamo,
    l.titulo AS titulo_libro,
    c.codigo_barra,
    s.id_socio,
    pe.nombre || ' ' || pe.apellido AS nombre_socio,
    p.fecha_prestamo,
    p.fecha_devolucion_esperada
FROM 
    prestamo p
JOIN copia c ON p.id_copia = c.id_copia
JOIN libro l ON c.id_libro = l.id_libro
JOIN socio s ON p.id_socio = s.id_socio
JOIN persona pe ON s.id_persona = pe.id_persona
WHERE 
    NOT EXISTS (
        SELECT 1 FROM devolucion d WHERE d.id_prestamo = p.id_prestamo
    );

-- 2. Vista: Socios con multas pendientes
CREATE OR REPLACE VIEW vista_socios_con_multas_pendientes AS
SELECT 
    m.id_multa,
    s.id_socio,
    pe.nombre || ' ' || pe.apellido AS nombre_socio,
    m.monto,
    m.motivo,
    m.fecha
FROM 
    multa m
JOIN socio s ON m.id_socio = s.id_socio
JOIN persona pe ON s.id_persona = pe.id_persona
WHERE 
    m.estado = 'Pendiente';

-- 3. Vista: Copias disponibles por título
CREATE OR REPLACE VIEW vista_copias_disponibles_por_titulo AS
SELECT 
    l.titulo,
    COUNT(c.id_copia) AS cantidad_disponible
FROM 
    copia c
JOIN libro l ON c.id_libro = l.id_libro
WHERE 
    c.estado = 'Disponible'
GROUP BY 
    l.titulo
ORDER BY 
    cantidad_disponible DESC;

-- 4. Vista: Reservas activas de copias
CREATE OR REPLACE VIEW vista_reservas_activas AS
SELECT 
    r.id_reserva,
    l.titulo AS titulo_libro,
    c.codigo_barra,
    s.id_socio,
    pe.nombre || ' ' || pe.apellido AS nombre_socio,
    r.fecha_reserva
FROM 
    reserva r
JOIN copia c ON r.id_copia = c.id_copia
JOIN libro l ON c.id_libro = l.id_libro
JOIN socio s ON r.id_socio = s.id_socio
JOIN persona pe ON s.id_persona = pe.id_persona
WHERE 
    r.estado = 'Activa';

-- 5. Vista: Historial de préstamos por socio
CREATE OR REPLACE VIEW vista_historial_prestamos_por_socio AS
SELECT 
    hp.id_historial,
    s.id_socio,
    pe.nombre || ' ' || pe.apellido AS nombre_socio,
    l.titulo AS titulo_libro,
    hp.fecha_prestamo,
    hp.fecha_devolucion,
    hp.observaciones
FROM 
    historial_prestamo hp
JOIN socio s ON hp.id_socio = s.id_socio
JOIN persona pe ON s.id_persona = pe.id_persona
JOIN copia c ON hp.id_copia = c.id_copia
JOIN libro l ON c.id_libro = l.id_libro
ORDER BY 
    hp.fecha_prestamo DESC;


```