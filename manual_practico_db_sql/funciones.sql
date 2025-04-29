-- Usar la función obtener_correo_persona
SELECT obtener_correo_persona(1) AS correo_persona;
-- Esta función debe devolver el correo de la persona con id_persona = 1.

-- Usar la función persona_existe_por_correo
SELECT persona_existe_por_correo('juan.perez@example.com') AS existe_persona;
-- Esta función debe verificar si una persona con el correo 'juan.perez@example.com' existe en la base de datos.

-- Usar la función calcular_prestamos_activos
SELECT calcular_prestamos_activos(1) AS prestamos_activos;
-- Esta función debe devolver el número de préstamos activos del socio con id_socio = 1.

-- Usar la función socio_tiene_prestamos_activos_mayores_a
SELECT socio_tiene_prestamos_activos_mayores_a(1, 3) AS socio_con_muchos_prestamos;
-- Esta función debe devolver un valor booleano si el socio con id_socio = 1 tiene más de 3 préstamos activos.

-- Usar la función calcular_dias_retraso
SELECT calcular_dias_retraso(5) AS dias_retraso;
-- Esta función debe calcular los días de retraso para el préstamo con id_prestamo = 5.

-- Usar la función obtener_categoria_libro
SELECT obtener_categoria_libro(2) AS categoria_libro;
-- Esta función debe devolver la categoría del libro con id_libro = 2.

-- Usar la función calcular_tiempo_restante_reserva
SELECT calcular_tiempo_restante_reserva(1) AS tiempo_restante_reserva;
-- Esta función debe calcular el tiempo restante para la reserva con id_reserva = 1.

-- Usar la función obtener_estado_copia_reserva
SELECT obtener_estado_copia_reserva(1) AS estado_copia_reserva;
-- Esta función debe devolver el estado de la copia asociada a la reserva con id_reserva = 1.

-- Usar la función calcular_multa_por_retraso
SELECT calcular_multa_por_retraso(5, 500) AS multa_retraso;
-- Esta función debe calcular la multa por retraso para el préstamo con id_prestamo = 5 y un monto base de 500.

-- Usar la función obtener_multas_acumuladas_socio
SELECT obtener_multas_acumuladas_socio(1) AS multas_pendientes_socio;
-- Esta función debe devolver la cantidad total de multas pendientes del socio con id_socio = 1.

-- Usar la función verificar_copia_danada
SELECT verificar_copia_danada(2) AS copia_danada;
-- Esta función debe verificar si la copia con id_copia = 2 está dañada.

-- Usar la función libro_tiene_copias_disponibles
SELECT libro_tiene_copias_disponibles(3) AS copias_disponibles;
-- Esta función debe devolver un valor booleano si el libro con id_libro = 3 tiene copias disponibles.

-- Usar la función obtener_historial_completo
SELECT * FROM obtener_historial_completo(1);
-- Esta función debe devolver el historial completo de préstamos y devoluciones del socio con id_socio = 1.

-- Usar la función contar_prestamos_libro
SELECT contar_prestamos_libro(2) AS total_prestamos_libro;
-- Esta función debe contar el número total de préstamos del libro con id_libro = 2.
