-- 1. persona
INSERT INTO persona (nombre, apellido, correo, telefono, direccion) VALUES
('Juan', 'Pérez', 'juan.perez@mail.com', '123456789', 'Calle 1, Ciudad'),
('Ana', 'García', 'ana.garcia@mail.com', '987654321', 'Calle 2, Ciudad'),
('Luis', 'Martínez', 'luis.martinez@mail.com', '555666777', 'Calle 3, Ciudad'),
('María', 'López', 'maria.lopez@mail.com', '444555666', 'Calle 4, Ciudad'),
('Carlos', 'Sánchez', 'carlos.sanchez@mail.com', '333222111', 'Calle 5, Ciudad');

-- 2. socio (asumiendo que las personas anteriores tienen ids 1 a 5)
INSERT INTO socio (id_persona, tipo_socio, fecha_alta, fecha_baja) VALUES
(1, 'Estudiante', '2023-01-10', NULL),
(2, 'Profesor', '2022-09-15', NULL),
(3, 'Estudiante', '2023-02-20', NULL),
(4, 'Profesor', '2021-11-01', NULL),
(5, 'Estudiante', '2023-03-05', NULL);

-- 3. rol_personal
INSERT INTO rol_personal (nombre_rol) VALUES
('Bibliotecario'),
('Auxiliar'),
('Administrador'),
('Técnico'),
('Recepcionista');

-- 4. personal_biblioteca (personas 6 a 10 que vamos a insertar ahora)
INSERT INTO persona (nombre, apellido, correo, telefono, direccion) VALUES
('Laura', 'Torres', 'laura.torres@mail.com', '111222333', 'Calle 6, Ciudad'),
('Miguel', 'Vargas', 'miguel.vargas@mail.com', '222333444', 'Calle 7, Ciudad'),
('Sofia', 'Ramírez', 'sofia.ramirez@mail.com', '333444555', 'Calle 8, Ciudad'),
('Diego', 'Flores', 'diego.flores@mail.com', '444555666', 'Calle 9, Ciudad'),
('Elena', 'Ruiz', 'elena.ruiz@mail.com', '555666777', 'Calle 10, Ciudad');

INSERT INTO personal_biblioteca (id_persona, id_rol, usuario, contraseña, fecha_alta, fecha_baja) VALUES
(6, 1, 'laura.t', 'pass123', '2022-01-01', NULL),
(7, 2, 'miguel.v', 'pass123', '2021-05-15', NULL),
(8, 3, 'sofia.r', 'pass123', '2023-01-10', NULL),
(9, 4, 'diego.f', 'pass123', '2022-09-20', NULL),
(10, 5, 'elena.r', 'pass123', '2023-03-05', NULL);

-- 5. editorial
INSERT INTO editorial (nombre, direccion) VALUES
('Editorial Alfa', 'Av. Siempre Viva 123'),
('Editorial Beta', 'Calle Falsa 456'),
('Editorial Gamma', 'Av. Central 789'),
('Editorial Delta', 'Calle Luna 101'),
('Editorial Épsilon', 'Av. Sol 202');

-- 6. categoria
INSERT INTO categoria (nombre, descripcion) VALUES
('Ciencia', 'Libros relacionados con ciencias naturales y exactas'),
('Literatura', 'Obras literarias clásicas y modernas'),
('Historia', 'Textos históricos y biografías'),
('Tecnología', 'Libros sobre informática y tecnología'),
('Arte', 'Libros de arte, pintura y escultura');

-- 7. autor
INSERT INTO autor (nombre, nacionalidad) VALUES
('Gabriel García Márquez', 'Colombiana'),
('Isabel Allende', 'Chilena'),
('J.K. Rowling', 'Británica'),
('Stephen King', 'Estadounidense'),
('Jane Austen', 'Británica');

-- 8. libro
INSERT INTO libro (titulo, id_editorial, id_categoria) VALUES
('Cien años de soledad', 1, 2),
('La casa de los espíritus', 2, 2),
('Harry Potter y la piedra filosofal', 3, 2),
('El resplandor', 4, 2),
('Orgullo y prejuicio', 5, 2);

-- 9. libro_autor (relación libro-autor)
INSERT INTO libro_autor (id_libro, id_autor) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

-- 10. copia
INSERT INTO copia (id_libro, codigo_barra, estado, ubicacion) VALUES
(1, 'COD-0001', 'Disponible', 'Estante A1'),
(1, 'COD-0002', 'Prestado', 'Estante A1'),
(2, 'COD-0003', 'Disponible', 'Estante B3'),
(3, 'COD-0004', 'Disponible', 'Estante C2'),
(4, 'COD-0005', 'Dañado', 'Estante D5');

-- 11. prestamo
INSERT INTO prestamo (id_socio, id_copia, fecha_prestamo, fecha_devolucion_esperada) VALUES
(1, 2, '2023-04-01', '2023-04-15'),
(3, 3, '2023-04-03', '2023-04-17'),
(2, 4, '2023-04-05', '2023-04-20'),
(5, 1, '2023-04-06', '2023-04-21'),
(4, 5, '2023-04-07', '2023-04-22');

-- 12. devolucion
INSERT INTO devolucion (id_prestamo, fecha_real_devolucion, estado) VALUES
(1, '2023-04-14', 'A tiempo'),
(2, '2023-04-18', 'Retrasada'),
(3, '2023-04-20', 'A tiempo'),
(4, '2023-04-21', 'A tiempo'),
(5, '2023-04-23', 'Dañado');

-- 13. reserva
INSERT INTO reserva (id_socio, id_copia, fecha_reserva, estado) VALUES
(1, 1, '2023-04-10', 'Activa'),
(2, 2, '2023-04-11', 'Cancelada'),
(3, 3, '2023-04-12', 'Expirada'),
(4, 4, '2023-04-13', 'Activa'),
(5, 5, '2023-04-14', 'Activa');

-- 14. multa
INSERT INTO multa (id_socio, monto, motivo, fecha, estado) VALUES
(1, 10.00, 'Devolución tardía', '2023-04-18', 'Pendiente'),
(3, 5.00, 'Libro dañado', '2023-04-20', 'Pagada'),
(2, 7.50, 'Devolución tardía', '2023-04-19', 'Pendiente'),
(4, 3.00, 'Pérdida de libro', '2023-04-22', 'Pagada'),
(5, 12.00, 'Devolución tardía', '2023-04-21', 'Pendiente');

-- 15. historial_prestamo
INSERT INTO historial_prestamo (id_socio, id_copia, fecha_prestamo, fecha_devolucion, observaciones) VALUES
(1, 1, '2023-01-01', '2023-01-15', 'Libro en buen estado'),
(2, 2, '2023-02-01', '2023-02-20', 'Libro con marcas'),
(3, 3, '2023-03-01', '2023-03-15', 'Devolución a tiempo'),
(4, 4, '2023-03-10', '2023-03-25', 'Devolución con demora'),
(5, 5, '2023-04-01', NULL, 'Préstamo activo');

-- tabla 15 y 16 no requieren inserciones ya que ellas se llenan en funcion de las otras tablas:
