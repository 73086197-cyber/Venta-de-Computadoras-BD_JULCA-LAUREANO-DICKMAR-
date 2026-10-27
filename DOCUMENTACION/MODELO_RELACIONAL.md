# 📐 Modelo Relacional de la Base de Datos

## Esquema de Tablas

Este documento presenta el modelo relacional de la base de datos del sistema de venta de computadoras.

---

## 1. Reglas de diseño

- Todas las tablas tienen una **llave primaria** compuesta o simple.
- Las **llaves foráneas** denotan las relaciones.
- Se aplican **restricciones `NOT NULL`** a los atributos obligatorios.
- Se usan **TIPOS DE DATOS ADECUADOS**:
  - `INT` para IDs
  - `DECIMAL(10,2)` para precios y totales
  - `DATE / DATETIME` para fechas
  - `VARCHAR` para texto
- Se usa **utf8mb4** y **InnoDB** como motor.

---

## 2. Tablas y Definiciones

### 2.1 Categorias

| Columna | Tipo | PK | FK | Notas |
|---|---|---|---|---|
| `id_categoria` | INT | Sí | No | Llave primaria |
| `nombre_categoria` | VARCHAR(100) | No | No | Única, no nula |
| `descripcion` | TEXT | No | No | |

**Restricciones:**
- `PRIMARY KEY (id_categoria)`
- `UNIQUE (nombre_categoria)`

---

### 2.2 Proveedores

| Columna | Tipo | PK | FK | Notas |
|---|---|---|---|---|
| `id_proveedor` | INT | Sí | No | Llave primaria |
| `nombre` | VARCHAR(150) | No | No | |
| `telefono` | VARCHAR(20) | No | No | |
| `direccion` | VARCHAR(255) | No | No | |
| `email` | VARCHAR(100) | No | No | |

**Restricciones:**
- `PRIMARY KEY (id_proveedor)`
- `UNIQUE (email)`

---

### 2.3 Productos

| Columna | Tipo | PK | FK | Notas |
|---|---|---|---|---|
| `id_producto` | INT | Sí | No | Llave primaria |
| `nombre` | VARCHAR(150) | No | No | |
| `descripcion` | TEXT | No | No | |
| `precio_unitario` | DECIMAL(10,2) | No | No | |
| `stock` | INT | No | No | |
| `stock_minimo` | INT | No | No | |
| `id_proveedor` | INT | No | Sí | |
| `id_categoria` | INT | No | Sí | |
| `fecha_registro` | DATE | No | No | |

**Restricciones:**
- `PRIMARY KEY (id_producto)`
- `FOREIGN KEY (id_proveedor) REFERENCES proveedores(id_proveedor)`
- `FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria)`
- `CHECK (stock >= 0)`
- `CHECK (stock_minimo >= 0)`

---

### 2.4 Clientes

| Columna | Tipo | PK | FK | Notas |
|---|---|---|---|---|
| `id_cliente` | INT | Sí | No | Llave primaria |
| `nombre` | VARCHAR(150) | No | No | |
| `telefono` | VARCHAR(20) | No | No | |
| `direccion` | VARCHAR(255) | No | No | |
| `email` | VARCHAR(100) | No | No | |

**Restricciones:**
- `PRIMARY KEY (id_cliente)`
- `UNIQUE (email)`

---

### 2.5 Vendedores

| Columna | Tipo | PK | FK | Notas |
|---|---|---|---|---|
| `id_vendedor` | INT | Sí | No | Llave primaria |
| `nombre` | VARCHAR(150) | No | No | |
| `departamento` | VARCHAR(100) | No | No | |
| `email` | VARCHAR(100) | No | No | |

**Restricciones:**
- `PRIMARY KEY (id_vendedor)`
- `UNIQUE (email)`

---

### 2.6 Ventas

| Columna | Tipo | PK | FK | Notas |
|---|---|---|---|---|
| `id_venta` | INT | Sí | No | Llave primaria |
| `id_cliente` | INT | No | Sí | |
| `id_vendedor` | INT | No | Sí | |
| `fecha_venta` | DATETIME | No | No | |
| `total` | DECIMAL(10,2) | No | No | |
| `metodo_pago` | VARCHAR(50) | No | No | |
| `estado` | VARCHAR(20) | No | No | |

**Restricciones:**
- `PRIMARY KEY (id_venta)`
- `FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)`
- `FOREIGN KEY (id_vendedor) REFERENCES vendedores(id_vendedor)`
- `CHECK (total >= 0)`
- `CHECK (estado IN ('Pendiente', 'Pagada', 'Cancelada'))`

---

### 2.7 Detalles_Venta

| Columna | Tipo | PK | FK | Notas |
|---|---|---|---|---|
| `id_detalle` | INT | Sí | No | Llave primaria |
| `id_venta` | INT | No | Sí | |
| `id_producto` | INT | No | Sí | |
| `cantidad` | INT | No | No | |
| `precio_unitario` | DECIMAL(10,2) | No | No | |
| `subtotal` | DECIMAL(10,2) | No | No | cantidad * precio_unitario |

**Restricciones:**
- `PRIMARY KEY (id_detalle)`
- `FOREIGN KEY (id_venta) REFERENCES ventas(id_venta)`
- `FOREIGN KEY (id_producto) REFERENCES productos(id_producto)`
- `CHECK (cantidad > 0)`
- `CHECK (precio_unitario > 0)`
- `CHECK (subtotal >= 0)`

---

## 3. Llaves Primarias y Foráneas

| Tabla | PK | FK |
|---|---|---|
| `categorias` | `id_categoria` | — |
| `proveedores` | `id_proveedor` | — |
| `clientes` | `id_cliente` | — |
| `vendedores` | `id_vendedor` | — |
| `productos` | `id_producto` | `id_proveedor`, `id_categoria` |
| `ventas` | `id_venta` | `id_cliente`, `id_vendedor` |
| `detalles_venta` | `id_detalle` | `id_venta`, `id_producto` |

---

## 4. Relaciones

| Relación | Tabla A | Tabla B | Tipo |
|---|---|---|---|
| Un cliente tiene muchas ventas | clientes | ventas | 1 : N |
| Un vendedor hace muchas ventas | vendedores | ventas | 1 : N |
| Una venta tiene muchos detalles | ventas | detalles_venta | 1 : N |
| Un producto aparece en muchos detalles | productos | detalles_venta | 1 : N |
| Un proveedor suma productos | proveedores | productos | 1 : N |
| Una categoría tiene muchos productos | categorias | productos | 1 : N |

---

## 5. Reglas de Negocio

1. **Stock**: no negativo.
2. **Stock mínimo**: `>= 0`.
3. **Cantidad en `detalles_venta`**: `> 0`.
4. **Precio**: no negativo.
5. **Total de venta**: `>= 0`.
6. **Estados válidos**: 'Pendiente', 'Pagada', 'Cancelada'.
7. **Unique** en email de clientes, vendedores y proveedores.

---

## 6. Índices Recomendados

```sql
CREATE INDEX idx_ventas_cliente ON ventas(id_cliente);
CREATE INDEX idx_ventas_vendedor ON ventas(id_vendedor);
CREATE INDEX idx_ventas_fecha ON ventas(fecha_venta);
CREATE INDEX idx_detalles_venta_producto ON detalles_venta(id_producto);
CREATE INDEX idx_detalles_venta_venta ON detalles_venta(id_venta);
CREATE INDEX idx_productos_proveedor ON productos(id_proveedor);
CREATE INDEX idx_productos_categoria ON productos(id_categoria);
```
