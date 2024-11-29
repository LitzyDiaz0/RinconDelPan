import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/usuario.dart';
import '../models/producto.dart';

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

        // Insertar usuario administrador por defecto
        await db.execute('''
        INSERT INTO usuario (nombre, telefono, usuario, contrasena, turno, rol) 
        VALUES ('Luna', '4493215678', 'admin', 'admin123', 'M', 'admin')
      ''');

        // Tabla de productos
        await db.execute('''
        CREATE TABLE producto(
            id_producto INTEGER PRIMARY KEY AUTOINCREMENT,
            imagen TEXT,
            nombre TEXT,
            sabor TEXT,
            precio REAL,
            stock INTEGER
          )
        ''');
      },
    );
  }

//-----------------METODOS USUARIO
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
      whereArgs: [usuario.idUsuario ?? -1],
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
  Future<Usuario?> obtenerUsuario(String usuario, String contrasena) async {
    final db = await database;
    final res = await db.query(
      'usuario',
      where: 'usuario = ? AND contrasena = ?',
      whereArgs: [usuario, contrasena],
    );
    if (res.isNotEmpty) {
      return Usuario.fromMap(res.first);
    } else {
      return null;
    }
  }

//------metodos productos
//-----------------METODOS PRODUCTOS
  // Insertar un nuevo producto
  Future<int> insertarProducto(Producto producto) async {
    final db = await database;
    return await db.insert('producto', producto.toMap());
  }

  // Obtener todos los productos
  Future<List<Producto>> obtenerProductos() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('producto');

    return List.generate(maps.length, (i) {
      return Producto.fromMap(maps[i]);
    });
  }

  // Obtener un producto por su ID
  Future<Producto?> obtenerProductoPorId(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'producto',
      where: 'id_producto = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Producto.fromMap(maps.first);
    }
    return null;
  }

  // Actualizar un producto
  Future<int> actualizarProducto(Producto producto) async {
    final db = await database;
    return await db.update(
      'producto',
      producto.toMap(),
      where: 'id_producto = ?',
      whereArgs: [producto.idProducto],
    );
  }

  // Eliminar un producto
  Future<int> eliminarProducto(int id) async {
    final db = await database;
    return await db.delete(
      'producto',
      where: 'id_producto = ?',
      whereArgs: [id],
    );
  }
}
