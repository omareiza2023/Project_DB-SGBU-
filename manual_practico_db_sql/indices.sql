-- 1. Buscar una persona por nombre
SELECT * FROM persona WHERE nombre = 'Juan';
-- Índice usado: idx_persona_nombre

-- 2. Buscar una persona por apellido
SELECT * FROM persona WHERE apellido = 'Pérez';
-- Índice usado: idx_persona_apellido

-- 3. Buscar una persona por correo electrónico
SELECT * FROM persona WHERE correo = 'juan.perez@example.com';
-- Índice usado: idx_persona_correo

-- 4. Buscar socios por tipo
SELECT * FROM socio WHERE tipo_socio = 'Regular';
-- Índice usado: idx_socio_tipo

-- 5. Buscar personal de biblioteca por rol
SELECT * FROM personal_biblioteca WHERE rol = 'Bibliotecario';
-- Índice usado: idx_personal_rol

-- 6. Buscar editoriales por nombre
SELECT * FROM editorial WHERE nombre = 'Editorial XYZ';
-- Índice usado: idx_editorial_nombre

-- 7. Buscar categorías por nombre
SELECT * FROM categoria WHERE nombre = 'Ficción';
-- Índice usado: idx_categoria_nombre

-- 8. Buscar autores por nombre
SELECT * FROM autor WHERE nombre = 'Gabriel García Márquez';
-- Índice usado: idx_autor_nombre

-- 9. Buscar libros por título
SELECT * FROM libro WHERE titulo = 'Cien Años de Soledad';
-- Índice usado: idx_libro_titulo

-- 10. Buscar libros por editorial
SELECT * FROM libro WHERE id_editorial = 1;
-- Índice usado: idx_libro_editorial

-- 11. Buscar libros por categoría
SELECT * FROM libro WHERE id_categoria = 2;
-- Índice usado: idx_libro_categoria

-- 12. Buscar libros por autor (a través de la tabla pivote libro_autor)
SELECT libro.titulo
FROM libro
JOIN libro_autor ON libro.id_libro = libro_autor.id_libro
JOIN autor ON libro_autor.id_autor = autor.id_autor
WHERE autor.nombre = 'Gabriel García Márquez';
-- Índices usados: idx_libro_autor_idlibro, idx_libro_autor_idautor, idx_autor_nombre

-- 13. Buscar copias de un libro
SELECT * FROM copia WHERE id_libro = 1;
-- Índice usado: idx_copia_idlibro

-- 14. Buscar copias por estado
SELECT * FROM copia WHERE estado = 'Disponible';
-- Índice usado: idx_copia_estado

-- 15. Buscar préstamos por socio
SELECT * FROM prestamo WHERE id_socio = 1;
-- Índice usado: idx_prestamo_idsocio

-- 16. Buscar préstamos por copia
SELECT * FROM prestamo WHERE id_copia = 1;
-- Índice usado: idx_prestamo_idcopia

-- 17. Buscar devoluciones por préstamo
SELECT * FROM devolucion WHERE id_prestamo = 1;
-- Índice usado: idx_devolucion_idprestamo

-- 18. Buscar reservas por socio
SELECT * FROM reserva WHERE id_socio = 1;
-- Índice usado: idx_reserva_idsocio

-- 19. Buscar reservas por copia
SELECT * FROM reserva WHERE id_copia = 1;
-- Índice usado: idx_reserva_idcopia

-- 20. Buscar reservas por estado
SELECT * FROM reserva WHERE estado = 'Activa';
-- Índice usado: idx_reserva_estado

-- 21. Buscar multas por socio
SELECT * FROM multa WHERE id_socio = 1;
-- Índice usado: idx_multa_idsocio

-- 22. Buscar multas por estado
SELECT * FROM multa WHERE estado = 'Pendiente';
-- Índice usado: idx_multa_estado

-- 23. Buscar historial de préstamos por socio
SELECT * FROM historial_prestamo WHERE id_socio = 1;
-- Índice usado: idx_historial_idsocio

-- 24. Buscar historial de préstamos por copia
SELECT * FROM historial_prestamo WHERE id_copia = 1;
-- Índice usado: idx_historial_idcopia

-- 25. Buscar auditoría general por tabla afectada
SELECT * FROM auditoria_general WHERE tabla_afectada = 'libro';
-- Índice usado: idx_auditoria_tabla

-- 26. Buscar auditoría general por fecha
SELECT * FROM auditoria_general WHERE fecha BETWEEN '2025-01-01' AND '2025-12-31';
-- Índice usado: idx_auditoria_fecha
