
-- 1. Libros actualmente prestados
-- Muestra todos los libros que han sido prestados y aún no devueltos.
SELECT * FROM vista_libros_prestados;

-- 2. Socios con multas pendientes
-- Lista los socios que tienen multas pendientes de pago.
SELECT * FROM vista_socios_con_multas_pendientes;

-- 3. Copias disponibles por título
-- Indica cuántas copias disponibles hay por cada libro.
SELECT * FROM vista_copias_disponibles_por_titulo;

-- 4. Reservas activas de copias
-- Muestra las reservas que actualmente están activas.
SELECT * FROM vista_reservas_activas;

-- 5. Historial de préstamos por socio
-- Detalla los préstamos históricos realizados por cada socio.
SELECT * FROM vista_historial_prestamos_por_socio;
