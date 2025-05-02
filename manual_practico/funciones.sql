-- Ejemplo de uso de la función para contar préstamos activos de un socio
SELECT contar_prestamos_activos(1);  -- 1 es el ID del socio

-- Ejemplo de uso de la función para calcular el número de días de retraso de un libro en préstamo
SELECT calcular_dias_retraso(123);  -- 123 es el ID del préstamo

-- Ejemplo de uso de la función para calcular el tiempo restante hasta la expiración de una reserva
SELECT calcular_tiempo_restante_reserva(5); -- 5 es el ID de la reserva

-- Ejemplo de uso de la función para calcular el monto de una multa por retraso
SELECT calcular_multa_por_retraso(789, 1.50);  -- 789 es el ID del préstamo y 1.50 es la tarifa diaria

-- Ejemplo de uso de la función para generar multas por retraso
-- Esta función debe ejecutarse periódicamente, generalmente a través de un cron job o una ejecución programada.
SELECT generar_multas_por_retraso();

----------------------------------------------------------------------------------------
-- funciones secundarias
-- Ejemplo de uso de la función para obtener el correo de una persona por su ID
SELECT obtener_correo_persona(1);  -- 1 es el ID de la persona

-- Ejemplo de uso de la función para verificar si una persona existe por su correo
SELECT persona_existe_por_correo('ejemplo@dominio.com');  -- 'ejemplo@dominio.com' es el correo a verificar

-- Ejemplo de uso de la función para obtener la categoría de un libro por su ID
SELECT obtener_categoria_libro(101);  -- 101 es el ID del libro

-- Ejemplo de uso de la función para obtener el estado de una copia en la reserva
SELECT obtener_estado_copia_reserva(202);  -- 202 es el ID de la reserva

-- Ejemplo de uso de la función para verificar si una copia está dañada
SELECT verificar_copia_danada(303);  -- 303 es el ID de la copia

-- Ejemplo de uso de la función para verificar si un libro tiene copias disponibles
SELECT libro_tiene_copias_disponibles(404);  -- 404 es el ID del libro

-- Ejemplo de uso de la función para obtener el historial completo de un socio
SELECT * FROM obtener_historial_completo(1);  -- 1 es el ID del socio

-- Ejemplo de uso de la función para contar el número total de préstamos de un libro
SELECT contar_prestamos_libro(101);  -- 101 es el ID del libro

