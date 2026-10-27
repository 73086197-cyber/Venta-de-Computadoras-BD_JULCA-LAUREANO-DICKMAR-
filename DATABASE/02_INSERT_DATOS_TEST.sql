-- ============================================================================
-- SQL - DATOS DE PRUEBA (INSERT)
-- ============================================================================
-- Script DML para insertar datos de ejemplo en la base de datos
-- Base de datos: venta_computadoras
-- ============================================================================

-- --------------------------------------------------------------------
-- 1. INSERTAR EN categorias
-- --------------------------------------------------------------------

INSERT INTO categorias (nombre_categoria, descripcion)
VALUES
('Computadoras', 'Computadoras de escritorio y laptops con diferentes especificaciones'),
('Componentes', 'Componentes internos para montar o ampliar computadoras'),
('Accesorios', 'Teclados, monitores, ratones, audífono, etc'),
('Periféricos', 'Impresoras, escáneres y demás periféricos'),
('Software', 'Licencias y productos de software');

-- 10. INSERTAR EN ventas
-- --------------------------------------------------------------------

INSERT INTO ventas (id_cliente, id_vendedor, fecha_venta, total, metodo_pago, estado)
VALUES
(1, 1, '2024-06-10 10:30:00', 3500000, 'Efectivo', 'Pagada'),
(2, 2, '2024-06-11 14:45:00', 7500000, 'Transferencia', 'Pagada'),
(3, 3, '2024-06-12 09:20:00', 1500000, 'Efectivo', 'Pagada'),
(4, 1, '2024-06-13 16:10:00', 1100000, 'Tarjeta', 'Pendiente'),
(1, 2, '2024-06-14 11:00:00', 3500000, 'Transferencia', 'Pagada'),
(5, 3, '2024-06-15 13:30:00', 7500000, 'Tarjeta', 'Pagada'),
(6, 4, '2024-06-16 10:00:00', 3500000, 'Efectivo', 'Pagada'),
(7, 1, '2024-06-17 15:20:00', 2800000, 'Transferencia', 'Pagada'),
(8, 2, '2024-06-18 09:45:00', 1100000, 'Efectivo', 'Pagada'),
(1, 3, '2024-06-19 14:15:00', 1500000, 'Tarjeta', 'Pendiente');

-- 11. INSERTAR EN detalles_venta
-- --------------------------------------------------------------------

INSERT INTO detalles_venta (id_venta, id_producto, cantidad, precio_unitario, subtotal)
VALUES
(1, 1, 1, 3500000, 3500000),
(2, 2, 1, 7500000, 7500000),
(3, 4, 1, 350000, 350000),
(4, 8, 1, 950000, 950000),
(5, 1, 1, 3500000, 3500000),
(6, 2, 1, 7500000, 7500000),
(7, 4, 1, 350000, 350000),
(8, 11, 1, 2800000, 2800000),
(9, 7, 1, 650000, 650000),
(10, 4, 1, 350000, 350000);

-- 12. INSERTAR EN productos (para pruebas de stock)
-- --------------------------------------------------------------------

INSERT INTO productos (nombre, descripcion, precio_unitario, stock, stock_minimo, id_proveedor, id_categoria, fecha_registro)
VALUES
('Computadora Portátil Dell', 'Portátil Dell con Intel Core i5, 8GB RAM, 256GB SSD.', 2500000, 3, 2, 1, 1, '2024-08-01'),
('Monitor LED 27 pulgadas 4K', 'Monitor LED 27 pulgadas 4K HDR, 60Hz.', 2500000, 5, 2, 3, 1, '2024-08-05');

-- --------------------------------------------------------------------
-- Fin del script DML
-- ============================================================================

-- 8. INSERTAR EN clientes
-- --------------------------------------------------------------------

INSERT INTO clientes (nombre, telefono, direccion, email)
VALUES
('Juan Pérez García', '3001234567', 'Calle Falsa 123, Ciudad', 'juan.perez@gmail.com'),
('María López Sánchez', '3009876543', 'Carrera 45 # 10-20, Ciudad', 'maria.lopez@outlook.com'),
('Carlos Rodríguez Ruiz', '3105551212', 'Calle Central 789, Ciudad', 'carlos.rodriguez@gmail.com'),
('Ana Fernández Herrera', '3157778888', 'Callejón de los Arias 45, Ciudad', 'ana.fernandez@gmail.com'),
('Pedro Ramírez Ortiz', '3209990000', 'Avenida Principal 123, Ciudad', 'pedro.rios@gmail.com'),
('Laura Ortiz Carrillo', '3182223333', 'Calle Amistad 55, Ciudad', 'laura.ortiz@gmail.com'),
('Miguel Torres Ramírez', '3054445555', 'Callejón de la Luna 123, Ciudad', 'miguel.torres@gmail.com'),
('Sofía Ramírez Herrera', '3113334444', 'Carrera 60 # 5-10, Ciudad', 'sofia.ramirez@gmail.com');

-- 9. INSERTAR EN vendedores
-- --------------------------------------------------------------------

INSERT INTO vendedores (nombre, departamento, email)
VALUES
('José Castillo', 'Ventas Generales', 'jose.castillo@tienda.com'),
('Ana Torres', 'Ventas Digitales', 'ana.torres@tienda.com'),
('Carlos Mendoza', 'Ventas de Equipo', 'carlos.mendoza@tienda.com'),
('Laura Ramírez', 'Atención al Cliente', 'laura.ramirez@tienda.com');

-- 4. INSERTAR EN productos
-- --------------------------------------------------------------------

INSERT INTO productos (nombre, descripcion, precio_unitario, stock, stock_minimo, id_proveedor, id_categoria, fecha_registro)
VALUES
('Computadora de Escritorio Intel', 'Computadora de escritorio con procesador Intel Core i5, 8GB RAM, 512GB SSD y tarjeta gráfica integrada.', 3500000, 15, 5, 1, 1, '2024-01-15'),
('Laptop Gaming ASUS ROG', 'Laptop de gama alta con Ryzen 7, 16GB RAM, 1TB SSD y GPU NVIDIA GTX 1650.', 7500000, 8, 3, 2, 1, '2024-02-20'),
('Monitor LED 24 pulgadas', 'Monitor LED Full HD 24 pulgadas, 75Hz, sin marco.', 750000, 30, 5, 3, 1, '2024-03-10'),
('Teclado Mecánico RGB', 'Teclado mecánico con retroiluminación RGB, switches azules.', 350000, 40, 10, 4, 2, '2024-04-05'),
('Mouse Inalámbrico', 'Mouse inalámbrico inalámbrico con 2000 DPI, diseño ergonómico.', 150000, 100, 20, 4, 2, '2024-04-10'),
('Memoria RAM 8GB DDR4', 'Módulo de memoria RAM 8GB, velocidad 3200MHz, compatible con mostradores.', 250000, 25, 5, 4, 2, '2024-05-01'),
('Unidad SSD 512GB', 'Unidad SSD NVMe M.2 512GB para computadoras.', 650000, 20, 5, 2, 3, '2024-05-15'),
('Motherboard Intel B660', 'Motherboard Intel B660 para procesadores LGA1200.', 950000, 12, 3, 1, 2, '2024-06-01'),
('Procesador Intel Core i5-12400', 'Procesador Intel Core i5-12400 de 6 núcleos y 12 hilos.', 1200000, 18, 4, 1, 2, '2024-06-10'),
('Tarjeta de Sonido Realtek', 'Tarjeta de sonido integrada Realtek ALC897.', 180000, 30, 5, 4, 2, '2024-06-15'),
('Computadora Portátil HP', 'Portátil HP con procesador Intel Core i3, 8GB RAM, 256GB SSD.', 2800000, 10, 3, 3, 1, '2024-07-01'),
('Monitor Curvo 27 pulgadas', 'Monitor curvo Full HD 27 pulgadas, IPS, 75Hz.', 1100000, 15, 4, 3, 1, '2024-07-10');

-- --------------------------------------------------------------------
-- 2. INSERTAR EN proveedores
-- --------------------------------------------------------------------

INSERT INTO proveedores (nombre, telefono, direccion, email)
VALUES
('TechSupply S.A.', '555-1234', 'Calle de la Innovación 123, Ciudad', 'ventas@techsupply.com'),
('ByteElectronics', '555-5678', 'Av. de la Tecnología 456, Ciudad', 'info@byteelectronics.com'),
('ComputadoresPro S.A.', '555-9012', 'Calle del Mercado 789, Ciudad', 'contacto@computadorespro.com'),
('CyberParts Ltd.', '555-3456', 'Av. Industrial 321, Ciudad', 'sales@cyberparts.com');

