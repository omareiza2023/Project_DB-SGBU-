
-- 1. Tabla persona (superclase para todos)
CREATE TABLE persona (
    id_persona SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    correo VARCHAR(100) UNIQUE,
    telefono VARCHAR(20),
    direccion TEXT
);

-- 2. Tabla socio (extiende persona)
CREATE TABLE socio (
    id_socio SERIAL PRIMARY KEY,
    id_persona INT UNIQUE REFERENCES persona(id_persona) ON UPDATE CASCADE ON DELETE RESTRICT,
    tipo_socio VARCHAR(50) NOT NULL
);

-- 3. Tabla personal_biblioteca (extiende persona)
CREATE TABLE personal_biblioteca (
    id_personal SERIAL PRIMARY KEY,
    id_persona INT UNIQUE REFERENCES persona(id_persona) ON UPDATE CASCADE ON DELETE RESTRICT,
    rol VARCHAR(100) NOT NULL
);

-- 4. Tabla editorial
CREATE TABLE editorial (
    id_editorial SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);

-- 5. Tabla categoria
CREATE TABLE categoria (
    id_categoria SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT
);

-- 6. Tabla autor
CREATE TABLE autor (
    id_autor SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    nacionalidad VARCHAR(50)
);

-- 7. Tabla libro
CREATE TABLE libro (
    id_libro SERIAL PRIMARY KEY,
    titulo VARCHAR(200) NOT NULL,
    id_editorial INT REFERENCES editorial(id_editorial) ON UPDATE CASCADE ON DELETE RESTRICT,
    id_categoria INT REFERENCES categoria(id_categoria) ON UPDATE CASCADE ON DELETE RESTRICT
);

-- 8. Tabla libro_autor (pivote libro-autor)
CREATE TABLE libro_autor (
Id_libro_autor SERIAL PRIMARY KEY,
    id_libro INT REFERENCES libro(id_libro) ON UPDATE CASCADE ON DELETE RESTRICT,
    id_autor INT REFERENCES autor(id_autor) ON UPDATE CASCADE ON DELETE RESTRICT,
    PRIMARY KEY (id_libro, id_autor)
);

-- 9. Tabla copia (cada copia física de un libro)
CREATE TABLE copia (
    id_copia SERIAL PRIMARY KEY,
    id_libro INT REFERENCES libro(id_libro) ON UPDATE CASCADE ON DELETE RESTRICT,
    codigo_barra VARCHAR(50) UNIQUE NOT NULL,
    estado VARCHAR(50) NOT NULL, -- Disponible, Prestado, Reservado, Dañado
    ubicacion TEXT
);

-- 10. Tabla inventario (control de cantidad de ejemplares por libro)
CREATE TABLE inventario (
    id_inventario SERIAL PRIMARY KEY,
    id_libro INT UNIQUE REFERENCES libro(id_libro) ON UPDATE CASCADE ON DELETE RESTRICT,
    cantidad INT NOT NULL CHECK (cantidad >= 0)
);

-- 11. Tabla prestamo
CREATE TABLE prestamo (
    id_prestamo SERIAL PRIMARY KEY,
    id_socio INT REFERENCES socio(id_socio) ON UPDATE CASCADE ON DELETE RESTRICT,
    id_copia INT REFERENCES copia(id_copia) ON UPDATE CASCADE ON DELETE RESTRICT,
    fecha_prestamo DATE NOT NULL,
    fecha_devolucion_esperada DATE NOT NULL
);

-- 12. Tabla devolucion
CREATE TABLE devolucion (
    id_devolucion SERIAL PRIMARY KEY,
    id_prestamo INT UNIQUE REFERENCES prestamo(id_prestamo) ON UPDATE CASCADE ON DELETE RESTRICT,
    fecha_real_devolucion DATE NOT NULL,
    estado VARCHAR(50) NOT NULL -- A tiempo, Retrasada, Dañado
);

-- 13. Tabla reserva
CREATE TABLE reserva (
    id_reserva SERIAL PRIMARY KEY,
    id_socio INT REFERENCES socio(id_socio) ON UPDATE CASCADE ON DELETE RESTRICT,
    id_copia INT REFERENCES copia(id_copia) ON UPDATE CASCADE ON DELETE RESTRICT,
    fecha_reserva DATE NOT NULL,
    estado VARCHAR(50) NOT NULL -- Activa, Cancelada, Expirada
);

-- 14. Tabla multa
CREATE TABLE multa (
    id_multa SERIAL PRIMARY KEY,
    id_socio INT REFERENCES socio(id_socio) ON UPDATE CASCADE ON DELETE RESTRICT,
    monto DECIMAL(10,2) NOT NULL CHECK (monto >= 0),
    motivo TEXT,
    fecha DATE NOT NULL,
    estado VARCHAR(50) NOT NULL -- Pagada, Pendiente
);

-- 15. Tabla historial_prestamo
CREATE TABLE historial_prestamo (
    id_historial SERIAL PRIMARY KEY,
    id_socio INT REFERENCES socio(id_socio) ON UPDATE CASCADE ON DELETE RESTRICT,
    id_copia INT REFERENCES copia(id_copia) ON UPDATE CASCADE ON DELETE RESTRICT,
    fecha_prestamo DATE NOT NULL,
    fecha_devolucion DATE,
    observaciones TEXT
);

-- 16. Tabla auditoria_general
CREATE TABLE auditoria_general (
    id_auditoria SERIAL PRIMARY KEY,
    tabla_afectada TEXT NOT NULL,
    operacion TEXT NOT NULL,
    usuario TEXT NOT NULL DEFAULT CURRENT_USER,
    fecha TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    datos_anteriores JSONB,
    datos_nuevos JSONB
);
