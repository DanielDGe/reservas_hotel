final dbHelper = DatabaseHelper.instance;

// Eliminar un cliente
await dbHelper.eliminarCliente(1);

// Eliminar una habitación
await dbHelper.eliminarHabitacion(1);

// Eliminar una reserva
await dbHelper.eliminarReserva(1);
