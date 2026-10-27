# 📊 Diseño Conceptual de la Base de Datos

## DER — Diagrama de Entidad-Relación

El modelo entidad-relación describe el **mundo real** del negocio en términos de entidades, atributos y relaciones, sin considerar detalles de implementación (tabla, clave primaria, tipo de dato, etc.).

---

## Entidades Principales

### 1. **PRODUCTOS** (Computadoras y accesorios)
- Representa los artículos que se venden.
- Atributos: cod_producto, nombre, descripcion, precio_unitario, stock, id_proveedor.
- Tipo: tipo de producto (computadora, teclado, monitor, etc.).

### 2. **CLIENTES**
- Personas que compran productos.
- Atributos: id_cliente, nombre, telefono, direccion, email.

### 3. **VENDEDORES (EMPLEADOS)**
- Personal encargado de realizar las ventas.
- Atributos: id_empleado, nombre, departmento, email.

### 4. **VENTAS**
- Registro de cada venta realizada.
- Atributos: id_venta, id_cliente, id_empleado, fecha, total, metodo_pago.

### 5. **DETALLES_VENTA**
- Registro de los productos vendidos en cada venta.
- Atributos: id_detalle, id_venta, id_producto, cantidad, precio_unitario, subtotal.

### 6. **PROVEEDORES**
- Empresas que suministran los productos.
- Atributos: id_proveedor, nombre, telefono, direccion, email.

### 7. **CATEGORIAS**
- Clasificación de los productos.
- Atributos: id_categoria, nombre_categoria, descripcion.

---

## Relaciones

| Entidad | Relación | Cardinalidad |
|---|---|---|
| PRODUCTOS | UNO → MUCHOS | 1 : N con DETALLES_VENTA |
| CLIENTES | UNO → MUCHOS | 1 : N con VENTAS |
| VENDEDORES | UNO → MUCHOS | 1 : N con VENTAS |
| VENTAS | UNO → MUCHOS | 1 : N con DETALLES_VENTA |
| PROVEEDORES | UNO → MUCHOS | 1 : N con PRODUCTOS |
| CATEGORIAS | UNO → MUCHOS | 1 : N con PRODUCTOS |

---

## Reglas de Negocio Representadas

1. Un producto puede tener varios detalles de venta en diferentes ventas.
2. Una venta está asociada a un solo cliente y un solo vendedor.
3. Un cliente puede tener múltiples ventas.
4. Un vendedor puede registrar múltiples ventas.
5. Un proveedor proporciona uno o varios productos.
6. Un producto pertenece a una categoría.

---

## Modelo Conceptual (Resumen entidad-relación)

```text
        +----------------+        +----------------+
        |    PRODUCTOS   |1        | DETALLES_VENTA |
        +----------------+        +----------------+
        | cod_producto PK|<------->| id_detalle PK  |
        | nombre         |        | id_venta FK    |
        | precio_unitario|        | id_producto FK |
        | stock          |        | cantidad       |
        | id_proveedor FK|        | subtotal       |
        | id_categoria FK|        +----------------+
        +----------------+
              | 1
              | N
        +----------------+
        |  PROVEEDORES  |
        +----------------+
        | id_proveedor PK|
        | nombre         |
        | telefono       |
        | direccion      |
        | email          |
        +----------------+

        +----------------+        +----------------+
        |   CLIENTES     |1        |    VENTAS      |
        +----------------+        +----------------+
        | id_cliente PK  |<------->| id_venta PK    |
        | nombre         |        | id_cliente FK  |
        | telefono       |        | id_empleado FK |
        | direccion      |        | fecha          |
        | email          |        | total          |
        +----------------+        | metodo_pago    |
                                  +----------------+

        +----------------+        +----------------+
        |   VENDEDORES   |1        |    VENTAS      |
        +----------------+        | (relación 1:N) |
        | id_empleado PK |        +----------------+
        | nombre         |
        | departmento    |
        | email          |
        +----------------+

        +----------------+
        |   CATEGORIAS   |
        +----------------+
        | id_categoria PK|
        | nombre_categoria|
        | descripcion    |
        +----------------+
                              |
                              | 1
                              | N
        +----------------+        +----------------+
        |   PRODUCTOS   |-------|
        +----------------+

```

---

## Modelo Conceptual en Formato BD

- **Entidades** → tablas.
- **Atributos** → columnas.
- **Llaves primarias** → columnas que identifican de forma única.
- **Llaves foráneas** → columnas que hacen referencia a la llave primaria de otra tabla.
- **Relaciones** → se implementan con **llaves foráneas** y **reglas de integridad referencial**.

---

## Sincronización DER → Modelo Lógico

| DER | Modelo Lógico |
|---|---|
| Entidad (Entidad) | Tabla |
| Atributo | Columna |
| Llave primaria | `PRIMARY KEY` |
| Llave foránea | `FOREIGN KEY` |
| Relación 1:N | `FOREIGN KEY` + `REFERENCES` |
| Relación 1:1 | `UNIQUE` + `FOREIGN KEY` |
| Relación N:M | Tabla intermedia (relación compuesta) |

---

## Preguntas que responde el DER

1. ¿Qué tipos de entidades existen en el dominio del problema?
2. ¿Cuáles son las entidades principales y sus atributos?
3. ¿Cómo se relacionan entre sí las entidades?
4. ¿Qué atributos son identificadores?
5. ¿Qué reglas de negocio se representan?

---

## Modelo Conceptual → Modelo Lógico

El paso siguiente es transformar el DER en un **esquema relacional** (tablas, columnas, tipos de datos, llaves, restricciones). Para ello, consultar el archivo:

- **`MODELO_RELACIONAL.md`**

---

## Referencias

- El modelo conceptual se elabora mediante **UML** o **diagramas entidad-relación**.
- Las relaciones se implementan en el modelo relacional mediante **llaves foráneas**.
- Si aplica, se definen **restrict, cascade, set null** en las reglas de integridad referencial.

---

> **Nota:** El DER es independiente de la tecnología base de datos. Puede adaptarse a MySQL, PostgreSQL, SQL Server o Oracle.
