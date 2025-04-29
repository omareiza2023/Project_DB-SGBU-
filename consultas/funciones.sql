-- Usar la función obtener_correo_persona
SELECT obtener_correo_persona(1) AS correo_persona;

-- Usar la función persona_existe_por_correo
SELECT persona_existe_por_correo('juan.perez@example.com') AS existe_persona;

-- Usar la función calcular_prestamos_activos
SELECT calcular_prestamos_activos(1) AS prestamos_activos;

-- Usar la función socio_tiene_prestamos_activos_mayores_a
SELECT socio_tiene_prestamos_activos_mayores_a(1, 3) AS socio_con_muchos_prestamos;

-- Usar la función calcular_dias_retraso
SELECT calcular_dias_retraso(5) AS dias_retraso;

-- Usar la función obtener_categoria_libro
SELECT obtener_categoria_libro(2) AS categoria_libro;

-- Usar la función calcular_tiempo_restante_reserva
SELECT calcular_tiempo_restante_reserva(1) AS tiempo_restante_reserva;

-- Usar la función obtener_estado_copia_reserva
SELECT obtener_estado_copia_reserva(1) AS estado_copia_reserva;

-- Usar la función calcular_multa_por_retraso
SELECT calcular_multa_por_retraso(5, 500) AS multa_retraso;

-- Usar la función obtener_multas_acumuladas_socio
SELECT obtener_multas_acumuladas_socio(1) AS multas_pendientes_socio;

-- Usar la función verificar_copia_danada
SELECT verificar_copia_danada(2) AS copia_danada;

-- Usar la función libro_tiene_copias_disponibles
SELECT libro_tiene_copias_disponibles(3) AS copias_disponibles;

-- Usar la función obtener_historial_completo
SELECT * FROM obtener_historial_completo(1);

-- Usar la función contar_prestamos_libro
SELECT contar_prestamos_libro(2) AS total_prestamos_libro;

