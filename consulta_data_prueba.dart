final dbHelper = DatabaseHelper.instance;

final clientes = await dbHelper.obtenerClientes();
print(clientes);

final habitaciones = await dbHelper.obtenerHabitaciones();
print(habitaciones);

final reservas = await dbHelper.obtenerReservas();
print(reservas);

final reservasDeCliente = await dbHelper.obtenerReservasPorCliente(1); // Para cliente con id 1
print(reservasDeCliente);
