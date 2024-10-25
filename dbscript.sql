-- Crear tabla para clientes
CREATE TABLE IF NOT EXISTS clientes (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre TEXT NOT NULL,
    apellido TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    telefono TEXT,
    fecha_registro DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Crear tabla para habitaciones
CREATE TABLE IF NOT EXISTS habitaciones (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    numero_habitacion INTEGER NOT NULL UNIQUE,
    tipo_habitacion TEXT NOT NULL,
    precio_por_noche REAL NOT NULL,
    estado TEXT DEFAULT 'disponible'
);

-- Crear tabla para reservas
CREATE TABLE IF NOT EXISTS reservas (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    cliente_id INTEGER NOT NULL,
    habitacion_id INTEGER NOT NULL,
    fecha_entrada DATETIME NOT NULL,
    fecha_salida DATETIME NOT NULL,
    estado TEXT DEFAULT 'reservada',
    FOREIGN KEY (cliente_id) REFERENCES clientes(id),
    FOREIGN KEY (habitacion_id) REFERENCES habitaciones(id)
);
