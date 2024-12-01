-- Crear la base de datos
CREATE DATABASE IF NOT EXISTS zapatos;
USE zapatos;

-- Tabla zapatos
CREATE TABLE IF NOT EXISTS zapatos (
    id_zapato INT AUTO_INCREMENT PRIMARY KEY,
    modelo VARCHAR(255) NOT NULL,
    tamaño ENUM('42', '43', '44', '45', '46'),
    color VARCHAR(100),
    material VARCHAR(100),
    fecha_lanzamiento DATE,
    estado ENUM('Nuevo', 'Usado', 'Reparado')
);

-- Tabla usuarios
CREATE TABLE IF NOT EXISTS usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    correo VARCHAR(255) UNIQUE NOT NULL,
    fecha_registro DATE NOT NULL
);

-- Tabla interacciones
CREATE TABLE IF NOT EXISTS interacciones (
    id_interaccion INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT,
    id_zapato INT,
    tipo_interaccion ENUM('compra', 'ajuste', 'reparacion') NOT NULL,
    fecha DATE NOT NULL,
    detalle TEXT,
    ubicacion VARCHAR(255),
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_zapato) REFERENCES zapatos(id_zapato) ON DELETE CASCADE
);

-- Tabla componentes
CREATE TABLE IF NOT EXISTS componentes (
    id_componente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    descripcion TEXT,
    fabricante VARCHAR(255),
    fecha_fabricacion DATE
);

-- Relación zapatos-componentes
CREATE TABLE IF NOT EXISTS zapato_componentes (
    id_zapato INT,
    id_componente INT,
    cantidad INT DEFAULT 1,
    FOREIGN KEY (id_zapato) REFERENCES zapatos(id_zapato) ON DELETE CASCADE,
    FOREIGN KEY (id_componente) REFERENCES componentes(id_componente) ON DELETE CASCADE,
    PRIMARY KEY (id_zapato, id_componente)
);

-- Tabla mantenimiento
CREATE TABLE IF NOT EXISTS mantenimiento (
    id_mantenimiento INT AUTO_INCREMENT PRIMARY KEY,
    id_zapato INT,
    tipo ENUM('limpieza', 'reparación', 'ajuste'),
    fecha DATE NOT NULL,
    costo DECIMAL(10, 2),
    descripcion TEXT,
    FOREIGN KEY (id_zapato) REFERENCES zapatos(id_zapato) ON DELETE CASCADE
);

-- INSERTAR DATOS

-- Insertar datos en la tabla zapatos
INSERT INTO zapatos (modelo, tamaño, color, material, fecha_lanzamiento, estado)
VALUES
    ('Nike Air MAG 2015', '42', 'Gris/Blanco', 'Sintético', '2015-10-21', 'Nuevo'),
    ('Nike Air MAG 2045', '45', 'Gris/Negro', 'Sintético', '2045-07-15', 'Nuevo'),
	('Nike Air MAG 2025', '43', 'Gris/Azul', 'Sintético', '2025-06-15', 'Nuevo'),
    ('Nike Air MAG 2030', '44', 'Negro/Plateado', 'Sintético', '2030-11-20', 'Usado'),
    ('Nike HyperAdapt 1.0', '42', 'Negro/Blanco', 'Sintético', '2016-12-01', 'Reparado');
    
-- Insertar datos en la tabla usuarios
INSERT INTO usuarios (nombre, correo, fecha_registro)
VALUES
    ('Marty McFly', 'marty.mcfly@futurama.com', '2024-11-06'),
    ('Doc Brown', 'doc.brown@futurama.com', '2024-11-06'),
    ('Jennifer Parker', 'jennifer.parker@futurama.com', '2024-11-10'),
    ('Biff Tannen', 'biff.tannen@futurama.com', '2024-11-12'),
    ('Lorraine McFly', 'lorraine.mcfly@futurama.com', '2024-11-15');

-- Insertar datos en la tabla componentes
INSERT INTO componentes (nombre, descripcion, fabricante, fecha_fabricacion)
VALUES
    ('Motor de ajuste', 'Motor pequeño que ajusta los cordones automáticamente.', 'Nike Tech', '2015-01-15'),
    ('Batería de litio', 'Batería recargable para alimentar el sistema de ajuste.', 'Tesla Power', '2015-05-10'),
    ('Sistema de ajuste avanzado', 'Nueva generación de motores más silenciosos.', 'Nike Tech', '2025-01-01'),
    ('Pantalla LED integrada', 'Pantalla para mostrar nivel de batería.', 'Tesla Displays', '2024-08-10'),
    ('Sensores de presión', 'Detecta el tamaño del pie para ajustar automáticamente.', 'Nike Labs', '2023-04-15');

-- Relacionar componentes con los zapatos
INSERT INTO zapato_componentes (id_zapato, id_componente, cantidad)
VALUES
    (1, 1, 2),
    (1, 2, 1),
    (2, 1, 2),
    (2, 2, 1),
    (3, 1, 1),
    (3, 3, 2),
    (4, 2, 1),
    (4, 3, 1),
    (5, 1, 1),
    (5, 2, 1),
    (5, 3, 1);

-- Insertar datos en la tabla mantenimiento
INSERT INTO mantenimiento (id_zapato, tipo, fecha, costo, descripcion)
VALUES
    (1, 'limpieza', '2024-11-10', 25.00, 'Limpieza básica y revisión del sistema de ajuste.'),
    (2, 'reparación', '2024-11-15', 100.00, 'Reparación de los motores de ajuste.'),
     (3, 'limpieza', '2024-11-12', 20.00, 'Limpieza general y revisión del sistema.'),
    (2, 'reparación', '2024-11-15', 150.00, 'Reparación del sistema de ajuste automático.'),
    (1, 'ajuste', '2024-11-18', 50.00, 'Ajuste de tamaño y revisión de sensores.'),
    (4, 'reparación', '2024-11-20', 120.00, 'Reparación de la pantalla LED integrada.'),
    (5, 'ajuste', '2024-11-22', 60.00, 'Ajuste del sistema de presión.');

-- Insertar datos en la tabla interacciones
INSERT INTO interacciones (id_usuario, id_zapato, tipo_interaccion, fecha, detalle, ubicacion)
VALUES
    (1, 1, 'compra', '2024-11-06', 'Compra de un par de Nike Air MAG 2015', 'Hill Valley, California'),
    (2, 2, 'ajuste', '2024-11-06', 'Ajuste de la talla en el modelo Nike Air MAG 2045', 'Lyon Estates, California'),
	(3, 3, 'compra', '2024-11-10', 'Compra de un par de Nike HyperAdapt 1.0', 'Hill Valley, California'),
    (4, 2, 'reparacion', '2024-11-12', 'Reparación del sistema de ajuste automático', 'Twin Pines Mall, California'),
    (5, 1, 'ajuste', '2024-11-15', 'Ajuste de tamaño en el modelo Nike Air MAG 2015', 'Lyon Estates, California'),
    (1, 4, 'compra', '2024-11-16', 'Compra de un par de Nike Air MAG 2025', 'Hill Valley, California'),
    (2, 5, 'reparacion', '2024-11-20', 'Reparación de batería en el modelo Nike Air MAG 2030', 'Clock Tower Plaza, California');
    
-- CONSULTAS

-- Listar todos los zapatos con sus componentes y cantidades
SELECT z.modelo, c.nombre AS componente, zc.cantidad
FROM zapato_componentes zc
JOIN zapatos z ON zc.id_zapato = z.id_zapato
JOIN componentes c ON zc.id_componente = c.id_componente
ORDER BY z.modelo;

-- Verificar el historial de mantenimiento
SELECT z.modelo, m.tipo, m.fecha, m.costo, m.descripcion
FROM mantenimiento m
JOIN zapatos z ON m.id_zapato = z.id_zapato
WHERE z.id_zapato = 1; -- Cambia "1" por el ID del zapato que quieras consultar.

-- Zapatos mas recientes ordenados por fecha de lanzamiento
SELECT modelo, tamaño, color, fecha_lanzamiento
FROM zapatos
ORDER BY fecha_lanzamiento DESC;

-- Mostrar usuarios con la cantidad de interacciones realizadas
SELECT u.nombre, COUNT(i.id_interaccion) AS total_interacciones
FROM usuarios u
LEFT JOIN interacciones i ON u.id_usuario = i.id_usuario
GROUP BY u.id_usuario
ORDER BY total_interacciones DESC;

-- Usuarios que hayan comprado zapatos
SELECT u.nombre, z.modelo, i.fecha, i.detalle
FROM interacciones i
JOIN usuarios u ON i.id_usuario = u.id_usuario
JOIN zapatos z ON i.id_zapato = z.id_zapato
WHERE i.tipo_interaccion = 'compra';

-- Listar todas las interaccion con detalle
SELECT i.id_interaccion, u.nombre AS usuario, z.modelo AS zapato, 
       i.tipo_interaccion, i.fecha, i.ubicacion, i.detalle
FROM interacciones i
JOIN usuarios u ON i.id_usuario = u.id_usuario
JOIN zapatos z ON i.id_zapato = z.id_zapato
ORDER BY i.fecha DESC;

-- Filtrar interacciones de tipo "ajuste" en un rango de fechas
SELECT i.id_interaccion, u.nombre AS usuario, z.modelo AS zapato, i.fecha, i.ubicacion
FROM interacciones i
JOIN usuarios u ON i.id_usuario = u.id_usuario
JOIN zapatos z ON i.id_zapato = z.id_zapato
WHERE i.tipo_interaccion = 'ajuste' 
  AND i.fecha BETWEEN '2024-01-01' AND '2024-12-31';

-- Listar todos los componentes y los zapatos donde se usan
SELECT c.nombre AS componente, c.descripcion, z.modelo
FROM zapato_componentes zc
JOIN componentes c ON zc.id_componente = c.id_componente
JOIN zapatos z ON zc.id_zapato = z.id_zapato
ORDER BY c.nombre;

-- Consultar componentes con mas de un uso por zapato
SELECT c.nombre AS componente, z.modelo, zc.cantidad
FROM zapato_componentes zc
JOIN componentes c ON zc.id_componente = c.id_componente
JOIN zapatos z ON zc.id_zapato = z.id_zapato
WHERE zc.cantidad > 1;

-- Zapatos con interacciones, mantenimiento y componentes
SELECT z.modelo, COUNT(DISTINCT i.id_interaccion) AS total_interacciones, 
       COUNT(DISTINCT m.id_mantenimiento) AS total_mantenimiento,
       COUNT(DISTINCT zc.id_componente) AS total_componentes
FROM zapatos z
LEFT JOIN interacciones i ON z.id_zapato = i.id_zapato
LEFT JOIN mantenimiento m ON z.id_zapato = m.id_zapato
LEFT JOIN zapato_componentes zc ON z.id_zapato = zc.id_zapato
GROUP BY z.id_zapato;

-- Usuarios con mas interacciones en un tipo especifico
SELECT u.nombre, i.tipo_interaccion, COUNT(i.id_interaccion) AS total_interacciones
FROM usuarios u
JOIN interacciones i ON u.id_usuario = i.id_usuario
WHERE i.tipo_interaccion = 'compra'
GROUP BY u.id_usuario, i.tipo_interaccion
ORDER BY total_interacciones DESC;

-- Gasto total en mantenimiento por zapato
SELECT z.modelo, SUM(m.costo) AS gasto_total
FROM mantenimiento m
JOIN zapatos z ON m.id_zapato = z.id_zapato
GROUP BY z.id_zapato
ORDER BY gasto_total DESC;
