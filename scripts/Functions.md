```sql
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

-- 2. Trigger para cada tabla (Prestamo, Socio, Libro, Reserva, etc.)
CREATE TRIGGER trg_auditoria_prestamo
AFTER INSERT OR UPDATE OR DELETE ON prestamo
FOR EACH ROW EXECUTE FUNCTION fn_auditoria_general();

CREATE TRIGGER trg_auditoria_socio
AFTER INSERT OR UPDATE OR DELETE ON socio
FOR EACH ROW EXECUTE FUNCTION fn_auditoria_general();

CREATE TRIGGER trg_auditoria_libro
AFTER INSERT OR UPDATE OR DELETE ON libro
FOR EACH ROW EXECUTE FUNCTION fn_auditoria_general();

CREATE TRIGGER trg_auditoria_reserva
AFTER INSERT OR UPDATE OR DELETE ON reserva
FOR EACH ROW EXECUTE FUNCTION fn_auditoria_general();

CREATE TRIGGER trg_auditoria_multa
AFTER INSERT OR UPDATE OR DELETE ON multa
FOR EACH ROW EXECUTE FUNCTION fn_auditoria_general();

CREATE TRIGGER trg_auditoria_copia
AFTER INSERT OR UPDATE OR DELETE ON copia
FOR EACH ROW EXECUTE FUNCTION fn_auditoria_general();

CREATE TRIGGER trg_auditoria_historial_prestamo
AFTER INSERT OR UPDATE OR DELETE ON historial_prestamo
FOR EACH ROW EXECUTE FUNCTION fn_auditoria_general();

CREATE TRIGGER trg_auditoria_editorial
AFTER INSERT OR UPDATE OR DELETE ON editorial
FOR EACH ROW EXECUTE FUNCTION fn_auditoria_general();

CREATE TRIGGER trg_auditoria_categoria
AFTER INSERT OR UPDATE OR DELETE ON categoria
FOR EACH ROW EXECUTE FUNCTION fn_auditoria_general();

CREATE TRIGGER trg_auditoria_autor
AFTER INSERT OR UPDATE OR DELETE ON autor
FOR EACH ROW EXECUTE FUNCTION fn_auditoria_general();

Funciones:

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

--  Funciones para la tabla "libro"

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


-- Funciones para la tabla "copia”

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

```