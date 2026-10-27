# Instrucciones de Instalación y Ejecución

Documento de configuración del proyecto **Sistema de Venta de Computadoras**.

---

## 1. Descripción del Proyecto

Este repositorio contiene la base de datos y la API REST para un sistema de venta de computadoras. Incluye:

- Diseño conceptual y lógico (DER, modelo relacional, diccionario de datos).
- Scripts SQL para crear la base de datos, tablas, datos de prueba y procedimientos almacenados.
- Documentación de las rutas/endpoints de la API.

---

## 2. Prerrequisitos

### Opcción A: XAMPP (Recomendado para estudiantes)

- **XAMPP 8.x** (versión LTS).
- Gestor de base de datos: **phpMyAdmin** (incluido en XAMPP).
- Navegador web (Chrome, Firefox, Edge, etc.).
- Editor de texto o IDE: **VS Code**.

### Opcion B: MySQL CLI

- **MySQL Server 8.0+**.
- Cliente MySQL en línea de comandos (`mysql`).
- Herramientas adicionales: **Git**, **Node.js** (si se requiere correr la API).

---

## 3. Instalación del entorno

### Paso 1: Instalar XAMPP

1. Descargar e instalar XAMPP desde [https://www.apachefriends.org/](https://www.apachefriends.org/).
2. Ejecutar el **panel de control de XAMPP**.
3. Iniciar los servicios:
   - **Apache** (para el servidor web)
   - **MySQL** (para la base de datos)

### Paso 2: Crear la base de datos

1. Abrir phpMyAdmin: `http://localhost/phpmyadmin`
2. Hacer clic en **Nueva**.
3. Nombre de la base de datos: `venta_computadoras`
4. Conjunto de caracteres (collation): `utf8mb4_general_ci`
5. Hacer clic en **Crear**.

### Paso 3: Importar los scripts SQL

1. En phpMyAdmin, seleccionar la base de datos `venta_computadoras`.
2. Ir a la pestaña **Importar**.
3. Seleccionar el archivo `01_CREACION_TABLAS.sql` y hacer clic en **Ejecutar**.
4. Repetir para `02_INSERT_DATOS_TEST.sql` y `03_PROCEDIMIENTOS.sql`.

> ⚠️ El orden es importante: primero las tablas, luego los datos de prueba y finalmente los procedimientos.

---

## 4. Verificar la instalación

### Consultas de verificación en SQL

```sql
-- Listar tablas
SHOW TABLES;

-- Ver estructura de producto
DESCRIBE productos;

-- Ver datos de prueba
SELECT * FROM productos LIMIT 5;
SELECT * FROM clientes LIMIT 5;
SELECT * FROM ventas LIMIT 5;
SELECT * FROM detalles_venta LIMIT 5;
SELECT * FROM proveedores LIMIT 5;
```

### Verificar procedimientos almacenados

```sql
SHOW PROCEDURE STATUS WHERE Db = 'venta_computadoras';
```

---

## 5. Pruebas de la API

### Asumiendo que se ejecuta un servidor en `localhost:3000`

```bash
# Listar todos los productos
curl http://localhost:3000/api/productos

# Obtener un producto por ID
curl http://localhost:3000/api/productos/1

# Crear un cliente
curl -X POST http://localhost:3000/api/clientes \
  -H "Content-Type: application/json" \
  -d '{
    "nombre": "Juan Pérez",
    "telefono": "987654321",
    "direccion": "Calle Principal 123",
    "email": "juan@example.com"
  }'

# Crear una venta
curl -X POST http://localhost:3000/api/ventas \
  -H "Content-Type: application/json" \
  -d '{
    "id_cliente": 1,
    "id_empleado": 1,
    "fecha": "2026-10-27",
    "total": 2500000
  }'
```

### Verificar con el navegador

- `http://localhost:3000/api/productos`
- `http://localhost:3000/api/clientes`
- `http://localhost:3000/api/ventas`

---

## 6. Estructura de la carpeta `database/`

| Archivo | Descripción |
|---|---|
| `01_CREACION_TABLAS.sql` | DDL: `CREATE TABLE`, `PRIMARY KEY`, `FOREIGN KEY`, `CHECK`, `ENGINE`, `CHARACTER SET` |
| `02_INSERT_DATOS_TEST.sql` | DML: Inserción de clientes, productos, proveedores y ventas de prueba |
| `03_PROCEDIMIENTOS.sql` | Procedimientos almacenados para ventas y consultas de reporte |

---

## 7. Puesta en producción (opcional)

Si se desea desplegar en un servidor:

1. Instalar **MySQL** o **XAMPP** en el servidor.
2. Configurar el servidor web (Apache/Nginx).
3. Subir los archivos de la API a la carpeta raíz del servidor.
4. Configurar el archivo `.env` con las credenciales de la base de datos.
5. Arrancar los servicios y verificar la conectividad.

Ejemplo de archivo `.env`:

```env
DB_HOST=localhost
DB_USER=root
DB_PASSWORD=
DB_NAME=venta_computadoras
```

---

## 8. Consideraciones de seguridad

- Cambiar la contraseña de la base de datos de root por defecto.
- Restringir el acceso remoto a la base de datos.
- Usar `HTTPS` en entornos de producción.
- Validar y escapar todas las entradas de la API.
- No exponer credenciales en el código fuente.

---

## 9. Resolución de problemas comunes

| Problema | Solución |
|---|---|
| Base de datos no encontrada | Verificar que `DB_NAME` coincida con `venta_computadoras` y que el script se haya importado correctamente |
| Error de credenciales | Verificar `DB_USER` y `DB_PASSWORD` en `.env` |
| Puerto en uso | Cambiar el puerto en `server.js` de `3000` a otro (ej. `3001`) |
| Error de llaves foráneas | Asegurarse de que las tablas se creen en el orden correcto (sin FKs primero) |

---

## 10. Licencia

Proyecto académico de la asignatura **Ingeniería Web**.
