-- Consultar todos los libros actualmente prestados usando la vista vista_libros_prestados
SELECT * FROM vista_libros_prestados;

-- Consultar los libros prestados filtrados por un socio específico usando la vista vista_libros_prestados
SELECT * FROM vista_libros_prestados WHERE id_socio = 3;

-- Consultar todos los socios que tienen multas pendientes usando la vista vista_socios_con_multas_pendientes
SELECT * FROM vista_socios_con_multas_pendientes;

-- Consultar las multas pendientes mayores a $10.000 usando la vista vista_socios_con_multas_pendientes
SELECT * FROM vista_socios_con_multas_pendientes WHERE monto > 10000;

-- Consultar el número de copias disponibles por título usando la vista vista_copias_disponibles_por_titulo
SELECT * FROM vista_copias_disponibles_por_titulo;

-- Consultar solo los títulos que tienen más de 5 copias disponibles usando la vista vista_copias_disponibles_por_titulo
SELECT * FROM vista_copias_disponibles_por_titulo WHERE cantidad_disponible > 5;

-- Consultar todas las reservas activas usando la vista vista_reservas_activas
SELECT * FROM vista_reservas_activas;

-- Consultar las reservas activas realizadas en los últimos 7 días usando la vista vista_reservas_activas
SELECT * FROM vista_reservas_activas 
WHERE fecha_reserva >= CURRENT_DATE - INTERVAL '7 days';

-- Consultar todo el historial de préstamos de todos los socios usando la vista vista_historial_prestamos_por_socio
SELECT * FROM vista_historial_prestamos_por_socio;

-- Consultar el historial de préstamos de un socio específico (por ejemplo socio con ID 5) usando la vista vista_historial_prestamos_por_socio
SELECT * FROM vista_historial_prestamos_por_socio WHERE id_socio = 5;
