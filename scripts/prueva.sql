-- 🔹 Inserción masiva en "persona"
INSERT INTO persona (nombre, apellido, correo, telefono, direccion)
SELECT 
    'Nombre_' || gs::TEXT,                             -- Nombre aleatorio
    'Apellido_' || gs::TEXT,                           -- Apellido aleatorio
    'correo_' || gs::TEXT || '@example.com',           -- Correo electrónico aleatorio
    '300' || (1000000 + gs)::TEXT,                     -- Teléfono aleatorio
    'Dirección ' || gs::TEXT                           -- Dirección aleatoria
FROM generate_series(1, 1000000) gs;

-- 🔹 Inserción masiva en "socio"
INSERT INTO socio (id_persona, tipo_socio)
SELECT 
    p.id_persona, 
    (ARRAY['Estudiante', 'Profesor'])[LEAST(1 + (random() * 2)::INTEGER, 2)] -- Control del rango del índice
FROM persona p
LEFT JOIN socio s ON s.id_persona = p.id_persona
WHERE s.id_persona IS NULL
LIMIT 1000000;

-- 🔹 Inserción masiva en "libro"
INSERT INTO libro (titulo, id_editorial, id_categoria)
SELECT 
    'Libro_' || gs::TEXT,             -- Título del libro
    (random() * 4 + 1)::INTEGER,     -- ID de editorial aleatorio (1 a 5)
    (random() * 4 + 1)::INTEGER      -- ID de categoría aleatoria (1 a 5)
FROM generate_series(1, 100) gs;


-- 🔹 Inserción masiva en "prestamo"
INSERT INTO prestamo (id_socio, id_copia, fecha_prestamo, fecha_devolucion_esperada)
SELECT 
    s.id_socio,                                       -- ID de socio existente
    (random() * 4 + 1)::INTEGER,                      -- ID de copia aleatorio (1 a 5)
    NOW()::DATE + (random() * 30)::INTEGER,           -- Fecha de préstamo aleatoria (hasta 30 días en el futuro)
    NOW()::DATE + (random() * 30)::INTEGER + 1 + (random() * 6)::INTEGER -- Fecha de devolución (1 a 7 días después)
FROM (
    SELECT id_socio 
    FROM socio 
    ORDER BY random()
    LIMIT 1000000
) s;


ANALYZE libro;
ANALYZE prestamo;
ANALYZE socio;
ANALYZE persona;
