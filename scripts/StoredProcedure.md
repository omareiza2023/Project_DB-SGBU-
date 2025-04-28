```sql
-- 1. Tabla persona
CREATE OR REPLACE PROCEDURE sp_insert_persona(
    p_nombre VARCHAR,
    p_apellido VARCHAR,
    p_correo VARCHAR,
    p_telefono VARCHAR,
    p_direccion TEXT
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO persona(nombre, apellido, correo, telefono, direccion)
    VALUES (p_nombre, p_apellido, p_correo, p_telefono, p_direccion);
END;
$$;

CREATE OR REPLACE PROCEDURE sp_update_persona(
    p_id INT,
    p_nombre VARCHAR,
    p_apellido VARCHAR,
    p_correo VARCHAR,
    p_telefono VARCHAR,
    p_direccion TEXT
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE persona
    SET nombre = p_nombre,
        apellido = p_apellido,
        correo = p_correo,
        telefono = p_telefono,
        direccion = p_direccion
    WHERE id_persona = p_id;
END;
$$;

CREATE OR REPLACE PROCEDURE sp_delete_persona(p_id INT)
LANGUAGE plpgsql
AS $$
BEGIN
    DELETE FROM persona WHERE id_persona = p_id;
END;
$$;

-- 2. Tabla socio

CREATE OR REPLACE PROCEDURE sp_insert_socio(
    p_id_persona INT,
    p_tipo_socio VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO socio(id_persona, tipo_socio)
    VALUES (p_id_persona, p_tipo_socio);
END;
$$;

CREATE OR REPLACE PROCEDURE sp_update_socio(
    p_id_socio INT,
    p_tipo_socio VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE socio
    SET tipo_socio = p_tipo_socio
    WHERE id_socio = p_id_socio;
END;
$$;

CREATE OR REPLACE PROCEDURE sp_delete_socio(p_id_socio INT)
LANGUAGE plpgsql
AS $$
BEGIN
    DELETE FROM socio WHERE id_socio = p_id_socio;
END;
$$;

-- 3. Tabla personal_biblioteca

CREATE OR REPLACE PROCEDURE sp_insert_personal_biblioteca(
    p_id_persona INT,
    p_rol VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO personal_biblioteca(id_persona, rol)
    VALUES (p_id_persona, p_rol);
END;
$$;

CREATE OR REPLACE PROCEDURE sp_update_personal_biblioteca(
    p_id_personal INT,
    p_rol VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE personal_biblioteca
    SET rol = p_rol
    WHERE id_personal = p_id_personal;
END;
$$;

CREATE OR REPLACE PROCEDURE sp_delete_personal_biblioteca(p_id_personal INT)
LANGUAGE plpgsql
AS $$
BEGIN
    DELETE FROM personal_biblioteca WHERE id_personal = p_id_personal;
END;
$$;

-- 4. Tabla editorial

CREATE OR REPLACE PROCEDURE sp_insert_editorial(
    p_nombre VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO editorial(nombre)
    VALUES (p_nombre);
END;
$$;

CREATE OR REPLACE PROCEDURE sp_update_editorial(
    p_id_editorial INT,
    p_nombre VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE editorial
    SET nombre = p_nombre
    WHERE id_editorial = p_id_editorial;
END;
$$;

CREATE OR REPLACE PROCEDURE sp_delete_editorial(p_id_editorial INT)
LANGUAGE plpgsql
AS $$
BEGIN
    DELETE FROM editorial WHERE id_editorial = p_id_editorial;
END;
$$;

-- 5. Tabla categoria

CREATE OR REPLACE PROCEDURE sp_insert_categoria(
    p_nombre VARCHAR,
    p_descripcion TEXT
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO categoria(nombre, descripcion)
    VALUES (p_nombre, p_descripcion);
END;
$$;

CREATE OR REPLACE PROCEDURE sp_update_categoria(
    p_id_categoria INT,
    p_nombre VARCHAR,
    p_descripcion TEXT
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE categoria
    SET nombre = p_nombre,
        descripcion = p_descripcion
    WHERE id_categoria = p_id_categoria;
END;
$$;

CREATE OR REPLACE PROCEDURE sp_delete_categoria(p_id_categoria INT)
LANGUAGE plpgsql
AS $$
BEGIN
    DELETE FROM categoria WHERE id_categoria = p_id_categoria;
END;
$$;

-- 6. Tabla autor

CREATE OR REPLACE PROCEDURE sp_insert_autor(
    p_nombre VARCHAR,
    p_nacionalidad VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO autor(nombre, nacionalidad)
    VALUES (p_nombre, p_nacionalidad);
END;
$$;

CREATE OR REPLACE PROCEDURE sp_update_autor(
    p_id_autor INT,
    p_nombre VARCHAR,
    p_nacionalidad VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE autor
    SET nombre = p_nombre,
        nacionalidad = p_nacionalidad
    WHERE id_autor = p_id_autor;
END;
$$;

CREATE OR REPLACE PROCEDURE sp_delete_autor(p_id_autor INT)
LANGUAGE plpgsql
AS $$
BEGIN
    DELETE FROM autor WHERE id_autor = p_id_autor;
END;
$$;

-- 7. Tabla libro

CREATE OR REPLACE PROCEDURE sp_insert_libro(
    p_titulo VARCHAR,
    p_id_editorial INT,
    p_id_categoria INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO libro(titulo, id_editorial, id_categoria)
    VALUES (p_titulo, p_id_editorial, p_id_categoria);
END;
$$;

CREATE OR REPLACE PROCEDURE sp_update_libro(
    p_id_libro INT,
    p_titulo VARCHAR,
    p_id_editorial INT,
    p_id_categoria INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE libro
    SET titulo = p_titulo,
        id_editorial = p_id_editorial,
        id_categoria = p_id_categoria
    WHERE id_libro = p_id_libro;
END;
$$;

CREATE OR REPLACE PROCEDURE sp_delete_libro(p_id_libro INT)
LANGUAGE plpgsql
AS $$
BEGIN
    DELETE FROM libro WHERE id_libro = p_id_libro;
END;
$$;

-- 8. Tabla libro_autor

CREATE OR REPLACE PROCEDURE sp_insert_libro_autor(
    p_id_libro INT,
    p_id_autor INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO libro_autor(id_libro, id_autor)
    VALUES (p_id_libro, p_id_autor);
END;
$$;

CREATE OR REPLACE PROCEDURE sp_delete_libro_autor(
    p_id_libro INT,
    p_id_autor INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    DELETE FROM libro_autor
    WHERE id_libro = p_id_libro AND id_autor = p_id_autor;
END;
$$;

-- 9. Tabla copia

CREATE OR REPLACE PROCEDURE sp_insert_copia(
    p_id_libro INT,
    p_codigo_barra VARCHAR,
    p_estado VARCHAR,
    p_ubicacion TEXT,
    p_cantidad INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO copia(id_libro, codigo_barra, estado, ubicacion, cantidad)
    VALUES (p_id_libro, p_codigo_barra, p_estado, p_ubicacion, p_cantidad);
END;
$$;

CREATE OR REPLACE PROCEDURE sp_update_copia(
    p_id_copia INT,
    p_estado VARCHAR,
    p_ubicacion TEXT,
    p_cantidad INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE copia
    SET estado = p_estado,
        ubicacion = p_ubicacion,
        cantidad = p_cantidad
    WHERE id_copia = p_id_copia;
END;
$$;

CREATE OR REPLACE PROCEDURE sp_delete_copia(p_id_copia INT)
LANGUAGE plpgsql
AS $$
BEGIN
    DELETE FROM copia WHERE id_copia = p_id_copia;
END;
$$;

-- 10. Tabla prestamo

CREATE OR REPLACE PROCEDURE sp_insert_prestamo(
    p_id_socio INT,
    p_id_copia INT,
    p_fecha_prestamo DATE,
    p_fecha_devolucion_esperada DATE
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO prestamo(id_socio, id_copia, fecha_prestamo, fecha_devolucion_esperada)
    VALUES (p_id_socio, p_id_copia, p_fecha_prestamo, p_fecha_devolucion_esperada);
END;
$$;

CREATE OR REPLACE PROCEDURE sp_update_prestamo(
    p_id_prestamo INT,
    p_fecha_devolucion_esperada DATE
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE prestamo
    SET fecha_devolucion_esperada = p_fecha_devolucion_esperada
    WHERE id_prestamo = p_id_prestamo;
END;
$$;

CREATE OR REPLACE PROCEDURE sp_delete_prestamo(p_id_prestamo INT)
LANGUAGE plpgsql
AS $$
BEGIN
    DELETE FROM prestamo WHERE id_prestamo = p_id_prestamo;
END;
$$;

-- 11. Tabla devolucion

CREATE OR REPLACE PROCEDURE sp_insert_devolucion(
    p_id_prestamo INT,
    p_fecha_real_devolucion DATE,
    p_estado VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO devolucion(id_prestamo, fecha_real_devolucion, estado)
    VALUES (p_id_prestamo, p_fecha_real_devolucion, p_estado);
END;
$$;

CREATE OR REPLACE PROCEDURE sp_update_devolucion(
    p_id_devolucion INT,
    p_fecha_real_devolucion DATE,
    p_estado VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE devolucion
    SET fecha_real_devolucion = p_fecha_real_devolucion,
        estado = p_estado
    WHERE id_devolucion = p_id_devolucion;
END;
$$;

CREATE OR REPLACE PROCEDURE sp_delete_devolucion(p_id_devolucion INT)
LANGUAGE plpgsql
AS $$
BEGIN
    DELETE FROM devolucion WHERE id_devolucion = p_id_devolucion;
END;
$$;

-- 12. Tabla reserva

CREATE OR REPLACE PROCEDURE sp_insert_reserva(
    p_id_socio INT,
    p_id_copia INT,
    p_fecha_reserva DATE,
    p_estado VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO reserva(id_socio, id_copia, fecha_reserva, estado)
    VALUES (p_id_socio, p_id_copia, p_fecha_reserva, p_estado);
END;
$$;

CREATE OR REPLACE PROCEDURE sp_update_reserva(
    p_id_reserva INT,
    p_estado VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE reserva
    SET estado = p_estado
    WHERE id_reserva = p_id_reserva;
END;
$$;

CREATE OR REPLACE PROCEDURE sp_delete_reserva(p_id_reserva INT)
LANGUAGE plpgsql
AS $$
BEGIN
    DELETE FROM reserva WHERE id_reserva = p_id_reserva;
END;
$$;

-- 13. Tabla multa

CREATE OR REPLACE PROCEDURE sp_insert_multa(
    p_id_socio INT,
    p_monto NUMERIC,
    p_motivo TEXT,
    p_fecha DATE,
    p_estado VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO multa(id_socio, monto, motivo, fecha, estado)
    VALUES (p_id_socio, p_monto, p_motivo, p_fecha, p_estado);
END;
$$;

CREATE OR REPLACE PROCEDURE sp_update_multa(
    p_id_multa INT,
    p_monto NUMERIC,
    p_motivo TEXT,
    p_estado VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE multa
    SET monto = p_monto,
        motivo = p_motivo,
        estado = p_estado
    WHERE id_multa = p_id_multa;
END;
$$;

CREATE OR REPLACE PROCEDURE sp_delete_multa(p_id_multa INT)
LANGUAGE plpgsql
AS $$
BEGIN
    DELETE FROM multa WHERE id_multa = p_id_multa;
END;
$$;


```