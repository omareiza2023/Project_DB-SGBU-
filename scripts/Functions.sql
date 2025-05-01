-- Funciones para la tabla "persona"

-- 1. Función para obtener el correo de una persona por su ID
CREATE OR REPLACE FUNCTION obtener_correo_persona(id INT)
RETURNS VARCHAR(100) AS $$
BEGIN
    RETURN (SELECT correo FROM persona WHERE id_persona = id);
END;
$$ LANGUAGE plpgsql;

-- 2. Función para verificar si una persona existe por su correo
CREATE OR REPLACE FUNCTION persona_existe_por_correo(correo VARCHAR)
RETURNS BOOLEAN AS $$
BEGIN
    RETURN EXISTS (SELECT 1 FROM persona WHERE correo = correo);
END;
$$ LANGUAGE plpgsql;


-- Funciones para la tabla "socio"

-- 1. Función para calcular el total de préstamos activos de un socio
CREATE OR REPLACE FUNCTION calcular_prestamos_activos(id_socio INT)
RETURNS INTEGER AS $$
BEGIN
    RETURN (SELECT COUNT(*) 
            FROM prestamo 
            WHERE id_socio = id_socio AND fecha_devolucion_esperada >= CURRENT_DATE);
END;
$$ LANGUAGE plpgsql;

-- 2. Función para verificar si un socio tiene más de X préstamos activos
CREATE OR REPLACE FUNCTION socio_tiene_prestamos_activos_mayores_a(id_socio INT, limite INT)
RETURNS BOOLEAN AS $$
BEGIN
    RETURN (SELECT COUNT(*) 
            FROM prestamo 
            WHERE id_socio = id_socio AND fecha_devolucion_esperada >= CURRENT_DATE) > limite;
END;
$$ LANGUAGE plpgsql;

-- Funciones para la tabla "libro"

-- 1. Función para calcular la cantidad de días de retraso de un libro
CREATE OR REPLACE FUNCTION calcular_dias_retraso(id_prestamo INT)
RETURNS INTEGER AS $$
DECLARE
    dias_retraso INTEGER;
BEGIN
    SELECT EXTRACT(DAY FROM CURRENT_DATE - p.fecha_devolucion_esperada)
    INTO dias_retraso
    FROM prestamo p
    WHERE p.id_prestamo = id_prestamo;
    
    IF dias_retraso < 0 THEN
        RETURN 0;  -- Si no está retrasado, se devuelve 0
    ELSE
        RETURN dias_retraso;
    END IF;
END;
$$ LANGUAGE plpgsql;

-- 2. Función para obtener la categoría de un libro por su ID
CREATE OR REPLACE FUNCTION obtener_categoria_libro(id_libro INT)
RETURNS VARCHAR AS $$
BEGIN
    RETURN (SELECT c.nombre 
            FROM libro l
            JOIN categoria c ON l.id_categoria = c.id_categoria
            WHERE l.id_libro = id_libro);
END;
$$ LANGUAGE plpgsql;


-- Funciones para la tabla "reserva"

-- 1. Función para calcular el tiempo restante hasta la expiración de una reserva
CREATE OR REPLACE FUNCTION calcular_tiempo_restante_reserva(id_reserva INT)
RETURNS INTEGER AS $$
DECLARE
    tiempo_restante INTEGER;
BEGIN
    SELECT EXTRACT(DAY FROM r.fecha_reserva - CURRENT_DATE)
    INTO tiempo_restante
    FROM reserva r
    WHERE r.id_reserva = id_reserva;

    IF tiempo_restante < 0 THEN
        RETURN 0; -- Si la reserva ya expiró, retornamos 0
    ELSE
        RETURN tiempo_restante;
    END IF;
END;
$$ LANGUAGE plpgsql;

-- 2. Función para obtener el estado de una copia en la reserva
CREATE OR REPLACE FUNCTION obtener_estado_copia_reserva(id_reserva INT)
RETURNS VARCHAR AS $$
BEGIN
    RETURN (SELECT c.estado
            FROM reserva r
            JOIN copia c ON r.id_copia = c.id_copia
            WHERE r.id_reserva = id_reserva);
END;
$$ LANGUAGE plpgsql;

-- Funciones para la tabla "multa"

-- 1. Función para calcular el monto de una multa por retraso
CREATE OR REPLACE FUNCTION calcular_multa_por_retraso(id_prestamo INT, tarifa_diaria DECIMAL)
RETURNS DECIMAL AS $$
DECLARE
    dias_retraso INTEGER;
    monto DECIMAL;
BEGIN
    -- Calcular el retraso en días
    SELECT EXTRACT(DAY FROM CURRENT_DATE - p.fecha_devolucion_esperada)
    INTO dias_retraso
    FROM prestamo p
    WHERE p.id_prestamo = id_prestamo;

    -- Si el retraso es mayor a 0, calcular la multa
    IF dias_retraso > 0 THEN
        monto := dias_retraso * tarifa_diaria;
        RETURN monto;
    ELSE
        RETURN 0;  -- Si no hay retraso, no hay multa
    END IF;
END;
$$ LANGUAGE plpgsql;

-- 2. Función para obtener las multas acumuladas de un socio
CREATE OR REPLACE FUNCTION obtener_multas_acumuladas_socio(id_socio INT)
RETURNS DECIMAL AS $$
BEGIN
    RETURN (SELECT SUM(m.monto)
            FROM multa m
            WHERE m.id_socio = id_socio AND m.estado = 'Pendiente');
END;
$$ LANGUAGE plpgsql;


-- Funciones para la tabla "copia"

-- 1. Función para verificar si una copia está dañada
CREATE OR REPLACE FUNCTION verificar_copia_danada(id_copia INT)
RETURNS BOOLEAN AS $$
BEGIN
    RETURN EXISTS (SELECT 1 FROM copia WHERE id_copia = id_copia AND estado = 'Dañado');
END;
$$ LANGUAGE plpgsql;

-- 2. Función para verificar si un libro tiene copias disponibles
CREATE OR REPLACE FUNCTION libro_tiene_copias_disponibles(id_libro INT)
RETURNS BOOLEAN AS $$
BEGIN
    RETURN EXISTS (SELECT 1
                   FROM copia
                   WHERE id_libro = id_libro AND estado = 'Disponible');
END;
$$ LANGUAGE plpgsql;


-- Funciones para la tabla "historial_prestamo"

-- 1. Función para obtener el historial completo de un socio
CREATE OR REPLACE FUNCTION obtener_historial_completo(id_socio INT)
RETURNS TABLE(id_historial INT, id_copia INT, fecha_prestamo DATE, fecha_devolucion DATE) AS $$
BEGIN
    RETURN QUERY
    SELECT hp.id_historial, hp.id_copia, hp.fecha_prestamo, hp.fecha_devolucion
    FROM historial_prestamo hp
    WHERE hp.id_socio = id_socio;
END;
$$ LANGUAGE plpgsql;

-- 2. Función para obtener el número total de préstamos de un libro
CREATE OR REPLACE FUNCTION contar_prestamos_libro(id_libro INT)
RETURNS INTEGER AS $$
BEGIN
    RETURN (SELECT COUNT(*) FROM historial_prestamo WHERE id_copia IN (SELECT id_copia FROM copia WHERE id_libro = id_libro));
END;
$$ LANGUAGE plpgsql;

--Función general para auditoría
CREATE OR REPLACE FUNCTION fn_auditoria_general()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
DECLARE
    v_operacion TEXT;
    v_datos_anteriores JSONB;
    v_datos_nuevos JSONB;
BEGIN
    -- Determinar la operación realizada
    IF TG_OP = 'INSERT' THEN
        v_operacion := 'INSERT';
        v_datos_anteriores := NULL;
        v_datos_nuevos := to_jsonb(NEW);
    ELSIF TG_OP = 'UPDATE' THEN
        v_operacion := 'UPDATE';
        v_datos_anteriores := to_jsonb(OLD);
        v_datos_nuevos := to_jsonb(NEW);
    ELSIF TG_OP = 'DELETE' THEN
        v_operacion := 'DELETE';
        v_datos_anteriores := to_jsonb(OLD);
        v_datos_nuevos := NULL;
    END IF;

    -- Insertar el registro de auditoría
    INSERT INTO auditoria_general(tabla_afectada, operacion, usuario, datos_anteriores, datos_nuevos)
    VALUES (TG_TABLE_NAME, v_operacion, current_user, v_datos_anteriores, v_datos_nuevos);

    -- Si la operación es una inserción en reserva, insertar en historial_prestamo
    IF TG_OP = 'INSERT' AND TG_TABLE_NAME = 'reserva' THEN
        INSERT INTO historial_prestamo(id_socio, id_copia, fecha_prestamo, fecha_devolucion, observaciones)
        VALUES (NEW.id_socio, NEW.id_copia, NEW.fecha_reserva, NULL, 'Reserva creada automáticamente');
    END IF;

    RETURN NULL;
END;
$$;

-- generar multas por retraso:

CREATE OR REPLACE FUNCTION generar_multas_por_retraso()
RETURNS VOID AS $$
DECLARE
    prestamo_rec RECORD;
    dias_retraso INT;
BEGIN
    FOR prestamo_rec IN
        SELECT p.id_prestamo, p.id_socio, p.fecha_devolucion_esperada
        FROM prestamo p
        LEFT JOIN devolucion d ON p.id_prestamo = d.id_prestamo
        WHERE d.id_prestamo IS NULL
    LOOP
        dias_retraso := EXTRACT(DAY FROM CURRENT_DATE - prestamo_rec.fecha_devolucion_esperada);
        
        IF dias_retraso > 5 THEN
            -- Verifica si ya existe una multa para ese préstamo
            IF NOT EXISTS (
                SELECT 1 FROM multa
                WHERE id_socio = prestamo_rec.id_socio
                  AND motivo = 'Devolución tardía'
                  AND fecha = CURRENT_DATE
            ) THEN
                INSERT INTO multa (id_socio, monto, motivo, fecha, estado)
                VALUES (prestamo_rec.id_socio, dias_retraso * 1.00, 'Devolución tardía', CURRENT_DATE, 'Pendiente');
            END IF;
        END IF;
    END LOOP;
END;
$$ LANGUAGE plpgsql;


-- elimiar prestamos y multas al mismo tiempo:

CREATE OR REPLACE FUNCTION eliminar_multa_y_prestamo(prestamo_id INT)
RETURNS VOID AS $$
DECLARE
    multa_rec RECORD;
BEGIN
    -- Eliminar la multa asociada al préstamo
    FOR multa_rec IN
        SELECT m.id_multa, m.id_prestamo
        FROM multa m
        WHERE m.id_prestamo = prestamo_id  -- Usamos la nueva variable prestamo_id
    LOOP
        -- Eliminar la multa
        DELETE FROM multa WHERE id_multa = multa_rec.id_multa;
    END LOOP;

    -- Eliminar el préstamo
    DELETE FROM prestamo WHERE id_prestamo = prestamo_id; -- Usamos la nueva variable prestamo_id
       
END;
$$ LANGUAGE plpgsql;