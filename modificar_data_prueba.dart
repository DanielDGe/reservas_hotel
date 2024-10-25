final dbHelper = DatabaseHelper.instance;

// Actualizar los datos de un cliente
await dbHelper.actualizarCliente(1, {
  'nombre': 'Juan',
  'apellido': 'González',
  'email': 'juan.gonzalez@gmail.com',
  'telefono': '987654321'
});

// Cambiar el estado de una habitación a "ocupada"
await dbHelper.actualizarEstadoHabitacion(1, 'ocupada');
