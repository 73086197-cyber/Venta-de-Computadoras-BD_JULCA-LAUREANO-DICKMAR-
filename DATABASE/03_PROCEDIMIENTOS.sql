-- ============================================================================
-- SQL - PROCEDIMIENTOS ALMACENADOS
-- ============================================================================
-- Scripts de procedimientos almacenados para el sistema de ventas de computadoras
-- Base de datos: venta_computadoras
-- ============================================================================

-- --------------------------------------------------------------------
-- 1. SP_CREAR_VENTA
-- --------------------------------------------------------------------
-- Crea una venta y sus detalles en una sola transacción.
-- Esta es la operación principal del proceso de venta.
-- Parámetros:
--   p_id_cliente: ID del cliente que compra
--   p_id_vendedor: ID del vendedor que registra
--   p_fecha_venta: Fecha y hora de la venta
--   p_metodo_pago: Forma de pago (Efectivo, Transferencia, Tarjeta)
--   p_detalles: JSON con los productos (id_producto, cantidad)
-- Retorna:
--   id_venta: El ID de la venta creada
-- ============================================================================

DELIMITER $$

CREATE PROCEDURE sp_crear_venta(
    IN p_id_cliente INT,
    IN p_id_vendedor INT,
    IN p_fecha_venta DATETIME,
    IN p_metodo_pago VARCHAR(50),
    IN p_detalles JSON,
    OUT p_id_venta INT
)
BEGIN
    DECLARE v_id_producto INT;
    DECLARE v_cantidad INT;
    DECLARE v_precio_unitario DECIMAL(10,2);
    DECLARE v_subtotal DECIMAL(10,2);
    DECLARE v_venta_total DECIMAL(10,2) DEFAULT 0;

    DECLARE v_fin INT DEFAULT 0;
    DECLARE v_cursor CURSOR FOR
        SELECT
            JSON_UNQUOTE(JSON_EXTRACT(dato, '$.id_producto')) AS id_producto,
            JSON_UNQUOTE(JSON_EXTRACT(dato, '$.cantidad')) AS cantidad
        FROM JSON_TABLE(
            p_detalles,
            '$[*]' COLUMNS (dato JSON PATH '$')
        ) AS jt;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_fin = 1;

    START TRANSACTION;

    -- Insertar la cabecera de la venta
    INSERT INTO ventas (id_cliente, id_vendedor, fecha_venta, total, metodo_pago, estado)
    VALUES (p_id_cliente, p_id_vendedor, p_fecha_venta, 0, p_metodo_pago, 'Pendiente');

    SET p_id_venta = LAST_INSERT_ID();

    -- Recorrer los detalles y procesar cada uno
    OPEN v_cursor;

    read_loop: LOOP
        FETCH v_cursor INTO v_id_producto, v_cantidad;

        IF v_fin = 1 THEN
            LEAVE read_loop;
        END IF;

        -- Obtener precio unitario del producto
        SELECT precio_unitario INTO v_precio_unitario
        FROM productos
        WHERE id_producto = v_id_producto
        FOR UPDATE;

        -- Verificar stock
        SELECT stock INTO v_cantidad
        FROM productos
        WHERE id_producto = v_id_producto
        FOR UPDATE;

        IF v_cantidad < v_cantidad THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Stock insuficiente para el producto ' + v_id_producto;
            ROLLBACK;
            LEAVE read_loop;
        END IF;

        -- Calcular subtotal
        SET v_subtotal = v_precio_unitario * v_cantidad;

        -- Insertar detalle de venta
        INSERT INTO detalles_venta (id_venta, id_producto, cantidad, precio_unitario, subtotal)
        VALUES (p_id_venta, v_id_producto, v_cantidad, v_precio_unitario, v_subtotal);

        -- Actualizar total de la venta
        SET v_venta_total = v_venta_total + v_subtotal;

        -- Actualizar stock del producto
        UPDATE productos
        SET stock = stock - v_cantidad
        WHERE id_producto = v_id_producto;

    END LOOP;

    CLOSE v_cursor;

    -- Actualizar total final de la venta
    UPDATE ventas
    SET total = v_venta_total
    WHERE id_venta = p_id_venta;

    COMMIT;

    -- Devolver el ID de la venta creada
    SET p_id_venta = p_id_venta;

END$$


-- 2. SP_OBTENER_PRODUCTOS_CON_STOCK_Bajo
-- --------------------------------------------------------------------
-- Obtiene todos los productos con stock por debajo del mínimo.
-- Retorna:
--   id_producto, nombre, stock, stock_minimo, precio_unitario
-- ============================================================================

DELIMITER $$

CREATE PROCEDURE sp_obtener_productos_stock_bajo()
BEGIN
    SELECT
        id_producto,
        nombre,
        descripcion,
        precio_unitario,
        stock,
        stock_minimo,
        id_proveedor,
        id_categoria,
        fecha_registro
    FROM productos
    WHERE stock < stock_minimo
    ORDER BY stock ASC;
END$$

DELIMITER ;

-- 3. SP_OBTENER_GANANCIA_TOTAL
-- --------------------------------------------------------------------
-- Calcula la ganancia total de todas las ventas realizadas.
-- Retorna:
--   total_ventas: Total de ventas
--   total_productos: Total de productos vendidos
--   promedio_venta: Promedio por venta
-- ============================================================================

DELIMITER $$

CREATE PROCEDURE sp_obtener_ganancia_total()
BEGIN
    SELECT
        SUM(total) AS total_ventas,
        SUM(subtotal) AS total_productos,
        IFNULL(AVG(total), 0) AS promedio_venta
    FROM ventas
    WHERE estado = 'Pagada';
END$$

DELIMITER ;

-- 4. SP_OBTENER_VENTAS_POR_RANGO_Fechas
-- --------------------------------------------------------------------
-- Obtiene las ventas dentro de un rango de fechas.
-- Parámetros:
--   p_fecha_inicio: Fecha de inicio del rango
--   p_fecha_fin: Fecha de fin del rango
-- Retorna:
--   id_venta, id_cliente, id_vendedor, fecha_venta, total, metodo_pago
-- ============================================================================

DELIMITER $$

CREATE PROCEDURE sp_obtener_ventas_por_rango_fechas(
    IN p_fecha_inicio DATE,
    IN p_fecha_fin DATE
)
BEGIN
    SELECT
        id_venta,
        id_cliente,
        id_vendedor,
        fecha_venta,
        total,
        metodo_pago,
        estado
    FROM ventas
    WHERE fecha_venta >= p_fecha_inicio
      AND fecha_venta <= p_fecha_fin
    ORDER BY fecha_venta DESC;
END$$

DELIMITER ;

-- 5. SP_ACTUALIZAR_STOCK
-- --------------------------------------------------------------------
-- Actualiza el stock de un producto.
-- Parámetros:
--   p_id_producto: ID del producto a actualizar
--   p_cantidad: Cantidad a sumar (positiva) o restar (negativa)
-- ============================================================================

DELIMITER $$

CREATE PROCEDURE sp_actualizar_stock(
    IN p_id_producto INT,
    IN p_cantidad INT
)
BEGIN
    UPDATE productos
    SET stock = stock + p_cantidad
    WHERE id_producto = p_id_producto;

    IF ROW_COUNT() = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Producto no encontrado';
    END IF;
END$$

DELIMITER ;

-- 6. SP_OBTENER_VENTAS_DETALLADAS_POR_CLIENTE
-- --------------------------------------------------------------------
-- Obtiene las ventas detalladas de un cliente específico.
-- Parámetros:
--   p_id_cliente: ID del cliente
-- Retorna:
--   id_venta, fecha_venta, total, metodo_pago, estado,
--   nombre_producto, cantidad, precio_unitario, subtotal
-- ============================================================================

DELIMITER $$

CREATE PROCEDURE sp_obtener_ventas_detalladas_por_cliente(
    IN p_id_cliente INT
)
BEGIN
    SELECT
        v.id_venta,
        v.fecha_venta,
        v.total,
        v.metodo_pago,
        v.estado,
        p.id_producto,
        p.nombre AS nombre_producto,
        d.cantidad,
        d.precio_unitario,
        d.subtotal
    FROM ventas v
    JOIN detalles_venta d ON v.id_venta = d.id_venta
    JOIN productos p ON d.id_producto = p.id_producto
    WHERE v.id_cliente = p_id_cliente
    ORDER BY v.fecha_venta DESC;
END$$
