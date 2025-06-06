
-- 1. Función general para auditoría
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

-- 2. Trigger para cada tabla (Prestamo, Socio, Libro, Reserva, etc...)

--Auditoría Préstamo
-- Registra auditoría cuando se crea, actualiza o elimina un préstamo.
CREATE TRIGGER trg_auditoria_prestamo
AFTER INSERT OR UPDATE OR DELETE ON prestamo
FOR EACH ROW EXECUTE FUNCTION fn_auditoria_general();

--Auditoría Socio
-- Guarda cambios realizados sobre los datos de un socio.
CREATE TRIGGER trg_auditoria_socio
AFTER INSERT OR UPDATE OR DELETE ON socio
FOR EACH ROW EXECUTE FUNCTION fn_auditoria_general();

--Auditoría Libro
-- Monitorea inserciones, modificaciones o eliminaciones de libros.
CREATE TRIGGER trg_auditoria_libro
AFTER INSERT OR UPDATE OR DELETE ON libro
FOR EACH ROW EXECUTE FUNCTION fn_auditoria_general();

-- Auditoría Reserva
-- Registra actividades sobre reservas hechas por los socios.
CREATE TRIGGER trg_auditoria_reserva
AFTER INSERT OR UPDATE OR DELETE ON reserva
FOR EACH ROW EXECUTE FUNCTION fn_auditoria_general();

--Auditoría Multa
-- Audita operaciones sobre multas asignadas.
CREATE TRIGGER trg_auditoria_multa
AFTER INSERT OR UPDATE OR DELETE ON multa
FOR EACH ROW EXECUTE FUNCTION fn_auditoria_general();

-- Auditoría Copia
-- Detecta cambios en copias físicas de los libros.
CREATE TRIGGER trg_auditoria_copia
AFTER INSERT OR UPDATE OR DELETE ON copia
FOR EACH ROW EXECUTE FUNCTION fn_auditoria_general();

-- Auditoría Historial de Préstamo
-- Guarda alteraciones en el historial de préstamos.
CREATE TRIGGER trg_auditoria_historial_prestamo
AFTER INSERT OR UPDATE OR DELETE ON historial_prestamo
FOR EACH ROW EXECUTE FUNCTION fn_auditoria_general();

-- Auditoría Editorial
-- Audita registros de editoriales agregadas o modificadas.
CREATE TRIGGER trg_auditoria_editorial
AFTER INSERT OR UPDATE OR DELETE ON editorial
FOR EACH ROW EXECUTE FUNCTION fn_auditoria_general();

-- Auditoría Categoría
-- Registra operaciones sobre categorías de libros.
CREATE TRIGGER trg_auditoria_categoria
AFTER INSERT OR UPDATE OR DELETE ON categoria
FOR EACH ROW EXECUTE FUNCTION fn_auditoria_general();

-- Auditoría Autor
-- Monitorea inserciones, ediciones o eliminaciones de autores.
CREATE TRIGGER trg_auditoria_autor
AFTER INSERT OR UPDATE OR DELETE ON autor
FOR EACH ROW EXECUTE FUNCTION fn_auditoria_general();

-- Auditoría Devolución
-- Guarda auditoría de devoluciones de libros.
CREATE TRIGGER trg_auditoria_devolucion
AFTER INSERT OR UPDATE OR DELETE ON devolucion
FOR EACH ROW EXECUTE FUNCTION fn_auditoria_general();

-- Auditoría Libro-Autor
-- Registra cambios en la relación entre libros y autores.
CREATE TRIGGER trg_auditoria_libro_autor
AFTER INSERT OR UPDATE OR DELETE ON libro_autor
FOR EACH ROW EXECUTE FUNCTION fn_auditoria_general();

-- Auditoría Inventario
-- Monitorea cambios en el stock de libros (inventario).
CREATE TRIGGER trg_auditoria_inventario
AFTER INSERT OR UPDATE OR DELETE ON inventario
FOR EACH ROW EXECUTE FUNCTION fn_auditoria_general();

-- Auditoría Personal Biblioteca
-- Audita acciones sobre los registros del personal de biblioteca.
CREATE TRIGGER trg_auditoria_personal_biblioteca
AFTER INSERT OR UPDATE OR DELETE ON personal_biblioteca
FOR EACH ROW EXECUTE FUNCTION fn_auditoria_general();


                    ______
  __  __   _    _   _   _   _____   ______ _________     ___       __   _     _  _______     ________
 |  \/  | | |  | | | \ | | | ____| | ____| |   __   |    |  |     |  | |  \  | | |  ___ \   |  ____  |
 |      | | |  | | |  \| | | |___  | |     |  |  |  |    |  |     |  | |   \ | | | |   | |  | |    | |
 | |\/| | | |  | | |     | |  ___| | |     |  |__|  |    |  |     |  | |       | | |   | |  | |____| |
 | |  | | | |__| | | |\  | | |___  | |___  |   ___  |    |  |____ |  | |  |\   | | |___| |  | ______ |
 |_|  |_|  \____/  |_| \_| |_____| |_____| |__|   |_|    |_______||__| |__| \__| |_______/  |_|    |_|
