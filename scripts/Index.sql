
-- Índices para optimizar búsquedas y relaciones
-- Tabla persona
CREATE INDEX idx_persona_nombre ON persona (nombre);
CREATE INDEX idx_persona_apellido ON persona (apellido);
CREATE INDEX idx_persona_correo ON persona (correo);

-- Tabla socio
CREATE INDEX idx_socio_tipo ON socio (tipo_socio);

-- Tabla personal_biblioteca
CREATE INDEX idx_personal_rol ON personal_biblioteca (rol);

-- Tabla editorial
CREATE INDEX idx_editorial_nombre ON editorial (nombre);

-- Tabla categoria
CREATE INDEX idx_categoria_nombre ON categoria (nombre);

-- Tabla autor
CREATE INDEX idx_autor_nombre ON autor (nombre);

-- Tabla libro
CREATE INDEX idx_libro_titulo ON libro (titulo);
CREATE INDEX idx_libro_editorial ON libro (id_editorial);
CREATE INDEX idx_libro_categoria ON libro (id_categoria);

-- Tabla libro_autor (pivot)
CREATE INDEX idx_libro_autor_idlibro ON libro_autor (id_libro);
CREATE INDEX idx_libro_autor_idautor ON libro_autor (id_autor);

-- Tabla copia
CREATE INDEX idx_copia_idlibro ON copia (id_libro);
CREATE INDEX idx_copia_estado ON copia (estado);

-- Tabla prestamo
CREATE INDEX idx_prestamo_idsocio ON prestamo (id_socio);
CREATE INDEX idx_prestamo_idcopia ON prestamo (id_copia);

-- Tabla devolucion
CREATE INDEX idx_devolucion_idprestamo ON devolucion (id_prestamo);

-- Tabla reserva
CREATE INDEX idx_reserva_idsocio ON reserva (id_socio);
CREATE INDEX idx_reserva_idcopia ON reserva (id_copia);
CREATE INDEX idx_reserva_estado ON reserva (estado);

-- Tabla multa
CREATE INDEX idx_multa_idsocio ON multa (id_socio);
CREATE INDEX idx_multa_estado ON multa (estado);

-- Tabla historial_prestamo
CREATE INDEX idx_historial_idsocio ON historial_prestamo (id_socio);
CREATE INDEX idx_historial_idcopia ON historial_prestamo (id_copia);

-- Tabla auditoria_general
CREATE INDEX idx_auditoria_tabla ON auditoria_general (tabla_afectada);
CREATE INDEX idx_auditoria_fecha ON auditoria_general (fecha);

