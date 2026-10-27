# 📖 Diccionario de Datos

## Definición de Campos

Este documento describe cada campo de las tablas de la base de datos del sistema de venta de computadoras.

---

## 1. Tabla `categorias`

| Campo | Tipo | Descripción | Requerido | Default |
|---|---|---|---|---|
| `id_categoria` | INT | Identificador único de la categoría | Sí | Auto-increment |
| `nombre_categoria` | VARCHAR(100) | Nombre de la categoría (GPU, procesador, computadora, accesorios) | Sí | NULL |
| `descripcion` | TEXT | Descripción detallada de la categoría | No | NULL |

---

## 2. Tabla `proveedores`

| Campo | Tipo | Descripción | Requerido | Default |
|---|---|---|---|---|
| `id_proveedor` | INT | Identificador único del proveedor | Sí | Auto-increment |
| `nombre` | VARCHAR(150) | Nombre comercial del proveedor | Sí | NULL |
| `telefono` | VARCHAR(20) | Teléfono de contacto | No | NULL |
| `direccion` | VARCHAR(255) | Dirección completa del proveedor | No | NULL |
| `email` | VARCHAR(100) | Correo electrónico del proveedor | Sí | NULL |

---

## 3. Tabla `productos`

| Campo | Tipo | Descripción | Requerido | Default |
|---|---|---|---|---|
| `id_producto` | INT | Identificador único del producto | Sí | Auto-increment |
| `nombre` | VARCHAR(150) | Nombre del producto (e.g. "Intel Core i5") | Sí | NULL |
| `descripcion` | TEXT | Descripción detallada del producto | No | NULL |
| `precio_unitario` | DECIMAL(10,2) | Precio de venta del producto | Sí | NULL |
| `stock` | INT | Cantidad disponible en inventario | Sí | NULL |
| `stock_minimo` | INT | Stock mínimo para alertar de reabastecimiento | Sí | 0 |
| `id_proveedor` | INT | Proveedor del producto (FK) | Sí | NULL |
| `id_categoria` | INT | Categoría a la que pertenece (FK) | Sí | NULL |
| `fecha_registro` | DATE | Fecha de entrada del producto al inventario | Sí | NULL |

---

## 4. Tabla `clientes`

| Campo | Tipo | Descripción | Requerido | Default |
|---|---|---|---|---|
| `id_cliente` | INT | Identificador único del cliente | Sí | Auto-increment |
| `nombre` | VARCHAR(150) | Nombre del cliente | Sí | NULL |
| `telefono` | VARCHAR(20) | Teléfono de contacto | Sí | NULL |
| `direccion` | VARCHAR(255) | Dirección de entrega | No | NULL |
| `email` | VARCHAR(100) | Correo electrónico | Sí | NULL |

---

## 5. Tabla `vendedores`

| Campo | Tipo | Descripción | Requerido | Default |
|---|---|---|---|---|
| `id_vendedor` | INT | Identificador único del vendedor | Sí | Auto-increment |
| `nombre` | VARCHAR(150) | Nombre del vendedor | Sí | NULL |
| `departamento` | VARCHAR(100) | Departamento al que pertenece | No | NULL |
| `email` | VARCHAR(100) | Correo electrónico | Sí | NULL |

---

## 6. Tabla `ventas`

| Campo | Tipo | Descripción | Requerido | Default |
|---|---|---|---|---|
| `id_venta` | INT | Identificador único de la venta | Sí | Auto-increment |
| `id_cliente` | INT | Cliente que realizó la compra (FK) | Sí | NULL |
| `id_vendedor` | INT | Vendedor que registró la venta (FK) | Sí | NULL |
| `fecha_venta` | DATETIME | Fecha y hora de la venta | Sí | NULL |
| `total` | DECIMAL(10,2) | Total de la venta (suma de detalles) | Sí | NULL |
| `metodo_pago` | VARCHAR(50) | Forma de pago (Efectivo, Transferencia, Tarjeta) | Sí | NULL |
| `estado` | VARCHAR(20) | Estado de la venta (Pendiente, Pagada, Cancelada) | Sí | 'Pendiente' |

---

## 7. Tabla `detalles_venta`

| Campo | Tipo | Descripción | Requerido | Default |
|---|---|---|---|---|
| `id_detalle` | INT | Identificador único del detalle | Sí | Auto-increment |
| `id_venta` | INT | Venta a la que pertenece (FK) | Sí | NULL |
| `id_producto` | INT | Producto vendido (FK) | Sí | NULL |
| `cantidad` | INT | Cantidad vendida | Sí | NULL |
| `precio_unitario` | DECIMAL(10,2) | Precio unitario al momento de la venta | Sí | NULL |
| `subtotal` | DECIMAL(10,2) | subtotal = cantidad * precio_unitario | Sí | NULL |

---

## 8. Reglas de Nomenclatura

- **Tablas**: en minúsculas, plural (e.g. `productos`, `clientes`).
- **Campos**: en minúsculas, con guión bajo para separar palabras (e.g. `id_categoria`, `fecha_registro`).
- **Llaves primarias**: `id_<tabla>`.
- **Llaves foráneas**: `id_<tabla_relacionada>`.
- **Tipos de datos**: `DECIMAL(10,2)` para dinero, `INT` para IDs y cantidades, `VARCHAR` con longitud razonable, `TEXT` para descripciones largas.

---

## 9. Uso de los Campos

| Entidad | Uso principal |
|---|---|
| `categorias` | Clasificación jerárquica de productos |
| `proveedores` | Información de suministros y contacto |
| `productos` | Catálogo de la tienda |
| `clientes` | Datos de compradores |
| `vendedores` | Personal que realiza ventas |
| `ventas` | Registro de cada compra |
| `detalles_venta` | Detalle de los productos por venta |

---

## 10. Comentarios sobre la Nomenclatura de Campos

- **Prefijo FK**: todos los campos que hacen referencia a otras tablas usan el prefijo `id_<tabla>`.
- **Unidades**: cantidades en `detalles_venta` se almacenan en unidades (no en docenas). El `subtotal` se calcula como `cantidad * precio_unitario`.
- **Precio**: `precio_unitario` en `productos` es el precio de venta habitual; `precio_unitario` en `detalles_venta` es el precio aplicado en esa transacción específica.

---

> **Nota:** Este diccionario es parte de la documentación del proyecto y se encuentra en la carpeta `DOCUMENTACION/` del repositorio.
