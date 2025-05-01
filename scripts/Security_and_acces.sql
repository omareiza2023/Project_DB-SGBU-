-- Crear usuarios
CREATE USER admin WITH PASSWORD '123';
CREATE USER bibliotecario WITH PASSWORD '123';
CREATE USER socio;

-- Crear roles
CREATE ROLE admin_rol;
CREATE ROLE bibliotecario_rol;
CREATE ROLE socio_rol;

-- Permisos para admin_rol: acceso total a base de datos, tablas y secuencias
GRANT ALL PRIVILEGES ON DATABASE project_bd TO admin_rol;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO admin_rol;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO admin_rol;

-- Permisos para bibliotecario_rol: acceso limitado con lectura y modificación
GRANT CONNECT ON DATABASE project_bd TO bibliotecario_rol;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO bibliotecario_rol;
GRANT INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO bibliotecario_rol;

-- Permisos para socio_rol: solo puede consultar tablas específicas
GRANT SELECT ON inventario TO socio_rol;
GRANT SELECT ON libros TO socio_rol;
GRANT SELECT ON categorias TO socio_rol;

-- Asignación de roles a usuarios
GRANT admin_rol TO admin;
GRANT bibliotecario_rol TO bibliotecario;
GRANT socio_rol TO socio;
