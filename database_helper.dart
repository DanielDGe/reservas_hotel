import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final _databaseName = "HotelDB.db";
  static final _databaseVersion = 1;

  static final tableClientes = 'clientes';
  static final tableHabitaciones = 'habitaciones';
  static final tableReservas = 'reservas';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableClientes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nombre TEXT NOT NULL,
        apellido TEXT NOT NULL,
        email TEXT UNIQUE NOT NULL,
        telefono TEXT,
        fecha_registro DATETIME DEFAULT CURRENT_TIMESTAMP
      )
    ''');

    await db.execute('''
      CREATE TABLE $tableHabitaciones (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        numero_habitacion INTEGER NOT NULL UNIQUE,
        tipo_habitacion TEXT NOT NULL,
        precio_por_noche REAL NOT NULL,
        estado TEXT DEFAULT 'disponible'
      )
    ''');

    await db.execute('''
      CREATE TABLE $tableReservas (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        cliente_id INTEGER NOT NULL,
        habitacion_id INTEGER NOT NULL,
        fecha_entrada DATETIME NOT NULL,
        fecha_salida DATETIME NOT NULL,
        estado TEXT DEFAULT 'reservada',
        FOREIGN KEY (cliente_id) REFERENCES $tableClientes (id),
        FOREIGN KEY (habitacion_id) REFERENCES $tableHabitaciones (id)
      )
    ''');
  }
  
  // Insertar un cliente
  Future<int> insertarCliente(Map<String, dynamic> cliente) async {
    Database db = await instance.database;
    return await db.insert(tableClientes, cliente);
  }

  // Insertar una habitación
  Future<int> insertarHabitacion(Map<String, dynamic> habitacion) async {
    Database db = await instance.database;
    return await db.insert(tableHabitaciones, habitacion);
  }

  // Insertar una reserva
  Future<int> insertarReserva(Map<String, dynamic> reserva) async {
    Database db = await instance.database;
    return await db.insert(tableReservas, reserva);
  }
  
  // Obtener todos los clientes
  Future<List<Map<String, dynamic>>> obtenerClientes() async {
    Database db = await instance.database;
    return await db.query(tableClientes);
  }

  // Obtener todas las habitaciones
  Future<List<Map<String, dynamic>>> obtenerHabitaciones() async {
    Database db = await instance.database;
    return await db.query(tableHabitaciones);
  }

  // Obtener todas las reservas
  Future<List<Map<String, dynamic>>> obtenerReservas() async {
    Database db = await instance.database;
    return await db.query(tableReservas);
  }

  // Obtener reservas por cliente
  Future<List<Map<String, dynamic>>> obtenerReservasPorCliente(int clienteId) async {
    Database db = await instance.database;
    return await db.query(tableReservas, where: 'cliente_id = ?', whereArgs: [clienteId]);
  }
  
  // Actualizar un cliente
  Future<int> actualizarCliente(int id, Map<String, dynamic> cliente) async {
    Database db = await instance.database;
    return await db.update(tableClientes, cliente, where: 'id = ?', whereArgs: [id]);
  }

  // Actualizar el estado de una habitación
  Future<int> actualizarEstadoHabitacion(int id, String estado) async {
    Database db = await instance.database;
    return await db.update(
      tableHabitaciones,
      {'estado': estado},
      where: 'id = ?',
      whereArgs: [id]
    );
  }
  
  // Eliminar un cliente por su id
  Future<int> eliminarCliente(int id) async {
    Database db = await instance.database;
    return await db.delete(tableClientes, where: 'id = ?', whereArgs: [id]);
  }

  // Eliminar una habitación por su id
  Future<int> eliminarHabitacion(int id) async {
    Database db = await instance.database;
    return await db.delete(tableHabitaciones, where: 'id = ?', whereArgs: [id]);
  }

  // Eliminar una reserva por su id
  Future<int> eliminarReserva(int id) async {
    Database db = await instance.database;
    return await db.delete(tableReservas, where: 'id = ?', whereArgs: [id]);
  }
  
}