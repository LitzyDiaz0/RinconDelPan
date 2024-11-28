import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/usuario.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  static Database? _database;

  // Abre la base de datos
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // Inicializa la base de datos
  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'panaderia.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE usuario(
            id_usuario INTEGER PRIMARY KEY AUTOINCREMENT,
            nombre TEXT,
            telefono TEXT,
            usuario TEXT,
            contrasena TEXT,
            turno TEXT,
            rol TEXT
          )
        ''');
      },
    );
  }

  // Insertar un nuevo usuario
  Future<int> insertarUsuario(Usuario usuario) async {
    final db = await database;
    return await db.insert('usuario', usuario.toMap());
  }

  // Obtener todos los usuarios
  Future<List<Usuario>> obtenerUsuarios() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('usuario');

    return List.generate(maps.length, (i) {
      return Usuario.fromMap(maps[i]);
    });
  }

  // Obtener un usuario por su ID
  Future<Usuario?> obtenerUsuarioPorId(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'usuario',
      where: 'id_usuario = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Usuario.fromMap(maps.first);
    }
    return null;
  }

  // Actualizar un usuario
  Future<int> actualizarUsuario(Usuario usuario) async {
    final db = await database;
    return await db.update(
      'usuario',
      usuario.toMap(),
      where: 'id_usuario = ?',
      whereArgs: [usuario.idUsuario],
    );
  }

  // Eliminar un usuario
  Future<int> eliminarUsuario(int id) async {
    final db = await database;
    return await db.delete(
      'usuario',
      where: 'id_usuario = ?',
      whereArgs: [id],
    );
  }

//obtenerUsuarioPorNombre
  Future<Usuario?> obtenerUsuarioPorNombre(String nombre) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'usuario', // Cambiado de 'usuarios' a 'usuario'
      where: 'usuario = ?',
      whereArgs: [nombre],
    );

    if (maps.isNotEmpty) {
      return Usuario.fromMap(maps.first);
    }
    return null;
  }
}
