final dbHelper = DatabaseHelper.instance;

// Insertar un cliente
await dbHelper.insertarCliente({
  'nombre': 'Juan',
  'apellido': 'Pérez',
  'email': 'juan.perez@gmail.com',
  'telefono': '123456789'
});

// Insertar una habitación
await dbHelper.insertarHabitacion({
  'numero_habitacion': 101,
  'tipo_habitacion': 'Doble',
  'precio_por_noche': 80.00,
  'estado': 'disponible'
});

// Insertar una reserva
await dbHelper.insertarReserva({
  'cliente_id': 1, // Asumiendo que el cliente con id 1 fue insertado antes
  'habitacion_id': 1, // Asumiendo que la habitación con id 1 fue insertada antes
  'fecha_entrada': '2024-10-23 14:00:00',
  'fecha_salida': '2024-10-25 12:00:00',
  'estado': 'reservada'
});
