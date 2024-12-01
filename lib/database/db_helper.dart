import 'package:logger/logger.dart';
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
      version: 2, // Asegúrate de incrementar la versión
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

        // Insertar usuario administrador por defecto
        await db.insert('usuario', {
          'nombre': 'Luna',
          'telefono': '4493215678',
          'usuario': 'admin',
          'contrasena': 'admin123',
          'turno': 'M',
          'rol': 'admin',
        });
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          // Si tienes que hacer alguna actualización, hazla aquí
          // Por ejemplo, agregar columnas o datos por defecto
        }
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
    int result = await db.update(
      'producto',
      producto.toMap(),
      where: 'id_producto = ?',
      whereArgs: [producto.idProducto],
    );
    // Log para verificar la actualización
    var logger = Logger();
    logger.i("Producto actualizado con éxito: ${producto.toMap()}");
    return result;
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
